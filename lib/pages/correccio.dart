import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/pages/doc_info.dart';

import '../services/document_service.dart';

class Correccio extends StatelessWidget {
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
          itemCount: documentService.documents.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Hero(
                            tag: documentService.documents[index], 
                            child: DocInfo(
                              document: documentService.documents[index],
                            )))),
                title: Text(
                  'Doc $index',
                  style: const TextStyle(fontSize: 15),
                ),
                leading: GestureDetector(
                  onTap: () {},
                  child: Container(
                      width: 50,
                      height: 50,
                      child: Image.network(
                          documentService.documents[index].image!)),
                ),
                trailing: 
                (documentService.documents[index].check == false) 
                ? Icon(Icons.highlight_off_outlined, color: Colors.red[600],)
                 
                : Icon(Icons.check_circle_outline_rounded, color: Colors.green[600],),
                  

                
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
}
