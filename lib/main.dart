import 'package:expense_tracker/widgets/expenses_base.dart';
import 'package:flutter/material.dart';

var kColorScheme = ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 176, 48, 51));

ThemeData lightTheme = ThemeData().copyWith(
  brightness: Brightness.light,
  useMaterial3: true,
  colorScheme: kColorScheme,
    appBarTheme: const AppBarTheme().copyWith(
      backgroundColor: kColorScheme.onPrimaryContainer,
      foregroundColor: kColorScheme.primaryContainer),
    cardTheme: const CardTheme().copyWith(
      color: kColorScheme.secondaryContainer,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: kColorScheme.primaryContainer,
      )
    ),
    // textTheme: const TextTheme().copyWith(
    //   titleLarge: const TextStyle(
    //     fontWeight: FontWeight.normal, 
    //     fontSize: 16),
    // )
);

void main() {
  runApp(MaterialApp(
    theme: lightTheme,
    home: const Expenses(),
  ));
}
