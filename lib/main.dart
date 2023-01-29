import 'package:flutter/material.dart';
import 'package:qr_scanner/pages/home_page.dart';
import 'package:qr_scanner/pages/scanner_page.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/services/doc_service.dart';

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
      initialRoute: 'home',
      routes: {
        'home': (_) => HomePage(),
        'scanner': (_) => ScannerPage(),
      },
      theme: ThemeData(
          primaryColor: Color.fromARGB(255, 165, 71, 12),
          canvasColor: Color.fromARGB(255, 250, 215, 161),
          appBarTheme: AppBarTheme(
            backgroundColor: Color.fromARGB(255, 165, 71, 12),
          ),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: Color.fromARGB(255, 165, 71, 12))),
    );
  }
}
