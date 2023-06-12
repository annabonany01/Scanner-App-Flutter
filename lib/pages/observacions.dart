import 'package:flutter/material.dart';
import 'package:qr_scanner/pages/negativePage.dart';
import 'package:qr_scanner/pages/positivePage.dart';

class Observacions extends StatelessWidget {
  const Observacions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          title: const Text('Observacions'),
          backgroundColor: const Color.fromARGB(255, 147, 203, 183),
          centerTitle: true,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () =>
                    Navigator.pop(context),
              );
            },
          ),
        ),
        body: Column(
          children: [
            const SizedBox(
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
      ),
    );
  }
}

