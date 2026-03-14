import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:financial_calculator/themes/app_theme.dart';
import 'package:financial_calculator/providers/theme_provider.dart';
import 'package:financial_calculator/screens/home_screen.dart';
import 'package:financial_calculator/screens/basic_calculator_screen.dart';
import 'package:financial_calculator/screens/simple_interest_screen.dart';
import 'package:financial_calculator/screens/compound_interest_screen.dart';
import 'package:financial_calculator/screens/loan_emi_screen.dart';
import 'package:financial_calculator/screens/gst_screen.dart';
import 'package:financial_calculator/screens/discount_screen.dart';
import 'package:financial_calculator/screens/savings_goal_screen.dart';
import 'package:financial_calculator/screens/inflation_screen.dart';
import 'package:financial_calculator/screens/profit_loss_screen.dart';
import 'package:financial_calculator/screens/break_even_screen.dart';

void main() {
  runApp(const CalCuticApp());
}

class CalCuticApp extends StatelessWidget {
  const CalCuticApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Get.put(ThemeProvider());

    return Obx(
      () => GetMaterialApp(
        title: 'CalCutic',
        theme: AppTheme.lightTheme(),
        darkTheme: AppTheme.darkTheme(),
        themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
        initialRoute: '/',
        getPages: [
          GetPage(name: '/', page: () => const HomeScreen()),
          GetPage(name: '/calculator', page: () => const BasicCalculatorScreen()),
          GetPage(name: '/simple_interest', page: () => const SimpleInterestScreen()),
          GetPage(name: '/compound_interest', page: () => const CompoundInterestScreen()),
          GetPage(name: '/loan_emi', page: () => const LoanEmiScreen()),
          GetPage(name: '/gst', page: () => const GstScreen()),
          GetPage(name: '/discount', page: () => const DiscountScreen()),
          GetPage(name: '/savings_goal', page: () => const SavingsGoalScreen()),
          GetPage(name: '/inflation', page: () => const InflationScreen()),
          GetPage(name: '/profit_loss', page: () => const ProfitLossScreen()),
          GetPage(name: '/break_even', page: () => const BreakEvenScreen()),
        ],
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
