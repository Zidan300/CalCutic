// lib/services/financial_calculator_service.dart

import 'dart:math';

class CalculationResult<T> {
  final bool success;
  final T? data;
  final String? error;

  CalculationResult({required this.success, this.data, this.error});
}

class FinancialCalculatorService {
  // GST
  CalculationResult<Map<String, double>> calculateGST({
    required double basePrice,
    required double gstRate,
  }) {
    final gstAmount = basePrice * (gstRate / 100);
    final finalPrice = basePrice + gstAmount;
    return CalculationResult(
      success: true,
      data: {'gstAmount': gstAmount, 'finalPrice': finalPrice},
    );
  }

  // Discount
  CalculationResult<Map<String, double>> calculateDiscount({
    required double originalPrice,
    required double discountPercent,
  }) {
    final discountAmount = originalPrice * (discountPercent / 100);
    final finalPrice = originalPrice - discountAmount;
    return CalculationResult(
      success: true,
      data: {'discountAmount': discountAmount, 'finalPrice': finalPrice},
    );
  }

  // Currency Converter
  CalculationResult<Map<String, dynamic>> convertCurrency({
    required double amount,
    required String fromCurrency,
    required String toCurrency,
  }) {
    // Dummy conversion rates
    final rates = {
      'INR': {'USD': 0.012, 'EUR': 0.011, 'GBP': 0.0095},
      'USD': {'INR': 83.0, 'EUR': 0.92, 'GBP': 0.79},
      'EUR': {'INR': 90.0, 'USD': 1.08, 'GBP': 0.86},
      'GBP': {'INR': 105.0, 'USD': 1.27, 'EUR': 1.16},
    };

    if (fromCurrency == toCurrency) {
      return CalculationResult(success: true, data: {'convertedAmount': amount});
    }

    final convertedAmount = amount * (rates[fromCurrency]![toCurrency] ?? 1.0);
    return CalculationResult(
      success: true,
      data: {'convertedAmount': convertedAmount},
    );
  }

  // Savings Goal
  CalculationResult<Map<String, double>> calculateSavingsGoal({
    required double targetAmount,
    required double monthlyContribution,
  }) {
    final monthsRequired = targetAmount / monthlyContribution;
    return CalculationResult(
      success: true,
      data: {
        'monthsRequired': monthsRequired,
        'yearsRequired': monthsRequired / 12,
      },
    );
  }

  // Inflation
  CalculationResult<Map<String, double>> calculateInflation({
    required double presentValue,
    required double inflationRate,
    required double years,
  }) {
    final futureValue = presentValue * pow(1 + (inflationRate / 100), years);
    final valueEroded = futureValue - presentValue;
    return CalculationResult(
      success: true,
      data: {'futureValue': futureValue, 'valueEroded': valueEroded},
    );
  }

  // Profit & Loss
  CalculationResult<Map<String, double>> calculateProfitLoss({
    required double costPrice,
    required double sellingPrice,
  }) {
    final profitLoss = sellingPrice - costPrice;
    final profitLossPercent = (profitLoss / costPrice) * 100;
    return CalculationResult(
      success: true,
      data: {
        'profitLoss': profitLoss,
        'profitLossPercent': profitLossPercent,
        'type': profitLoss >= 0 ? 1 : 0, // 1 for profit, 0 for loss
      },
    );
  }

  // Break-even
  CalculationResult<Map<String, double>> calculateBreakEven({
    required double fixedCosts,
    required double costPerUnit,
    required double pricePerUnit,
  }) {
    if (pricePerUnit <= costPerUnit) {
      return CalculationResult(
        success: false,
        error: 'Price per unit must be greater than cost per unit',
      );
    }
    final breakEvenUnits = fixedCosts / (pricePerUnit - costPerUnit);
    final breakEvenSales = breakEvenUnits * pricePerUnit;
    return CalculationResult(
      success: true,
      data: {
        'breakEvenUnits': breakEvenUnits,
        'breakEvenSales': breakEvenSales,
      },
    );
  }
}
