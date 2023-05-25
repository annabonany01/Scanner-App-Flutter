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
      cursorColor:  Color(0xFF54C59C),
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        labelText: "Teacher Pin",
        labelStyle: TextStyle(color: Color(0xFF54C59C)),
        focusedBorder: OutlineInputBorder(
          borderSide:
            BorderSide(color: Color(0xFF54C59C), width: 3.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF54C59C), width: 2.0),
        ),
      ),
      maxLength: 4,
      validator: ( value ) {
        return ( value != null && value.length == 4 ) 
          ? null
          : 'Mínim 4 caràcters';                                    
      },
    );
  }
}