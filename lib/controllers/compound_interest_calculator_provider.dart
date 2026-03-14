import 'package:get/get.dart';
import 'package:financial_calculator/history/history_manager.dart';
import 'package:financial_calculator/models/history_model.dart';
import 'package:financial_calculator/utils/number_formatter.dart';
import 'dart:math' as math;

class CompoundInterestCalculatorProvider extends GetxController {
  final HistoryManager _historyManager = HistoryManager();

  final _principal = 0.0.obs;
  final _rate = 0.0.obs; // Annual interest rate in percentage
  final _time = 0.0.obs; // Time in years
  final _compoundingFrequency = 1.obs; // N: 1=annually, 2=semi-annually, 4=quarterly, 12=monthly

  final _interest = 0.0.obs;
  final _totalAmount = 0.0.obs;

  double get principal => _principal.value;
  double get rate => _rate.value;
  double get time => _time.value;
  int get compoundingFrequency => _compoundingFrequency.value;
  double get interest => _interest.value;
  double get totalAmount => _totalAmount.value;

  void setPrincipal(String value) {
    _principal.value = double.tryParse(value) ?? 0.0;
    _calculateCompoundInterest();
  }

  void setRate(String value) {
    _rate.value = double.tryParse(value) ?? 0.0;
    _calculateCompoundInterest();
  }

  void setTime(String value) {
    _time.value = double.tryParse(value) ?? 0.0;
    _calculateCompoundInterest();
  }

  void setCompoundingFrequency(int value) {
    _compoundingFrequency.value = value;
    _calculateCompoundInterest();
  }

  void _calculateCompoundInterest() {
    if (_principal.value <= 0 || _rate.value <= 0 || _time.value <= 0 || _compoundingFrequency.value <= 0) {
      _interest.value = 0.0;
      _totalAmount.value = 0.0;
      return;
    }

    double r = _rate.value / 100; // Convert percentage to decimal
    int n = _compoundingFrequency.value;
    double t = _time.value;
    double p = _principal.value;

    // A = P(1 + r/n)^(nt)
    double amount = p * math.pow((1 + (r / n)), (n * t)).toDouble();
    _totalAmount.value = amount;
    _interest.value = amount - p;

    // Add to history
    final expression = 'P: ${NumberFormatter.formatDecimal(p)}, R: ${NumberFormatter.formatDecimal(_rate.value)}%, T: ${NumberFormatter.formatDecimal(t)} yrs, N: $n';
    final result = 'Total: ${NumberFormatter.formatDecimal(_totalAmount.value)}, Interest: ${NumberFormatter.formatDecimal(_interest.value)}';
    _historyManager.addToHistory(HistoryModel(expression: expression, result: result, timestamp: DateTime.now()));
  }
}
