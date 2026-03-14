import 'package:get/get.dart';
import 'package:financial_calculator/history/history_manager.dart';
import 'package:financial_calculator/models/history_model.dart';
import 'package:financial_calculator/utils/number_formatter.dart';

class SavingsGoalCalculatorProvider extends GetxController {
  final HistoryManager _historyManager = HistoryManager();
  final _targetAmount = 0.0.obs;
  final _currentAmount = 0.0.obs;
  final _monthlyContribution = 0.0.obs;
  final _months = 0.obs;

  double get targetAmount => _targetAmount.value;
  double get currentAmount => _currentAmount.value;
  double get monthlyContribution => _monthlyContribution.value;
  int get months => _months.value;

  void setTargetAmount(String value) {
    _targetAmount.value = double.tryParse(value) ?? 0;
    calculate();
  }

  void setCurrentAmount(String value) {
    _currentAmount.value = double.tryParse(value) ?? 0;
    calculate();
  }

  void setMonthlyContribution(String value) {
    _monthlyContribution.value = double.tryParse(value) ?? 0;
    calculate();
  }

  void calculate() {
    if (_targetAmount.value > _currentAmount.value && _monthlyContribution.value > 0) {
      double remainingAmount = _targetAmount.value - _currentAmount.value;
      _months.value = (remainingAmount / _monthlyContribution.value).ceil();

      // Add to history
      final expression = 'Target: ${NumberFormatter.formatDecimal(_targetAmount.value)}, Current: ${NumberFormatter.formatDecimal(_currentAmount.value)}, Monthly: ${NumberFormatter.formatDecimal(_monthlyContribution.value)}';
      final result = 'Months to Goal: ${_months.value}';
      _historyManager.addToHistory(HistoryModel(expression: expression, result: result, timestamp: DateTime.now()));
    } else {
      _months.value = 0;
    }
  }
}
