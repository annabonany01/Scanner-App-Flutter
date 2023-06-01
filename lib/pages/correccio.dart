import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/models/document.dart';
import 'package:qr_scanner/pages/doc_info.dart';
import '../services/document_service.dart';

class Correccio extends StatefulWidget {
  final String name;

  const Correccio({super.key, required this.name});
  @override
  State<Correccio> createState() => _CorreccioState();
}

class _CorreccioState extends State<Correccio> {
  @override
  Widget build(BuildContext context) {
    final documentService = Provider.of<DocumentService>(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: Text('Correcció'),
        backgroundColor: Color.fromARGB(255, 147, 203, 183),
        centerTitle: true,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            );
          },
        ),
      ),
      body: Center(
        child: _buildHistory(documentService),
      ),
    );
  }

  Widget _buildHistory(DocumentService documentService) {
    if (documentService.documents.isEmpty) {
      return const Text('Aquest estudiant no té cap document escanejat');
    } else {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.separated(
          physics: BouncingScrollPhysics(),
          itemCount: documentService.documents.where((element) => element.student == widget.name).length,
          itemBuilder: (BuildContext context, int index) {
            final documentIndex = documentService.documents.length - index;
            return ListTile(
              onTap: () async {
                Document updatedDocument = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Hero(
                      tag: documentService.documents[index],
                      child: DocInfo(
                        document: documentService.documents[index],
                      ),
                    ),
                  ),
                );
                setState(() {
                  documentService.documents[index].check = updatedDocument.check;
                });
              },
              title: Text(
                'Doc $documentIndex',
                style: const TextStyle(fontSize: 15),
              ),
              leading: GestureDetector(
                onTap: () {},
                child: Container(
                    width: 50,
                    height: 50,
                    child: getImage(documentService.documents[index].image!)),
              ),
              trailing: (documentService.documents[index].check == false)
                  ? Icon(
                      Icons.highlight_off_outlined,
                      color: Colors.red[600],
                    )
                  : Icon(
                      Icons.check_circle_outline_rounded,
                      color: Colors.green[600],
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
}
