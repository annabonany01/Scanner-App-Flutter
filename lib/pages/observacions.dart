import 'package:flutter/material.dart';
import 'package:qr_scanner/pages/negativePage.dart';
import 'package:qr_scanner/pages/positivePage.dart';

class Observacions extends StatefulWidget {
  const Observacions({Key? key}) : super(key: key);

  @override
  _ObservacionsState createState() => _ObservacionsState();
}

class _ObservacionsState extends State<Observacions> {
  int _selectedIndex = 0;

  final _observacionsState = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: kToolbarHeight,

              child: TabBar(
                indicatorColor: Color.fromARGB(255, 119, 194, 167),
                tabs: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Icons.add_circle_rounded, color: Colors.green,),
                      Tab(text: 'Positiu'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Icons.remove_circle_rounded, color:Colors.red),
                      Tab(text: 'Negatiu'),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  PositivePage(),
                  NegativePage()
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.purple[300],
          onPressed: () {},
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

