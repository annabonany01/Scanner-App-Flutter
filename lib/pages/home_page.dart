import 'dart:async';

import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 1), () {
      Navigator.pushReplacementNamed(context, 'pin');
    });
    return Scaffold(
        body: Container(
        child: PageView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          children: const [
                SafeArea(
                  bottom: false,
                  child: Column(
                    children: [
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
