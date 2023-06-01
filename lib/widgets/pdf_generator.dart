import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:open_file_safe/open_file_safe.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfGenerator {
  static Future<void> generatePDF(BuildContext context, Uint8List image, String name) async {
    final pdf = pw.Document();
    final pdfImage = pw.MemoryImage(image);
    pdf.addPage(pw.Page(
      build: (pw.Context context) {
        return pw.Column(
          children: [
            pw.Text('Alumne: $name', style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold), textAlign: pw.TextAlign.left ),
            pw.Image(pdfImage),
          ],
        );
      },));
    final directory = await getApplicationSupportDirectory();
    final filePath = '${directory.path}/grafica-$name.pdf';
    final file = File(filePath);
    await file.writeAsBytes(await pdf.save());

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('PDF generat correctament'),
        duration: Duration(seconds: 10),
        action: SnackBarAction(
          label: 'Obrir',
          textColor: Colors.greenAccent,
          onPressed: () {
            openFile(filePath);
          },
        ),
      ),
    );
  }

  static Future<void> openFile(String filePath) async {
    await OpenFile.open(filePath);
  }
}
