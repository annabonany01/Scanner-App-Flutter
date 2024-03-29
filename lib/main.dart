import 'package:flutter/material.dart';
import 'package:qr_scanner/pages/assistencia.dart';
import 'package:qr_scanner/pages/aula.dart';
import 'package:qr_scanner/pages/class.dart';
import 'package:qr_scanner/pages/home_page.dart';
import 'package:qr_scanner/pages/observacions.dart';
import 'package:qr_scanner/pages/pin_page.dart';
import 'package:qr_scanner/pages/register.dart';
import 'package:qr_scanner/pages/scanner_page.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/pages/start.dart';
import 'package:qr_scanner/services/document_service.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({super.key});

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
      initialRoute: 'home',
      routes: { 
        'home': (_) => const HomePage(),
        'pin': (_) => const PinPage(),
        'start': (_) => const Start(),
        'scanner': (_) => const ScannerPage(),
        'register': (_) => Register(),
        'class': (_) => const Class(),
        'aula': (_) => Aula(),
        'obs': (_) => const Observacions(),
        'assistencia': (_) => const Assistencia(),

      },
      theme: ThemeData(
          primaryColor: const Color(0xFF54C59C),
          secondaryHeaderColor: const Color(0xFFC131C3),
          canvasColor: const Color.fromARGB(255, 206, 231, 222),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color.fromARGB(255, 147, 203, 183),
          ),
      ),
    );
  }
}
