import 'package:get/get.dart';
import 'dart:math';

class InflationCalculatorProvider extends GetxController {
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
    } else {
      _futureValue.value = _initialAmount.value;
    }
  }
}
