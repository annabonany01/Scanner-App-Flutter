import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/models/document.dart';
import 'package:qr_scanner/pages/loading_screen.dart';
import '../services/document_service.dart';
import 'package:image_picker/image_picker.dart';

class ScannerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final documentService = Provider.of<DocumentService>(context);
    if (documentService.isLoading) return LoadingScreen();

    return Scaffold(
      body: Center(
        child: _buildHistory(documentService),
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

  Widget _buildHistory(DocumentService documentService) {
    if (documentService.documents.isEmpty) {
      return const Text('Encara no has escanejat cap document');
    } else {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.separated(
          physics: BouncingScrollPhysics(),
          itemCount: documentService.documents.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
                title: Text(
                  'Doc $index',
                  style: const TextStyle(fontSize: 15),
                ),
                leading: GestureDetector(
                  onTap: () {
                    DrawerImage(context,
                        documentService.documents[index].image!, 'Doc $index');
                  },
                  child: Container(
                      width: 50,
                      height: 50,
                      child: getImage(documentService.documents[index].image!)),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    Dialog(context, documentService, index);
                  },
                ));
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
            actions: [
              TextButton(
                child: Text("Cancel·lar"),
                style: TextButton.styleFrom(foregroundColor: Colors.grey[700]),
                onPressed: () => Navigator.of(context).pop(),
              ),
              TextButton(
                child: Text("Eliminar"),
                style: TextButton.styleFrom(foregroundColor: Colors.red),
                onPressed: () {
                  Navigator.of(context).pop();
                  documentService
                      .deleteDocument(documentService.documents[index]);
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
          title: Text(text),
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
    );
    if (pickedFile == null) {
      print('No seleccionó nada');
      return;
    } else {
      final file = File(pickedFile.path);
      documentService.newDocumentFile = file;
      String? imageUrl = await documentService.uploadImage();
      Document newdocument = new Document(image: imageUrl, mark: 0, check: false, id: null, student: null);
      await documentService.saveOrCreateDocument(newdocument);
      log('Document creat!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
      await documentService.loadLastDocument();
    }
  }
}
