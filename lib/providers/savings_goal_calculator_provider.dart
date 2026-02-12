import 'package:get/get.dart';

class SavingsGoalCalculatorProvider extends GetxController {
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
    } else {
      _months.value = 0;
    }
  }
}
