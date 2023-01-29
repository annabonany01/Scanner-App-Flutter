import 'package:flutter/material.dart';
import 'package:qr_scanner/widgets/button.dart';
import 'package:qr_scanner/widgets/pin_number.dart';

class PinPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 250, 215, 161),
        body: Container(
          padding: EdgeInsets.all(40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PinNumber(),
              SizedBox(height: 50),
              Button(title: 'Start', page: 'scanner')
            ],
          )
        ),
      ),
    );
  }
}
