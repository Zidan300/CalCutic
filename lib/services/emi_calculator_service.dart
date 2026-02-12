// lib/services/emi_calculator_service.dart

import 'dart:math' show pow;
import 'package:financial_calculator/models/calculator_result.dart';

class EMICalculatorService {
  // EMI = [P * r * (1+r)^n] / [(1+r)^n - 1]
  // Where P = Principal, r = monthly rate, n = total months
  CalculatorResult<Map<String, dynamic>> calculateEMI({
    required double principal,
    required double annualRate,
    required double tenureMonths,
  }) {
    try {
      if (principal <= 0 || annualRate < 0 || tenureMonths <= 0) {
        return CalculatorResult.error('Please enter valid values');
      }

      final monthlyRate = annualRate / 12 / 100;
      final n = tenureMonths;

      late double emi;
      if (monthlyRate == 0) {
        emi = principal / tenureMonths;
      } else {
        final numerator = principal * monthlyRate * pow(1 + monthlyRate, n);
        final denominator = pow(1 + monthlyRate, n) - 1;
        emi = numerator / denominator;
      }

      final totalPayment = emi * tenureMonths;
      final totalInterest = totalPayment - principal;

      // Generate amortization schedule
      final schedule = _generateAmortizationSchedule(
        principal: principal,
        monthlyRate: monthlyRate,
        tenureMonths: tenureMonths.toInt(),
        emi: emi,
      );

      return CalculatorResult.success({
        'principal': principal,
        'annualRate': annualRate,
        'tenureMonths': tenureMonths,
        'emi': emi,
        'totalInterest': totalInterest,
        'totalPayment': totalPayment,
        'amortizationSchedule': schedule,
      });
    } catch (e) {
      return CalculatorResult.error('Calculation error: ${e.toString()}');
    }
  }

  List<Map<String, dynamic>> _generateAmortizationSchedule({
    required double principal,
    required double monthlyRate,
    required int tenureMonths,
    required double emi,
  }) {
    final schedule = <Map<String, dynamic>>[];
    double balance = principal;

    for (int i = 1; i <= tenureMonths; i++) {
      final interest = balance * monthlyRate;
      final principalPaid = emi - interest;
      balance -= principalPaid;

      schedule.add({
        'month': i,
        'emi': emi,
        'principal': principalPaid > 0 ? principalPaid : 0,
        'interest': interest,
        'balance': balance > 0 ? balance : 0,
      });
    }

    return schedule;
  }
}
