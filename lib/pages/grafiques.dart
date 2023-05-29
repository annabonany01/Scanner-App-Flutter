import 'package:flutter/material.dart';

class Grafiques extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: Text('Gràfiques'),
        backgroundColor: Color.fromARGB(255, 147, 203, 183),
        centerTitle: true,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            );
          },
        ),
      ),

    );
  }
}
