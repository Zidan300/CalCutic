import 'package:get/get.dart';

class SimpleInterestCalculatorProvider extends GetxController {
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
    } else {
      _interest.value = 0;
      _totalAmount.value = _principal.value;
    }
  }
}
