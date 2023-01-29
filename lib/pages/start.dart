import 'package:flutter/material.dart';
import 'package:qr_scanner/widgets/background.dart';

class Start extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Background(),
        MainContent()
      ],
    );
  }
}

class MainContent extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final textStyle = TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 250, 215, 161));
    
    return SafeArea(
      bottom: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 150,),
          Text('Doc Scanner', style: textStyle, overflow: TextOverflow.clip),
          SizedBox(height: 80,),
          Icon(Icons.document_scanner_rounded, size: 100, color:  Color.fromARGB(255, 250, 215, 161)),
    
          Expanded(child: Container()),
      
          Icon(Icons.keyboard_arrow_down_rounded, size: 100, color: Color.fromARGB(255, 165, 71, 12)), 
    
        ],
      ),
    );
  }
}