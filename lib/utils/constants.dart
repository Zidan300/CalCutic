// lib/utils/constants.dart

class AppConstants {
  // App Info
  static const String appName = 'FinCalc';
  static const String appVersion = '1.0.0';

  // Color Palette
  static const int primaryColor = 0xFF2E86AB;
  static const int secondaryColor = 0xFFA23B72;
  static const int successColor = 0xFF18A558;
  static const int warningColor = 0xFFF18F01;
  static const int errorColor = 0xFFC1121F;
  static const int backgroundColor = 0xFFF8F9FA;
  static const int surfaceColor = 0xFFFFFFFF;
  static const int darkTextColor = 0xFF2C3E50;
  static const int lightTextColor = 0xFFECF0F1;

  // Dark Mode Colors
  static const int darkBg = 0xFF1A1A1A;
  static const int darkSurface = 0xFF2D2D2D;
  static const int darkText = 0xFFECF0F1;

  // Spacing
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;

  // Border Radius
  static const double radiusSm = 8.0;
  static const double radiusMd = 12.0;
  static const double radiusLg = 16.0;

  // Animation Duration
  static const Duration animationDuration = Duration(milliseconds: 300);
  static const Duration shortDuration = Duration(milliseconds: 150);

  // Database
  static const String dbName = 'financial_calculator.db';
  static const String historyTable = 'calculations_history';

  // Preferences Keys
  static const String darkModeKey = 'dark_mode';
  static const String languageKey = 'language';
  static const String memoryValueKey = 'memory_value';
}

// Calculator Types
enum CalculatorType {
  basic,
  interest,
  emi,
  gst,
  discount,
  savings,
  inflation,
  profitLoss,
  breakEven,
}

// Compounding Period
enum CompoundingPeriod {
  daily,
  monthly,
  quarterly,
  yearly;

  int get value {
    switch (this) {
      case CompoundingPeriod.daily:
        return 365;
      case CompoundingPeriod.monthly:
        return 12;
      case CompoundingPeriod.quarterly:
        return 4;
      case CompoundingPeriod.yearly:
        return 1;
    }
  }

  String get display {
    switch (this) {
      case CompoundingPeriod.daily:
        return 'Daily';
      case CompoundingPeriod.monthly:
        return 'Monthly';
      case CompoundingPeriod.quarterly:
        return 'Quarterly';
      case CompoundingPeriod.yearly:
        return 'Yearly';
    }
  }
}
