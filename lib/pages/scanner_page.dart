import 'dart:io';

import 'package:document_scanner_flutter/document_scanner_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/models/document.dart';
import 'package:qr_scanner/pages/loading_screen.dart';
import '../services/document_service.dart';

class ScannerPage extends StatefulWidget {
  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  @override
  Widget build(BuildContext context) {
    final documentService = Provider.of<DocumentService>(context);
    if (documentService.isLoading) return LoadingScreen();

    return Scaffold(
      body: Center(
        child: buildHistory(documentService),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startScan(context, documentService),
        tooltip: 'Escanejar document',
        backgroundColor: Colors.purple[300],
        child: const Icon(Icons.photo_camera_outlined),
      ),
    );
  }

  Widget buildHistory(DocumentService documentService) {
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
                    child: Image.file(File(documentService.documents[index].image!)),
                  ),
                  ),
              
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    //Dialog(context, documentService, elements, index);
                  },
                )
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

  Future<dynamic> Dialog(BuildContext context, DocumentService documentService,
      List<Document> elements, int index) {
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
                  //documentService.deleteDocElement(elements[index]);
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
          content: Image(image: FileImage(File(image))),
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

  void _startScan(BuildContext context, DocumentService documentService) async {
    File? image = await DocumentScannerFlutter.launch(context);
    if (image != null) {
      documentService.saveOrCreateDocument(
        Document(
            image: image.path, mark: 0, check: false, id: null, student: null),
      );
      setState(() {
        //actualiza la pagina
        documentService.isLoading = true;
        documentService.updateLastDocument(documentService.documents.last);
        
      });
    }
  }
}
