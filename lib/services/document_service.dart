import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:qr_scanner/models/document.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class DocumentService extends ChangeNotifier {
  final String _baseUrl = 'doc-scanner-15eb0-default-rtdb.firebaseio.com';
  late final List<Document> documents = [];
  late Document selectedDocument;

  File? newDocumentFile;

  bool isLoading = true;
  bool isSaving = false;

  Uuid uuid = const Uuid();

  DocumentService() {
    print('DocumentService inicializado');
    loadDocuments();
  }

  Future loadDocuments() async {
    this.isLoading = true;
    notifyListeners();

    final url = Uri.https(_baseUrl, 'documents.json');
    final resp = await http.get(url);

    final Map<String, dynamic> documentsMap = json.decode(resp.body);

    documentsMap.forEach((key, value) {
      final tempDoc = Document.fromMap(value);
      tempDoc.id = key;
      documents.add(tempDoc);
    });

    isLoading = false;
    notifyListeners();
    return documents;
  }

  Future loadLastDocument() async {
  isLoading = true;
  notifyListeners();

  final url = Uri.https(_baseUrl, 'documents.json');
  final resp = await http.get(url);

  final Map<String, dynamic> documentsMap = json.decode(resp.body);

  if (documentsMap.isNotEmpty) {
    final lastDocumentKey = documentsMap.keys.last;
    final lastDocumentData = documentsMap[lastDocumentKey];
    final lastDocument = Document.fromMap(lastDocumentData);
    lastDocument.id = lastDocumentKey;
    selectedDocument = lastDocument;
  }

  isLoading = false;
  notifyListeners();
}

  Future updateLastDocument(Document document) async {
    isLoading = true;
    notifyListeners();
    final url = Uri.https(_baseUrl, 'documents/${document.id}.json');
    final resp = await http.put(url, body: document.toJson());
    final decodedData = resp.body;

    final index = documents.indexWhere((element) => element.id == document.id);
    documents[index] = document;

    isLoading = false;
    notifyListeners();

    return document.id!;
  }

  Future saveOrCreateDocument(Document document) async {
    isSaving = true;
    notifyListeners();
    if (document.id == null) {
      createDocument(document);
    } else {
      updateDocument(document);
    }
    isSaving = false;
    notifyListeners();
  }

  Future<String> updateDocument(Document document) async {
    final url = Uri.https(_baseUrl, 'documents/${document.id}.json');
    final resp = await http.put(url, body: document.toJson());
    final decodedData = resp.body;

    final index = documents.indexWhere((element) => element.id == document.id);
    documents[index] = document;
    return document.id!;
  }

  Future<String> createDocument(Document document) async {
    uploadImage();
    final url = Uri.https(_baseUrl, 'documents.json');
    final resp = await http.post(url, body: document.toJson());
    final decodedData = json.decode(resp.body);

    document.id = uuid.v4();
    documents.insert(0, document);
    return document.id!;
  }

  Future<String?> uploadImage() async {
    if (newDocumentFile == null) return null;

    isSaving == true;
    notifyListeners();

    final url = Uri.parse('https://api.cloudinary.com/v1_1/annabv/image/upload?upload_preset=fqzwud5z');

    final imageUploadRequest = http.MultipartRequest('POST', url);
    final file = await http.MultipartFile.fromPath('file', newDocumentFile!.path);

    imageUploadRequest.files.add(file);
    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);
    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print('algo salió mal');
      print(resp.body);
      return null;
    }
    newDocumentFile = null;
    final decodedData = json.decode(resp.body);
    return decodedData['secure_url'];
  }

  Future<void> deleteDocument(Document document) async {
    documents.remove(document);
    notifyListeners();
  }
}
