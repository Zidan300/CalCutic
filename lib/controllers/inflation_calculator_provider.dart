import 'package:get/get.dart';
import 'dart:math';
import 'package:financial_calculator/history/history_manager.dart';
import 'package:financial_calculator/models/history_model.dart';
import 'package:financial_calculator/utils/number_formatter.dart';

class InflationCalculatorProvider extends GetxController {
  final HistoryManager _historyManager = HistoryManager();
  final _initialAmount = 0.0.obs;
  final _inflationRate = 0.0.obs;
  final _years = 0.0.obs;
  final _futureValue = 0.0.obs;

  double get initialAmount => _initialAmount.value;
  double get inflationRate => _inflationRate.value;
  double get years => _years.value;
  double get futureValue => _futureValue.value;

  void setInitialAmount(String value) {
    _initialAmount.value = double.tryParse(value) ?? 0;
    calculate();
  }

  void setInflationRate(String value) {
    _inflationRate.value = double.tryParse(value) ?? 0;
    calculate();
  }

  void setYears(String value) {
    _years.value = double.tryParse(value) ?? 0;
    calculate();
  }

  void calculate() {
    if (_initialAmount.value > 0 && _inflationRate.value > 0 && _years.value > 0) {
      _futureValue.value = _initialAmount.value * pow(1 + (_inflationRate.value / 100), _years.value);
      // Add to history
      final expression = 'Initial: ${NumberFormatter.formatDecimal(_initialAmount.value)}, Rate: ${NumberFormatter.formatDecimal(_inflationRate.value)}%, Years: ${NumberFormatter.formatDecimal(_years.value)}';
      final result = 'Future Value: ${NumberFormatter.formatDecimal(_futureValue.value)}';
      _historyManager.addToHistory(HistoryModel(expression: expression, result: result, timestamp: DateTime.now()));
    } else {
      _futureValue.value = _initialAmount.value;
    }
  }
}
