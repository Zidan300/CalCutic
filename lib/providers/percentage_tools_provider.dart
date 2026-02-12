import 'package:get/get.dart';

class PercentageToolsProvider extends GetxController {
  // X% of Y tool
  final _xPercentValue = '0'.obs;
  final _ofYValue = '0'.obs;
  final _percentOfResult = '0.0'.obs;

  // Add percentage tool
  final _addBaseValue = '0'.obs;
  final _addPercentValue = '0'.obs;
  final _addPercentResult = '0.0'.obs;

  // Subtract percentage tool
  final _subtractBaseValue = '0'.obs;
  final _subtractPercentValue = '0'.obs;
  final _subtractPercentResult = '0.0'.obs;

  // Getters for X% of Y
  String get xPercentValue => _xPercentValue.value;
  String get ofYValue => _ofYValue.value;
  String get percentOfResult => _percentOfResult.value;

  // Getters for Add Percentage
  String get addBaseValue => _addBaseValue.value;
  String get addPercentValue => _addPercentValue.value;
  String get addPercentResult => _addPercentResult.value;

  // Getters for Subtract Percentage
  String get subtractBaseValue => _subtractBaseValue.value;
  String get subtractPercentValue => _subtractPercentValue.value;
  String get subtractPercentResult => _subtractPercentResult.value;

  // X% of Y setters
  void setXPercentValue(String value) {
    _xPercentValue.value = value;
    _calculatePercentOf();
  }

  void setOfYValue(String value) {
    _ofYValue.value = value;
    _calculatePercentOf();
  }

  void _calculatePercentOf() {
    double? xValue = double.tryParse(_xPercentValue.value);
    double? yValue = double.tryParse(_ofYValue.value);

    if (xValue == null || yValue == null || yValue == 0) {
      _percentOfResult.value = '0.0';
      return;
    }

    double result = (xValue / 100) * yValue;
    _percentOfResult.value = _formatResult(result);
  }

  // Add percentage setters
  void setAddBaseValue(String value) {
    _addBaseValue.value = value;
    _calculateAddPercent();
  }

  void setAddPercentValue(String value) {
    _addPercentValue.value = value;
    _calculateAddPercent();
  }

  void _calculateAddPercent() {
    double? baseValue = double.tryParse(_addBaseValue.value);
    double? percentValue = double.tryParse(_addPercentValue.value);

    if (baseValue == null || percentValue == null) {
      _addPercentResult.value = '0.0';
      return;
    }

    double percentAmount = (percentValue / 100) * baseValue;
    double result = baseValue + percentAmount;
    _addPercentResult.value = _formatResult(result);
  }

  // Subtract percentage setters
  void setSubtractBaseValue(String value) {
    _subtractBaseValue.value = value;
    _calculateSubtractPercent();
  }

  void setSubtractPercentValue(String value) {
    _subtractPercentValue.value = value;
    _calculateSubtractPercent();
  }

  void _calculateSubtractPercent() {
    double? baseValue = double.tryParse(_subtractBaseValue.value);
    double? percentValue = double.tryParse(_subtractPercentValue.value);

    if (baseValue == null || percentValue == null) {
      _subtractPercentResult.value = '0.0';
      return;
    }

    double percentAmount = (percentValue / 100) * baseValue;
    double result = baseValue - percentAmount;
    _subtractPercentResult.value = _formatResult(result);
  }

  void clearAll() {
    _xPercentValue.value = '0';
    _ofYValue.value = '0';
    _percentOfResult.value = '0.0';

    _addBaseValue.value = '0';
    _addPercentValue.value = '0';
    _addPercentResult.value = '0.0';

    _subtractBaseValue.value = '0';
    _subtractPercentValue.value = '0';
    _subtractPercentResult.value = '0.0';
  }

  String _formatResult(double value) {
    if (value.isNaN || value.isInfinite) return 'Error';
    if (value == value.toInt()) return value.toInt().toString();
    return value.toStringAsFixed(4).replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '');
  }
}
