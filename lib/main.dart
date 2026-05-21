import 'package:flutter/material.dart';
// Import your new file here so main.dart can find the widget
import 'material_page.dart'; 

void main() {
  runApp(const CurrencyConverterApp());
}

class CurrencyConverterApp extends StatelessWidget {
  const CurrencyConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color.fromARGB(255, 120, 219, 255),
      ),
      // Set the home screen to use the imported MultiCurrencyConverter widget
      home: const MultiCurrencyConverter(), 
    );
  }
}