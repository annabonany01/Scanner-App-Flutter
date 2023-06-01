import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/models/document.dart';
import 'package:qr_scanner/models/student.dart';
import 'package:qr_scanner/models/student_list.dart';
import 'package:qr_scanner/pages/loading_screen.dart';
import 'package:qr_scanner/widgets/show_dialog_custom.dart';
import '../services/document_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

class ScannerPage extends StatefulWidget {
  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  final StudentList studentList = StudentList();
  String selectedStudent = 'No assignat';
  late ProgressDialog pr;

  @override
  Widget build(BuildContext context) {
    final documentService = Provider.of<DocumentService>(context);
    if (documentService.isLoading) return LoadingScreen();
    List<Student> students = studentList.students;
    List<String> studentsNames = students.map((e) => e.name).toList();
    studentsNames.sort((a, b) => a.compareTo(b));

    pr = ProgressDialog(context);
    pr.style(
      message: 'Carregant document...',
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      progressWidget: Container(
        padding: const EdgeInsets.all(8.0),
        child: CircularProgressIndicator(
          color: Color.fromARGB(255, 147, 203, 183),
          strokeWidth: 3,
        ),
      ),
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      progress: 0.0,
      maxProgress: 100.0,
      messageTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.w600,
      ),
    );

    return Scaffold(
      body: Center(
        child: _buildHistory(context, documentService, studentsNames, students),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _startCamera(context, documentService);
        },
        tooltip: 'Escanejar document',
        backgroundColor: Colors.purple[300],
        child: const Icon(Icons.photo_camera_outlined),
      ),
    );
  }

  Widget _buildHistory(BuildContext context, DocumentService documentService,
      List<String> studentsNames, List<Student> students) {
    String selectedStudent = 'No assignat';
    if (documentService.documents.isEmpty) {
      return const Text('Encara no has escanejat cap document');
    } else {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.separated(
          physics: BouncingScrollPhysics(),
          itemCount: documentService.documents.length,
          itemBuilder: (BuildContext context, int index) {
            final documentIndex = documentService.documents.length - index;
            return Container(
              child: ListTile(
                title: Text(
                  'Document $documentIndex',
                  style: const TextStyle(fontSize: 15),
                ),
                subtitle: (documentService.documents[index].student == null)
                    ? Text('Alumne no assignat', style: TextStyle(fontSize: 11))
                    : Text(
                        'Alumne: ${documentService.documents[index].student}',
                        style: TextStyle(fontSize: 11)),
                leading: GestureDetector(
                  onTap: () {
                    DrawerImage(
                        context,
                        documentService.documents[index].image!,
                        'Document ${index + 1}');
                  },
                  child: Container(
                      width: 50,
                      height: 50,
                      child: getImage(documentService.documents[index].image!)),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.person_add_alt_1_rounded),
                      tooltip: 'Assignar alumne',
                      onPressed: () {
                        ShowDialogCustom.showDialogCustom(
                            context,
                            'Selecciona un alumne:',
                            studentsNames,
                            selectedStudent, (value) async {
                          setState(() {
                            selectedStudent = value;
                            documentService.documents[index].student =
                                selectedStudent;
                          });
                          await documentService.updateDocument(documentService.documents[index]);
                        });
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      tooltip: 'Eliminar document',
                      onPressed: () {
                        Dialog(context, documentService, index);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const Divider(
              color: Color.fromARGB(255, 91, 176, 146),
              thickness: 2,
            );
          },
        ),
      );
    }
  }

  Future<dynamic> Dialog(
      BuildContext context, DocumentService documentService, int index) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            actions: [
              TextButton(
                child: Text("Cancel·lar"),
                style: TextButton.styleFrom(foregroundColor: Colors.grey[700]),
                onPressed: () => Navigator.of(context).pop(),
              ),
              TextButton(
                child: Text("Eliminar"),
                style: TextButton.styleFrom(foregroundColor: Colors.red),
                onPressed: () async {
                  Navigator.of(context).pop();
                  documentService.deleteDocument(documentService.documents[index]);
                },
              ),
            ],
            content: Text("Estàs segur que vols eliminar aquest document?"),
          );
        });
  }

  Future<dynamic> DrawerImage(BuildContext context, String image, String text) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          title:
              Text(text, style: TextStyle(color: Colors.black, fontSize: 17)),
          content: getImage(image),
          actions: [
            TextButton(
              child: Text('Cerrar', style: TextStyle(color: Colors.black)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget getImage(String? image) {
    if (image == null) {
      return Image(
        image: AssetImage('assets/no_image2.jpg'),
        fit: BoxFit.cover,
      );
    } else if (image.startsWith('http')) {
      return FadeInImage(
        placeholder: AssetImage('assets/loading.gif'),
        image: NetworkImage(image),
        fit: BoxFit.cover,
      );
    } else {
      Image.file(
        File(image),
        fit: BoxFit.cover,
      );
    }
    throw Exception('No s\'ha pogut carregar la imatge');
  }

  void _startCamera(
      BuildContext context, DocumentService documentService) async {
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 10,
    );
    if (pickedFile == null) {
      print('No seleccionó nada');
      return;
    } else {
      final file = File(pickedFile.path);
      documentService.newDocumentFile = file;
      await pr.show();
      String? imageUrl = await documentService.uploadImage();
      Document newdocument = Document(
          image: imageUrl, mark: null, check: false, id: null, student: null);
      await documentService.saveOrCreateDocument(newdocument);
      log('Document creat!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
      await documentService.loadLastDocument();
      setState(() {
      });
      await pr.hide();
    }
  }
}
