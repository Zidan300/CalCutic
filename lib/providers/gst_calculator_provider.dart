import 'package:get/get.dart';

class GstCalculatorProvider extends GetxController {
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
    } else {
      _gstAmount.value = 0;
      _totalAmount.value = _amount.value;
    }
  }
}
