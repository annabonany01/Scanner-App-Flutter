import 'package:flutter/material.dart';
import 'package:qr_scanner/pages/pin_page.dart';
import 'package:qr_scanner/pages/start.dart';

class HomePage extends StatelessWidget {
  final boxDecoration = const BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [
        0.5,
        0.5
      ],
          colors: [
        Color.fromARGB(255, 165, 71, 12),
        Color.fromARGB(255, 250, 215, 161)
      ]));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: boxDecoration,
      child: PageView(
        physics: BouncingScrollPhysics(), //comportamiendo ios
        scrollDirection: Axis.vertical,
        children: [Start(), PinPage()],
      ),
    ));
  }
}
