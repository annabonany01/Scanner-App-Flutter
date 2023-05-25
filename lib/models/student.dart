import 'package:flutter/material.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import 'document.dart';

class Student {
  final String name;
  final Initicon? icon;
  final int id;
  final Color color;
  final List<Document> scannedDocuments;

  Student({required this.name, required this.id, required this.color, this.scannedDocuments = const []})
      : icon = Initicon(text: name);

}
