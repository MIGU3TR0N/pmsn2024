import 'package:flutter/material.dart';

class ThemeSettings {
  static ThemeData ligthTheme(BuildContext context){
    final theme = ThemeData.light();
    return theme.copyWith(
      scaffoldBackgroundColor: const Color.fromARGB(255, 255, 244, 237),
    );
  }
  static ThemeData darkTheme(BuildContext context){
    final theme =ThemeData.dark();
    return theme.copyWith(
      scaffoldBackgroundColor: Colors.grey,
    );
  }
  static ThemeData warmTheme(BuildContext context){
    final theme = ThemeData.light();
    return theme.copyWith();
  }
}