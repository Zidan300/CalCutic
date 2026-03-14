// lib/themes/app_theme.dart
// Premium Material Design 3 Theme with Modern Patterns

import 'package:flutter/material.dart';
import 'package:financial_calculator/utils/constants.dart';

class AppTheme {
  // Modern Premium Color Palette
  static const Color _primaryBlue = Color(0xFF2E7D32);
  static const Color _accentTeal = Color(0xFF00BCD4);
  static const Color _surfaceLight = Color(0xFFF8F9FA);
  static const Color _surfaceDark = Color(0xFF121212);
  static const Color _cardLight = Color(0xFFFFFFFF);
  static const Color _cardDark = Color(0xFF1E1E1E);
  static const Color _errorRed = Color(0xFFD32F2F);
  static const Color _lightTextColor = Colors.black87; // Defined for light theme text

  static ThemeData lightTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: _primaryBlue,
      scaffoldBackgroundColor: _surfaceLight,
      
      // Premium AppBar with gradient and elevation
      appBarTheme: const AppBarTheme(
        backgroundColor: _cardLight,
        foregroundColor: _lightTextColor,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        shadowColor: Color(0x15000000),
        titleTextStyle: TextStyle(
          color: Color(AppConstants.darkTextColor),
          fontSize: 22,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.3,
        ),
      ),
      
      // Premium Card Theme with subtle shadows
      cardTheme: CardThemeData(
        color: _cardLight,
        elevation: 0.5,
        shadowColor: const Color(0x08000000),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        ),
        margin: EdgeInsets.zero,
      ),
      
      // Enhanced Typography Hierarchy
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: _lightTextColor,
          fontSize: 32,
          fontWeight: FontWeight.bold,
          letterSpacing: -0.5,
        ),
        displayMedium: TextStyle(
          color: _lightTextColor,
          fontSize: 28,
          fontWeight: FontWeight.bold,
          letterSpacing: -0.3,
        ),
        headlineSmall: TextStyle(
          color: _lightTextColor,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.2,
        ),
        titleLarge: TextStyle(
          color: _lightTextColor,
          fontSize: 20,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.15,
        ),
        titleMedium: TextStyle(
          color: _lightTextColor,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.15,
        ),
        titleSmall: TextStyle(
          color: _lightTextColor,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.1,
        ),
        bodyLarge: TextStyle(
          color: _lightTextColor,
          fontSize: 16,
          letterSpacing: 0.1,
        ),
        bodyMedium: TextStyle(
          color: _lightTextColor,
          fontSize: 14,
          letterSpacing: 0.1,
        ),
        bodySmall: TextStyle(
          color: Color(0xFF666666),
          fontSize: 12,
          letterSpacing: 0.08,
        ),
        labelLarge: TextStyle(
          color: _lightTextColor,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
        ),
      ),
      
      // Premium Input Decoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFFF5F7FA),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        
        // Enabled Border - Subtle with minimal color
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color(0xFFE0E0E0),
            width: 1,
          ),
        ),
        
        // Focused Border - Primary color with emphasis
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: _primaryBlue,
            width: 2,
          ),
        ),
        
        // Error Border
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: _errorRed,
            width: 1.5,
          ),
        ),
        
        // Focused Error Border
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: _errorRed,
            width: 2,
          ),
        ),
        
        // Hint and Label styles
        hintStyle: const TextStyle(
          color: Color(0xFF999999),
          fontSize: 14,
        ),
        labelStyle: const TextStyle(
          color: _lightTextColor,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        
        // Error style
        errorStyle: const TextStyle(
          color: _errorRed,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        
        // Prefix/Suffix styles
        prefixStyle: const TextStyle(
          color: _lightTextColor,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        suffixStyle: const TextStyle(
          color: Color(0xFF666666),
          fontSize: 12,
        ),
      ),
      
      // Button Themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _primaryBlue,
          foregroundColor: Colors.white,
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),
      
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: _primaryBlue,
          side: const BorderSide(color: _primaryBlue, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),
      
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: _primaryBlue,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
          ),
        ),
      ),
      
      // Floating Action Button
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: _primaryBlue,
        foregroundColor: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      
      // Divider
      dividerTheme: const DividerThemeData(
        color: Color(0xFFE0E0E0),
        thickness: 1,
        space: 1,
      ),
      
      // Checkbox
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return _primaryBlue;
          }
          return Colors.transparent;
        }),
        side: WidgetStateBorderSide.resolveWith(
          (states) => const BorderSide(color: Color(0xFFDDDDDD)),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      
      // Radio
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return _primaryBlue;
          }
          return Colors.transparent;
        }),
        visualDensity: VisualDensity.compact,
      ),
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: _primaryBlue,
      scaffoldBackgroundColor: _surfaceDark,
      
      // Dark AppBar
      appBarTheme: const AppBarTheme(
        backgroundColor: _cardDark,
        foregroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.3,
        ),
      ),
      
      // Dark Card Theme
      cardTheme: CardThemeData(
        color: _cardDark,
        elevation: 0.5,
        shadowColor: const Color(0x08000000),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        ),
        margin: EdgeInsets.zero,
      ),
      
      // Dark Text Theme
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: Colors.white,
          fontSize: 32,
          fontWeight: FontWeight.bold,
          letterSpacing: -0.5,
        ),
        displayMedium: TextStyle(
          color: Colors.white,
          fontSize: 28,
          fontWeight: FontWeight.bold,
          letterSpacing: -0.3,
        ),
        headlineSmall: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.2,
        ),
        titleLarge: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.15,
        ),
        titleMedium: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.15,
        ),
        titleSmall: TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.1,
        ),
        bodyLarge: TextStyle(
          color: Color(0xFFE8E8E8),
          fontSize: 16,
          letterSpacing: 0.1,
        ),
        bodyMedium: TextStyle(
          color: Color(0xFFD0D0D0),
          fontSize: 14,
          letterSpacing: 0.1,
        ),
        bodySmall: TextStyle(
          color: Color(0xFF999999),
          fontSize: 12,
          letterSpacing: 0.08,
        ),
        labelLarge: TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
        ),
      ),
      
      // Dark Input Decoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF2A2A2A),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color(0xFF404040),
            width: 1,
          ),
        ),
        
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: _primaryBlue,
            width: 2,
          ),
        ),
        
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: _errorRed,
            width: 1.5,
          ),
        ),
        
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: _errorRed,
            width: 2,
          ),
        ),
        
        hintStyle: const TextStyle(
          color: Color(0xFF666666),
          fontSize: 14,
        ),
        
        labelStyle: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        
        errorStyle: const TextStyle(
          color: Color(0xFFFF6B6B),
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        
        prefixStyle: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        
        suffixStyle: const TextStyle(
          color: Color(0xFF999999),
          fontSize: 12,
        ),
      ),
      
      // Dark Button Themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _primaryBlue,
          foregroundColor: Colors.white,
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),
      
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: _primaryBlue,
          side: const BorderSide(color: _primaryBlue, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),
      
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: _accentTeal,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
          ),
        ),
      ),
      
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: _primaryBlue,
        foregroundColor: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      
      dividerTheme: const DividerThemeData(
        color: Color(0xFF404040),
        thickness: 1,
        space: 1,
      ),
      
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return _primaryBlue;
          }
          return Colors.transparent;
        }),
        side: WidgetStateBorderSide.resolveWith(
          (states) => const BorderSide(color: Color(0xFF606060)),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return _primaryBlue;
          }
          return Colors.transparent;
        }),
        visualDensity: VisualDensity.compact,
      ),
    );
  }
}
