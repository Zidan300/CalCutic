import 'package:get/get.dart';

class FinancialCalculatorProvider extends GetxController {
  // GST
  final _gstResult = <String, double>{}.obs;
  Map<String, double> get gstResult => _gstResult;
  void calculateGst(String basePrice, String gstRate) {
    final doubleBasePrice = double.tryParse(basePrice) ?? 0;
    final doubleGstRate = double.tryParse(gstRate) ?? 0;
    final gstAmount = doubleBasePrice * (doubleGstRate / 100);
    final finalPrice = doubleBasePrice + gstAmount;
    _gstResult.value = {'gstAmount': gstAmount, 'finalPrice': finalPrice};
  }

  // Discount
  final _discountResult = <String, double>{}.obs;
  Map<String, double> get discountResult => _discountResult;
  void calculateDiscount(String originalPrice, String discountPercent) {
    final doubleOriginalPrice = double.tryParse(originalPrice) ?? 0;
    final doubleDiscountPercent = double.tryParse(discountPercent) ?? 0;
    final discountAmount = doubleOriginalPrice * (doubleDiscountPercent / 100);
    final finalPrice = doubleOriginalPrice - discountAmount;
    _discountResult.value = {'discountAmount': discountAmount, 'finalPrice': finalPrice};
  }

  // Savings Goal
  final _savingsResult = <String, double>{}.obs;
  Map<String, double> get savingsResult => _savingsResult;
  void calculateSavingsGoal(String targetAmount, String monthlyContribution) {
    final doubleTargetAmount = double.tryParse(targetAmount) ?? 0;
    final doubleMonthlyContribution = double.tryParse(monthlyContribution) ?? 0;
    if (doubleMonthlyContribution == 0) {
      _savingsResult.value = {'monthsRequired': 0, 'yearsRequired': 0};
      return;
    }
    final monthsRequired = doubleTargetAmount / doubleMonthlyContribution;
    _savingsResult.value = {'monthsRequired': monthsRequired, 'yearsRequired': monthsRequired / 12};
  }

  // Inflation
  final _inflationResult = <String, double>{}.obs;
  Map<String, double> get inflationResult => _inflationResult;
  void calculateInflation(String presentValue, String inflationRate, String years) {
    final doublePresentValue = double.tryParse(presentValue) ?? 0;
    final doubleInflationRate = double.tryParse(inflationRate) ?? 0;
    final doubleYears = double.tryParse(years) ?? 0;
    final futureValue = doublePresentValue * (1 + (doubleInflationRate / 100)) * doubleYears;
    final valueEroded = futureValue - doublePresentValue;
    _inflationResult.value = {'futureValue': futureValue, 'valueEroded': valueEroded};
  }

  // Profit & Loss
  final _profiLossResult = <String, double>{}.obs;
  Map<String, double> get profiLossResult => _profiLossResult;
  void calculateProfitLoss(String costPrice, String sellingPrice) {
    final doubleCostPrice = double.tryParse(costPrice) ?? 0;
    final doubleSellingPrice = double.tryParse(sellingPrice) ?? 0;
    final profitLoss = doubleSellingPrice - doubleCostPrice;
    final profitLossPercent = (profitLoss / doubleCostPrice) * 100;
    _profiLossResult.value = {
      'profitLoss': profitLoss,
      'profitLossPercent': profitLossPercent,
      'type': profitLoss >= 0 ? 1 : 0,
    };
  }

  // Break-even
  final _breakEvenResult = <String, double>{}.obs;
  Map<String, double> get breakEvenResult => _breakEvenResult;
  void calculateBreakEven(String fixedCosts, String costPerUnit, String pricePerUnit) {
    final doubleFixedCosts = double.tryParse(fixedCosts) ?? 0;
    final doubleCostPerUnit = double.tryParse(costPerUnit) ?? 0;
    final doublePricePerUnit = double.tryParse(pricePerUnit) ?? 0;
    if (doublePricePerUnit <= doubleCostPerUnit) {
      _breakEvenResult.value = {'breakEvenUnits': 0, 'breakEvenSales': 0};
      return;
    }
    final breakEvenUnits = doubleFixedCosts / (doublePricePerUnit - doubleCostPerUnit);
    final breakEvenSales = breakEvenUnits * doublePricePerUnit;
    _breakEvenResult.value = {'breakEvenUnits': breakEvenUnits, 'breakEvenSales': breakEvenSales};
  }
}
