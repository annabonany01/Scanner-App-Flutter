import 'package:flutter/material.dart';
import 'package:qr_scanner/models/document.dart';

class DocInfo extends StatelessWidget {
  final Document document;

  const DocInfo({super.key, required this.document});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: Text('Informació del document'),
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(Icons.change_circle_outlined, color: Colors.red[600]),
                  onPressed: () => {},
                  iconSize: 40,
                  ),
                  IconButton(
                  icon: Icon(Icons.check_circle_outlined, color: Colors.green[600]),
                  onPressed: () => {document.check = true, Navigator.pop(context)},
                  iconSize: 40,
                  ),
              ],
            ),
            SizedBox(height: 10),
            Container(
              height: 400,
              child: Center(
                child: Image.network(document.image!),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.green[600]),
                  onPressed: () => {},
                  iconSize: 50,
                  ),
                  IconButton(
                  icon: Icon(Icons.edit, color: Colors.orange[600]),
                  onPressed: () => {},
                  iconSize: 50,
                  ),
                  IconButton(
                  icon: Icon(Icons.edit, color: Colors.red[600]),
                  onPressed: () => {},
                  iconSize: 50,
                  ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(Icons.insert_comment_outlined, color: Colors.grey[700]),
                  onPressed: () => {},
                  iconSize: 50,
                  ),
                  IconButton(
                  icon: Icon(Icons.emoji_emotions_outlined, color: Colors.grey[700]),
                  onPressed: () => {},
                  iconSize: 50,
                  ),
              ],
            ),
          ],
        ),
      ),

    );
  }
}
