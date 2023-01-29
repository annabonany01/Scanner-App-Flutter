import 'package:flutter/material.dart';

class PinNumber extends StatelessWidget {
  const PinNumber({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autocorrect: false,
      obscureText: false,
      cursorColor:  Color.fromARGB(255, 165, 71, 12),
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        labelText: "Teacher Pin",
        labelStyle: TextStyle(color: Color.fromARGB(255, 165, 71, 12)),
        focusedBorder: OutlineInputBorder(
          borderSide:
            BorderSide(color: Color.fromARGB(255, 165, 71, 12), width: 4.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 165, 71, 12), width: 2.0),
        ),
      ),
      maxLength: 4,
      validator: ( value ) {
        return ( value != null && value.length == 4 ) 
          ? null
          : 'Minimum 4 characters';                                    
      },
    );
  }
}