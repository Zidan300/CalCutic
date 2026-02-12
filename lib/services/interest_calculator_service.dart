// lib/services/interest_calculator_service.dart

import 'dart:math';
import 'package:financial_calculator/utils/constants.dart';

class CalculationResult<T> {
  final bool success;
  final T? data;
  final String? error;

  CalculationResult({required this.success, this.data, this.error});
}

class InterestCalculatorService {
  CalculationResult<Map<String, double>> calculateSimpleInterest({
    required double principal,
    required double rate,
    required double time,
  }) {
    if (principal <= 0 || rate < 0 || time <= 0) {
      return CalculationResult(
        success: false,
        error: 'Principal, rate, and time must be positive.',
      );
    }

    final simpleInterest = (principal * rate * time) / 100;
    final totalAmount = principal + simpleInterest;

    return CalculationResult(
      success: true,
      data: {
        'simpleInterest': simpleInterest,
        'totalAmount': totalAmount,
      },
    );
  }

  CalculationResult<Map<String, dynamic>> calculateCompoundInterest({
    required double principal,
    required double rate,
    required double time,
    required CompoundingPeriod period,
  }) {
    if (principal <= 0 || rate < 0 || time <= 0) {
      return CalculationResult(
        success: false,
        error: 'Principal, rate, and time must be positive.',
      );
    }

    final n = period.value;
    final r = rate / 100;
    final totalAmount = principal * pow((1 + r / n), (n * time));
    final compoundInterest = totalAmount - principal;

    return CalculationResult(
      success: true,
      data: {
        'compoundInterest': compoundInterest,
        'totalAmount': totalAmount,
      },
    );
  }
}
