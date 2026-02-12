import 'package:flutter/material.dart';
import 'package:financial_calculator/themes/app_theme.dart';
import 'package:financial_calculator/screens/basic_calculator_screen.dart';

void main() {
  runApp(const CalCuticApp());
}

class CalCuticApp extends StatelessWidget {
  const CalCuticApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CalCutic',
      theme: AppTheme.lightTheme(),
      darkTheme: AppTheme.darkTheme(),
      home: const BasicCalculatorScreen(),
    );
  }
}
