// lib/utils/number_formatter.dart

import 'package:intl/intl.dart';

class NumberFormatter {
  static final NumberFormat _currencyFormat = NumberFormat.currency(
    symbol: '₹',
    decimalDigits: 2,
  );

  // Format as currency
  static String formatCurrency(double value) {
    return _currencyFormat.format(value);
  }

  // Format as decimal with 2 places
  static String formatDecimal(double value, {int decimalPlaces = 2}) {
    return value.toStringAsFixed(decimalPlaces);
  }

  // Format as percentage
  static String formatPercent(double value) {
    return '${value.toStringAsFixed(2)}%';
  }

  // Format with commas (Indian style)
  static String formatNumber(double value) {
    final numberFormat = NumberFormat('#,##,##0.00', 'en_IN');
    return numberFormat.format(value);
  }

  // Format large numbers with abbreviation
  static String formatCompact(double value) {
    if (value >= 10000000) {
      return '${(value / 10000000).toStringAsFixed(1)}Cr';
    } else if (value >= 100000) {
      return '${(value / 100000).toStringAsFixed(1)}L';
    } else if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(1)}K';
    }
    return value.toStringAsFixed(2);
  }

  // Parse currency string back to double
  static double? parseCurrency(String value) {
    try {
      return double.parse(value.replaceAll(RegExp(r'[^\d.]'), ''));
    } catch (e) {
      return null;
    }
  }
}
