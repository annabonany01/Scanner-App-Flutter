import 'package:flutter/material.dart';


class InputDecorations {

  static InputDecoration authInputDecoration({
    required String hintText,
    required String labelText,
  }) {
    return InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFF54C59C),
          ),
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(255, 230, 138, 138),
          ),
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),

        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFF54C59C),
            width: 2
          ),
          borderRadius: BorderRadius.all(Radius.circular(50))
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(255, 230, 138, 138),
            width: 2
          ),
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),

        filled: true,
        fillColor: (Color.fromARGB(226, 255, 255, 255)),
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.black38
        ),
        labelText: labelText,
        labelStyle: const TextStyle(
          color: Colors.black54
        ),
        
        
        
      );
  }  

}