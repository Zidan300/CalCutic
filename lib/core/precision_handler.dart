
class PrecisionHandler {
  static const int defaultPrecision = 10;

  static String format(double value, {int precision = defaultPrecision}) {
    // Avoid scientific notation for very large or small numbers in typical display
    if (value.abs() > 1e12 || (value.abs() < 1e-9 && value != 0)) {
      return value.toStringAsExponential(precision);
    }

    // Convert to a fixed string to handle precision
    String asFixed = value.toStringAsFixed(precision);

    // Remove trailing zeros and the decimal point if it becomes unnecessary
    if (asFixed.contains('.')) {
      asFixed = asFixed.replaceAll(RegExp(r'0+$'), '');
      if (asFixed.endsWith('.')) {
        asFixed = asFixed.substring(0, asFixed.length - 1);
      }
    }

    return asFixed;
  }
}
