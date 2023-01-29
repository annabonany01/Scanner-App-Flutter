import 'package:flutter/material.dart';

class Background extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment(0.0, 1.0), // 10% of the width, so there are ten blinds.
          colors: const <Color>[
            Color.fromARGB(255, 165, 71, 12),
            Color.fromARGB(255, 250, 215, 161),
          ], // red to yellow
          tileMode: TileMode.repeated, // repeats the gradient over the canvas
        ),
      ),
    );
  }
}