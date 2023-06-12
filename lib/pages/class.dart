import 'package:flutter/material.dart';

class Class extends StatelessWidget {
  const Class({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 70),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: AssetImage('assets/educat.png'), width: 200),
            SizedBox(height: 70),
            _ElevatedButton(
              icon: Icon(Icons.menu_book_rounded, color: Colors.purple, size: 30),
              title: 'Classe A',
            ),
            SizedBox(height: 10),
            _ElevatedButton(
              icon: Icon(Icons.menu_book_rounded, color: Colors.orange, size: 30),
              title: 'Classe B',
            ),
            SizedBox(height: 10),
            _ElevatedButton(
              icon: Icon(Icons.add_circle_outline_rounded, color: Colors.black, size: 30),
              title: 'Afegir classe',
            ),
          ],
        ),
      ),
    ));
  }
}

class _ElevatedButton extends StatelessWidget {
  final Icon icon;
  final String title;

  const _ElevatedButton({
    super.key, 
    required this.icon, 
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => Navigator.pushReplacementNamed(context, 'start'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(30.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(width: 30),
            Text(title, style: const TextStyle(fontSize: 15, color: Colors.black)),
          ],
        ),
      ),
    );
  }
}
