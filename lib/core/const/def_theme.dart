import 'package:flutter/material.dart';

class DefTheme {
  static ThemeData themeData = ThemeData(
      appBarTheme: const AppBarTheme(
          centerTitle: true,
          backgroundColor: Colors.white,
          titleTextStyle: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          iconTheme: IconThemeData(color: Colors.black)));
}
