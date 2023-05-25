import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
        child: PageView(
          physics: BouncingScrollPhysics(), //comportamiendo ios
          scrollDirection: Axis.vertical,
          children: [
            InkWell(
                onTap: () {
                  Navigator.pushReplacementNamed(context, 'pin');
                },
                child: SafeArea(
                  bottom: false,
                  child: Column(
                    children: const [
                      SizedBox(
                        height: 150,
                      ),
                      Image(image: AssetImage('assets/educat.png')),
                    ],
                  ),
                ))
          ],
        ),
    ));
  }
}
