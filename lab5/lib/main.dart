import 'package:flutter/material.dart';
import 'main_screen_provider.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Калькулятор',
      theme: ThemeData.dark(),
      home: MainScreenProvider(),
    );
  }
}
