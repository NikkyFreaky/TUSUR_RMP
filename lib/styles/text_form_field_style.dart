import 'package:flutter/material.dart';

class TextFormFieldStyle {
  static InputDecoration textFieldStyle({
    String labelTextStr = "",
  }) {
    return InputDecoration(
      contentPadding: const EdgeInsets.all(15),
      labelText: labelTextStr,
      labelStyle: const TextStyle(color: Colors.white),
      floatingLabelStyle: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      errorStyle: const TextStyle(color: Colors.red),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(
          color: Colors.white,
          width: 1.0,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(
          color: Colors.white,
          width: 2.0,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(
          color: Colors.white,
          width: 1.0,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(
          color: Colors.white,
          width: 2.0,
        ),
      ),
    );
  }
}
