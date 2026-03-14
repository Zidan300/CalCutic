import 'package:get/get.dart';

class BreakEvenCalculatorProvider extends GetxController {
  final _fixedCosts = 0.0.obs;
  final _variableCostPerUnit = 0.0.obs;
  final _sellingPricePerUnit = 0.0.obs;
  final _breakEvenUnits = 0.0.obs;

  double get fixedCosts => _fixedCosts.value;
  double get variableCostPerUnit => _variableCostPerUnit.value;
  double get sellingPricePerUnit => _sellingPricePerUnit.value;
  double get breakEvenUnits => _breakEvenUnits.value;

  void setFixedCosts(String value) {
    _fixedCosts.value = double.tryParse(value) ?? 0;
    calculate();
  }

  void setVariableCostPerUnit(String value) {
    _variableCostPerUnit.value = double.tryParse(value) ?? 0;
    calculate();
  }

  void setSellingPricePerUnit(String value) {
    _sellingPricePerUnit.value = double.tryParse(value) ?? 0;
    calculate();
  }

  void calculate() {
    if (_fixedCosts.value > 0 && _sellingPricePerUnit.value > _variableCostPerUnit.value) {
      _breakEvenUnits.value = _fixedCosts.value / (_sellingPricePerUnit.value - _variableCostPerUnit.value);
    } else {
      _breakEvenUnits.value = 0;
    }
  }
}
