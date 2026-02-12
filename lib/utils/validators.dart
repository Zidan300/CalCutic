// lib/utils/validators.dart

class InputValidator {
  // Validate positive number
  static bool isValidPositiveNumber(String value) {
    if (value.isEmpty) return false;
    try {
      final number = double.parse(value);
      return number >= 0;
    } catch (e) {
      return false;
    }
  }

  // Validate positive non-zero number
  static bool isValidPositiveNonZero(String value) {
    if (value.isEmpty) return false;
    try {
      final number = double.parse(value);
      return number > 0;
    } catch (e) {
      return false;
    }
  }

  // Get error message
  static String getErrorMessage(String fieldName) {
    return 'Please enter a valid $fieldName';
  }

  // Parse double safely
  static double? parseDouble(String value) {
    try {
      return double.parse(value);
    } catch (e) {
      return null;
    }
  }
}
