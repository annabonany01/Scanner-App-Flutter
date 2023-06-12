import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/models/document.dart';
import 'package:qr_scanner/services/document_service.dart';
import 'package:qr_scanner/widgets/pencil_icon.dart';
import 'package:qr_scanner/widgets/show_dialog_custom.dart';

class DocInfo extends StatefulWidget {
  final Document document;

  const DocInfo({super.key, required this.document});

  @override
  State<DocInfo> createState() => _DocInfoState();
}

class _DocInfoState extends State<DocInfo> {
  List<String> competencies = [
    'Comunicació lingüística',
    'Plurilingüe',
    'Matemàtica i en ciència, tecnologia i enginyeria',
    'Digital',
    'Personal, social i d\'aprendre a aprendre',
    'Ciutadana',
    'Emprenedora',
    'Consciència i expressió culturals',
    'No definida',
  ];

  List<String> notes = [
    'Ass. Excel·lent',
    'Ass. Notable',
    'Ass. Satisfactori',
    'No assolit',
    'No definit',
  ];

  String selectedCompetency = 'No definida';
  String selectedMark = 'No definit';

  @override
  Widget build(BuildContext context) {
    final documentService = Provider.of<DocumentService>(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: const Text('Document'),
        backgroundColor: Color.fromARGB(255, 147, 203, 183),
        centerTitle: true,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context, widget.document),
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.check_circle_outlined, color: Colors.green[600]),
            onPressed: () async => {
              setState(() {
                widget.document.check = true;
              }),
              await documentService.updateDocument(widget.document),
              Navigator.pop(context, widget.document)
            },
            iconSize: 50,
            tooltip: 'Desar canvis',
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 200,
                  child: TextButton(
                    child: Column(
                      children: [
                        const TitleText(
                            text: 'Competència:',
                            size: 14,
                            fontWeight: FontWeight.bold),
                        TitleText(
                            text: (widget.document.competencia == null)
                                ? selectedCompetency
                                : widget.document.competencia!,
                            size: 13,
                            fontWeight: FontWeight.normal)
                      ],
                    ),
                    onPressed: () {
                      ShowDialogCustom.showDialogCustom(
                          context,
                          'Selecciona una competència:',
                          competencies,
                          selectedCompetency, (value) async {
                        setState(() {
                          selectedCompetency = value;
                          widget.document.competencia = selectedCompetency;
                        });
                        await documentService.updateDocument(widget.document);
                      });
                    },
                  ),
                ),
                Container(
                  width: 110,
                  child: TextButton(
                    child: Column(
                      children: [
                        const TitleText(
                            text: 'Qualificació:',
                            size: 14,
                            fontWeight: FontWeight.bold),
                        TitleText(
                            text: (widget.document.mark == null)
                                ? selectedMark
                                : widget.document.mark!,
                            size: 13,
                            fontWeight: FontWeight.normal),
                      ],
                    ),
                    onPressed: () {
                      ShowDialogCustom.showDialogCustom(
                        context,
                        'Selecciona una qualificació:',
                        notes,
                        selectedMark,
                        (value) async {
                          setState(() {
                            selectedMark = value;
                            widget.document.mark = selectedMark;
                          });
                          await documentService.updateDocument(widget.document);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              height: 400,
              child: Center(
                child: Image.network(widget.document.image!),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                PencilIcon(icon: Icon(Icons.edit, color: Colors.green[600])),
                PencilIcon(icon: Icon(Icons.edit, color: Colors.orange[600])),
                PencilIcon(icon: Icon(Icons.edit, color: Colors.red[600])),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(Icons.insert_comment_outlined,
                      color: Colors.grey[700]),
                  onPressed: () => {},
                  iconSize: 50,
                  tooltip: 'Afegir comentari',
                ),
                IconButton(
                  icon: Icon(Icons.emoji_emotions_outlined,
                      color: Colors.grey[700]),
                  onPressed: () => {},
                  iconSize: 50,
                  tooltip: 'Afegir enganxina',
                ),
                IconButton(
                  icon: Icon(Icons.change_circle_outlined,
                      color: Colors.red[600]),
                  onPressed: () async => {
                    setState(() {
                      widget.document.check = false;
                    }),
                    await documentService.updateDocument(widget.document),
                  },
                  iconSize: 50,
                  tooltip: 'Borrar canvis',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TitleText extends StatelessWidget {
  const TitleText({
    super.key,
    required this.text,
    required this.size,
    required this.fontWeight,
  });

  final String text;
  final double size;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontSize: size, color: Colors.black, fontWeight: fontWeight),
      overflow: TextOverflow.fade,
      textAlign: TextAlign.center,
    );
  }
}
