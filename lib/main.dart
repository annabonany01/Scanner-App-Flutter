import 'package:flutter/material.dart';
import 'package:qr_scanner/pages/aula.dart';
import 'package:qr_scanner/pages/class.dart';
import 'package:qr_scanner/pages/correccio.dart';
import 'package:qr_scanner/pages/home_page.dart';
import 'package:qr_scanner/pages/observacions.dart';
import 'package:qr_scanner/pages/pin_page.dart';
import 'package:qr_scanner/pages/register.dart';
import 'package:qr_scanner/pages/scanner_page.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/pages/start.dart';
import 'package:qr_scanner/services/document_service.dart';

void main() => runApp(AppState());

class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DocumentService()),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QR Scanner',
      initialRoute: 'start',
      routes: { 
        'home': (_) => HomePage(),
        'pin': (_) => PinPage(),
        'start': (_) => Start(),
        'scanner': (_) => ScannerPage(),
        'register': (_) => Register(),
        'class': (_) => Class(),
        'aula': (_) => Aula(),
        'obs': (_) => Observacions(),
        'correccio': (_) => Correccio(),

      },
      theme: ThemeData(
          primaryColor: Color(0xFF54C59C),
          secondaryHeaderColor: Color(0xFFC131C3),
          canvasColor: Color.fromARGB(255, 206, 231, 222),
          appBarTheme: AppBarTheme(
            backgroundColor: Color.fromARGB(255, 147, 203, 183),
          ),
      ),
    );
  }
}
