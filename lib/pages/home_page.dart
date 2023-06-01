import 'dart:async';

import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 1), () {
      Navigator.pushReplacementNamed(context, 'pin');
    });
    return Scaffold(
        body: Container(
        child: PageView(
          physics: BouncingScrollPhysics(), //comportamiendo ios
          scrollDirection: Axis.vertical,
          children: [
                SafeArea(
                  bottom: false,
                  child: Column(
                    children: const [
                      SizedBox(
                        height: 150,
                      ),
                      Image(image: AssetImage('assets/educat.png')),
                    ],
                  ),
                )
          ],
        ),
    ));
  }
}
