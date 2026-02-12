// lib/services/calculator_service.dart

import 'dart:math';
import 'package:financial_calculator/models/calculator_result.dart';

class BasicCalculatorService {
  double _memory = 0;

  // Basic Operations
  CalculatorResult<double> add(double a, double b) {
    return CalculatorResult.success(a + b);
  }

  CalculatorResult<double> subtract(double a, double b) {
    return CalculatorResult.success(a - b);
  }

  CalculatorResult<double> multiply(double a, double b) {
    return CalculatorResult.success(a * b);
  }

  CalculatorResult<double> divide(double a, double b) {
    if (b == 0) {
      return CalculatorResult.error('Cannot divide by zero');
    }
    return CalculatorResult.success(a / b);
  }

  // Scientific Operations
  CalculatorResult<double> percentage(double value, double percent) {
    return CalculatorResult.success((value * percent) / 100);
  }

  CalculatorResult<double> square(double value) {
    return CalculatorResult.success(value * value);
  }

  CalculatorResult<double> squareRoot(double value) {
    if (value < 0) {
      return CalculatorResult.error('Cannot calculate square root of negative number');
    }
    return CalculatorResult.success(sqrt(value));
  }

  CalculatorResult<double> power(double base, double exponent) {
    return CalculatorResult.success(pow(base, exponent).toDouble());
  }

  CalculatorResult<double> reciprocal(double value) {
    if (value == 0) {
      return CalculatorResult.error('Cannot calculate reciprocal of zero');
    }
    return CalculatorResult.success(1 / value);
  }

  CalculatorResult<double> abs(double value) {
    return CalculatorResult.success(value.abs());
  }

  // Memory Functions
  CalculatorResult<void> memoryAdd(double value) {
    _memory += value;
    return CalculatorResult.success(null);
  }

  CalculatorResult<void> memorySubtract(double value) {
    _memory -= value;
    return CalculatorResult.success(null);
  }

  CalculatorResult<double> memoryRecall() {
    return CalculatorResult.success(_memory);
  }

  CalculatorResult<void> memoryClear() {
    _memory = 0;
    return CalculatorResult.success(null);
  }

  double getMemoryValue() => _memory;

}
