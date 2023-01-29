import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:qr_scanner/models/doc_element.dart';
import 'package:uuid/uuid.dart';

class DocumentService extends ChangeNotifier {
  final List<DocElement> documents = [];
  late File selectedDocElement;

  File? newPictureFile;

  bool isLoading = true;
  bool isSaving = false;

  Uuid uuid = const Uuid();

  DocumentService();

  Future saveOrCreateDocElement(DocElement document) async {
    if (document.id == null) {
      // se necesita crear
      createDocElement(document);
    } else {
      //se necesita actualizar
      updateDocElement(document);
    }
  }

  void updateDocElement(DocElement document) {
    final index = documents.indexWhere((element) => element.id == document.id);
    documents[index] = document;
    notifyListeners();
  }

  void changeNameDocElement(DocElement document, String name) {
    document.id = uuid.v4();
    document.name = name;
    notifyListeners();
  }

  void createDocElement(DocElement document) {
    document.id = uuid.v4();
    documents.add(document);
    notifyListeners();
  }
  
  void deleteDocElement(DocElement document) {
    documents.remove(document);
    notifyListeners();
  }

}
