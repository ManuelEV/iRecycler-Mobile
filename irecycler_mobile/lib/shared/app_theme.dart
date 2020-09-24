import 'package:flutter/material.dart';
 
class AppTheme {
  //
  AppTheme._();
 
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.teal[400],
  );
 
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.teal[400]
  );
}