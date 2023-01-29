import 'dart:io';
import 'package:flutter/material.dart';

import 'package:document_scanner_flutter/document_scanner_flutter.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/models/doc_element.dart';

import '../services/doc_service.dart';

class ScannerPage extends StatefulWidget {
  const ScannerPage({super.key});

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  @override
  Widget build(BuildContext context) {
    var documentService = Provider.of<DocumentService>(context);
    var currentDocuments = documentService.documents;
    return Scaffold(
      appBar: AppBar(
        title: Text('File History'),
        centerTitle: true,
      ),
      body: Center(
        child: buildHistory(currentDocuments, documentService),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startScan(context, documentService),
        tooltip: 'Scan document',
        child: const Icon(Icons.document_scanner_outlined),
      ),
    );
  }

  Widget buildHistory(List<DocElement> elements, DocumentService documentService) {
    if (elements.isEmpty) {
      return const Text('You have not scanned a document yet');
    } else {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.separated(
          physics: BouncingScrollPhysics(),
            itemCount: elements.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(
                  'Doc $index',
                  style: const TextStyle(fontSize: 15),
                ),
                leading: Image(
                  fit: BoxFit.cover,
                  width: 50,
                  height: 50,
                  image: FileImage(elements[index].image),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    Dialog(context, documentService, elements, index);
                  }, 
                )
              );
            },
            separatorBuilder: (context, index) {
              return const Divider(
                color: Color.fromARGB(255, 165, 71, 12),
                thickness: 2,
              );
            } ,
          ),
      );
    }
  }

  Future<dynamic> Dialog(BuildContext context, DocumentService documentService, List<DocElement> elements, int index) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actions: [
            TextButton(
              child: Text("Cancel"),
              style: TextButton.styleFrom(
                  foregroundColor: Colors.grey[700]),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text("Delete"),
              style: TextButton.styleFrom(
                  foregroundColor: Colors.red),
              onPressed:  () { 
                Navigator.of(context).pop();
                documentService.deleteDocElement(elements[index]);
              },
            ),
          ],
          content: Text("Are you sure you want to delete this file?"),
        );
      }
    );
  }

  void _startScan(BuildContext context, DocumentService documentService) async {
    File? image = await DocumentScannerFlutter.launch(context);
    if (image != null) {
      documentService.saveOrCreateDocElement(
        DocElement(image: image, mark: 0, check: false, name: " "),
      );
    }
  }
}
