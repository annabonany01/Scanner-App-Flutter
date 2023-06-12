
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String title;
  final String page;

  const Button({
    super.key,
    required this.title, 
    required this.page
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 250, 215, 161),
      child: Center(
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 165, 71, 12),
            shape: const StadiumBorder()
          ),
          onPressed: () {
            Navigator.pushNamed(context, page);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(title, style: const TextStyle(color:Color.fromARGB(255, 250, 215, 161), fontSize: 20)),
          ),
          )
      ),
    );
  }
}