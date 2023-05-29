import 'package:flutter/material.dart';
import 'package:qr_scanner/models/document.dart';

class DocumentFormProvider extends ChangeNotifier {

  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  Document document;

  DocumentFormProvider(this.document); //contructor


  bool isValidForm() {

    print(document.check);
    print(document.mark);
    print(document.id);

    return formKey.currentState?.validate() ?? false;
  }


}