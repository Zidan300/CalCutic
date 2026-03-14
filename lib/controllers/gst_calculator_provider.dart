import 'package:get/get.dart';
import 'package:financial_calculator/history/history_manager.dart';
import 'package:financial_calculator/models/history_model.dart';
import 'package:financial_calculator/utils/number_formatter.dart';

class GstCalculatorProvider extends GetxController {
  final HistoryManager _historyManager = HistoryManager();
  final _amount = 0.0.obs;
  final _rate = 0.0.obs;
  final _gstAmount = 0.0.obs;
  final _totalAmount = 0.0.obs;

  double get amount => _amount.value;
  double get rate => _rate.value;
  double get gstAmount => _gstAmount.value;
  double get totalAmount => _totalAmount.value;

  void setAmount(String value) {
    _amount.value = double.tryParse(value) ?? 0;
    calculate();
  }

  void setRate(String value) {
    _rate.value = double.tryParse(value) ?? 0;
    calculate();
  }

  void calculate() {
    if (_amount.value > 0 && _rate.value > 0) {
      double gst = _amount.value * (_rate.value / 100);
      _gstAmount.value = gst;
      _totalAmount.value = _amount.value + gst;

      // Add to history
      final expression = 'Amount: ${NumberFormatter.formatDecimal(_amount.value)}, GST Rate: ${NumberFormatter.formatDecimal(_rate.value)}%';
      final result = 'GST Amount: ${NumberFormatter.formatDecimal(_gstAmount.value)}, Total Amount: ${NumberFormatter.formatDecimal(_totalAmount.value)}';
      _historyManager.addToHistory(HistoryModel(expression: expression, result: result, timestamp: DateTime.now()));
    } else {
      _gstAmount.value = 0;
      _totalAmount.value = _amount.value;
    }
  }
}
