import 'package:get/get.dart';
import 'package:financial_calculator/history/history_manager.dart';
import 'package:financial_calculator/models/history_model.dart';
import 'package:financial_calculator/utils/number_formatter.dart';

class SimpleInterestCalculatorProvider extends GetxController {
  final HistoryManager _historyManager = HistoryManager();
  final _principal = 0.0.obs;
  final _rate = 0.0.obs;
  final _time = 0.0.obs;
  final _interest = 0.0.obs;
  final _totalAmount = 0.0.obs;

  double get principal => _principal.value;
  double get rate => _rate.value;
  double get time => _time.value;
  double get interest => _interest.value;
  double get totalAmount => _totalAmount.value;

  void setPrincipal(String value) {
    _principal.value = double.tryParse(value) ?? 0;
    calculate();
  }

  void setRate(String value) {
    _rate.value = double.tryParse(value) ?? 0;
    calculate();
  }

  void setTime(String value) {
    _time.value = double.tryParse(value) ?? 0;
    calculate();
  }

  void calculate() {
    if (_principal.value > 0 && _rate.value > 0 && _time.value > 0) {
      double interestAmount = (_principal.value * _rate.value * _time.value) / 100;
      _interest.value = interestAmount;
      _totalAmount.value = _principal.value + interestAmount;

      // Add to history
      final expression = 'P: ${NumberFormatter.formatDecimal(_principal.value)}, R: ${NumberFormatter.formatDecimal(_rate.value)}%, T: ${NumberFormatter.formatDecimal(_time.value)} yrs';
      final result = 'Interest: ${NumberFormatter.formatDecimal(_interest.value)}, Total: ${NumberFormatter.formatDecimal(_totalAmount.value)}';
      _historyManager.addToHistory(HistoryModel(expression: expression, result: result, timestamp: DateTime.now()));
    } else {
      _interest.value = 0;
      _totalAmount.value = _principal.value;
    }
  }
}
