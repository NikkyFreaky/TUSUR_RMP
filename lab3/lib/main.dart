import 'package:flutter/material.dart';
import 'screens/input_screen.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Калькулятор расчета объема звукового файла',
      theme: ThemeData.dark(),
      home: InputScreen(),
    );
  }
}
