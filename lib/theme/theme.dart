import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      surface: Color(0xFF1F1F3B), //gradient start
      onSurface: Color(0xFF29294D), //gradient end
      primary: Color(0xFF1F1F3B), //app bar
      secondary: Color(0xFF32325D), //bottom app bar
      onPrimary: Color(0xFFF2F2F2), //primary text - off white
      //onSecondary: Color(0xFFC0C0C0), //secondary text - grey
      error: Color(0xFFF05454), //accent color for Container
    )
);

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      surface: Color(0xFFFFCDD2), //gradient start
      onSurface: Color(0xFFBBDEFB), //gradient end
      primary: Color(0xFFFFCDD2), //app bar
      secondary: Color(0xFFBBDEFB), //bottom app bar
      onPrimary: Color(0xFF212121), //primary text - deep Black
      //onSecondary: Color(0xFF212121), //secondary text - deep Black
      error: Color(0xFFF5F5F5), //accent color for Container
    )
);