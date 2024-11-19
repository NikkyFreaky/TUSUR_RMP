import 'package:flutter/material.dart';
import 'screens/nasa_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mars Rover Photos',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: NasaScreen(),
    );
  }
}
