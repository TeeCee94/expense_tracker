import 'package:flutter/material.dart';

import 'package:expense_tracker/expenses.dart';

var tDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 1, 108, 58),
);

var tColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 247, 116, 1),
);

void main() {
  runApp(
    MaterialApp(
      // themeMode: ThemeMode.system, //default
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: tDarkColorScheme,
        //...added due to error when mode is switched to dark
        cardTheme: CardThemeData(
          color: tDarkColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(
            horizontal: 13, 
            vertical: 6
            ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: tDarkColorScheme.primaryContainer,
            foregroundColor: tDarkColorScheme.onPrimaryContainer,
          ),
        ),
      ),

      theme: ThemeData(
        colorScheme: tColorScheme,
        appBarTheme: AppBarTheme(
          backgroundColor: tColorScheme.onPrimaryContainer,
          foregroundColor: tColorScheme.primaryContainer,
        ),
        cardTheme: CardThemeData(
          color: tColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 13, vertical: 6),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: tColorScheme.onPrimaryContainer,
            foregroundColor: tColorScheme.primaryContainer,
          ),
        ),
        textTheme: TextTheme(
          titleLarge: TextStyle(
            fontWeight: FontWeight.bold,
            color: tColorScheme.onSecondaryContainer,
            fontSize: 16,
          ),
        ),
      ),

      home: Expenses(),
    ),
  );
}
