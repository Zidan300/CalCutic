import 'package:get/get.dart';
import 'package:financial_calculator/history/history_manager.dart';
import 'package:financial_calculator/models/history_model.dart';

class BreakEvenCalculatorProvider extends GetxController {
  final HistoryManager _historyManager = HistoryManager();
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
      // Add to history
      final expression = 'Fixed Costs: ${_fixedCosts.value}, Variable Cost/Unit: ${_variableCostPerUnit.value}, Selling Price/Unit: ${_sellingPricePerUnit.value}';
      final result = 'Break-Even Units: ${_breakEvenUnits.value.toStringAsFixed(2)}';
      _historyManager.addToHistory(HistoryModel(expression: expression, result: result, timestamp: DateTime.now()));
    } else {
      _breakEvenUnits.value = 0;
    }
  }
}
