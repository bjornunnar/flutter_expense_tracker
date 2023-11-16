import 'package:expense_tracker/widgets/expenses_base.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    themeMode: ThemeMode.dark,
    theme: lightTheme,
    darkTheme: darkTheme,
    home: const Expenses(),
  ));
}

var kColorScheme = ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 37, 62, 175));
var kDarkColorScheme = ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 23, 38, 105), brightness: Brightness.dark);

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
);

ThemeData darkTheme = ThemeData.dark().copyWith(
  brightness: Brightness.dark,
  useMaterial3: true,
  colorScheme: kDarkColorScheme,
  cardTheme: const CardTheme().copyWith(
    color: kDarkColorScheme.secondaryContainer,
    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
  ),
  
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: kDarkColorScheme.primaryContainer,
      foregroundColor: kDarkColorScheme.onPrimaryContainer,
    )
  ),
);
