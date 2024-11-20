import 'package:flutter/material.dart';
import 'screens/nasa_screen.dart';

void main() {
  runApp(NasaApp());
}

class NasaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Фотографии Марса',
      home: NasaScreen(),
    );
  }
}
