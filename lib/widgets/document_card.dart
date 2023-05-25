import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_scanner/models/document.dart';

class DocumentCard extends StatelessWidget {

  final Document document;

  const DocumentCard({
    super.key,
    required this.document
  });


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        margin: EdgeInsets.only(top: 15, bottom: 10),
        width: double.infinity,
        height: 100,
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            _BackgroundImage(document.image),

            _DocumentDetails(
              title: document.id ?? 'No id',
            ),
          ],
        ),
      ),
    );
  }

}

class _BackgroundImage extends StatelessWidget {
  final String? url;
  const _BackgroundImage(this.url);
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Container(
        width: double.infinity,
        height: 300,
        child: url == null
          ? Image(
              image: AssetImage('assets/no-image.png'),
              fit: BoxFit.cover
            )
          : FadeInImage(
            placeholder: AssetImage('assets/jar-loading.gif'),
            image: NetworkImage(url!),
            fit: BoxFit.cover,
          ),
      ),
    );
  }
}

class _DocumentDetails extends StatelessWidget {
  final String title;
  const _DocumentDetails({
    super.key, 
    required this.title,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 50),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        width: double.infinity,
        height: 70,
        decoration: _BuildBoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              this.title, 
              style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration _BuildBoxDecoration() {
    return BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.only(topRight: Radius.circular(25), bottomLeft: Radius.circular(25))
      );
  }
}