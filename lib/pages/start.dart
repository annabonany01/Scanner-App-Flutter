import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:qr_scanner/pages/assistencia.dart';
import 'package:qr_scanner/pages/aula.dart';
import 'package:qr_scanner/pages/scanner_page.dart';

class Start extends StatefulWidget {
  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  int _currentIndex = 0;
  Text _pageTitle = Text('Classe A');

  final List<Widget> _pages = [
    Aula(),
    ScannerPage(),
    Assistencia(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          title: _pageTitle,
          backgroundColor: Color.fromARGB(255, 147, 203, 183),
          centerTitle: true,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, 'class'),
              );
            },
          ),
        ),
        body: IndexedStack(
          index: _currentIndex,
          children: _pages,
        ),
        bottomNavigationBar: ConvexAppBar(
          backgroundColor: Color.fromARGB(255, 147, 203, 183),
          shadowColor: Color.fromARGB(255, 147, 203, 183),
          style: TabStyle.fixedCircle,
          items: [
            TabItem(title: 'Aula', icon: Icons.groups),
            TabItem(
              icon: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.document_scanner_outlined,
                    color: Color.fromARGB(255, 147, 203, 183), size: 40),
              ),
            ),
            TabItem(title: "Assistència", icon: Icons.schedule_rounded),
          ],
          onTap: (int index) {
            setState(() {
              _currentIndex = index;
              switch (index) {
                case 0:
                  _pageTitle = Text('Classe A \n Aula', textAlign: TextAlign.center);
                  break;
                case 1:
                  _pageTitle = Text('Classe A \n Escàner', textAlign: TextAlign.center);
                  break;
                case 2:
                  _pageTitle = Text('Classe A \n Assistència', textAlign: TextAlign.center);
                  break;
              }
            });
          },
        ),
      ),
    );
  }
}
