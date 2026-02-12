import 'package:get/get.dart';

class UnitConverterProvider extends GetxController {
  final _inputValue = '0'.obs;
  final _fromUnit = 'Meter'.obs;
  final _toUnit = 'Centimeter'.obs;
  final _result = '0'.obs;
  final _conversionType = 'Length'.obs;

  String get inputValue => _inputValue.value;
  String get fromUnit => _fromUnit.value;
  String get toUnit => _toUnit.value;
  String get result => _result.value;
  String get conversionType => _conversionType.value;

  final Map<String, List<String>> unitTypes = {
    'Length': ['Meter', 'Centimeter', 'Kilometer'],
    'Weight': ['Kilogram', 'Gram'],
    'Volume': ['Liter', 'Milliliter'],
  };

  final Map<String, double> _conversionFactors = {
    'Meter': 1.0,
    'Centimeter': 0.01,
    'Kilometer': 1000.0,
    'Kilogram': 1.0,
    'Gram': 0.001,
    'Liter': 1.0,
    'Milliliter': 0.001,
  };

  void setConversionType(String? type) {
    if (type == null) return;
    _conversionType.value = type;
    final units = unitTypes[type]!;
    _fromUnit.value = units[0];
    _toUnit.value = units.length > 1 ? units[1] : units[0];
    _convert();
  }

  void setInputValue(String value) {
    _inputValue.value = value;
    _convert();
  }

  void setFromUnit(String? unit) {
    if (unit == null) return;
    _fromUnit.value = unit;
    _convert();
  }

  void setToUnit(String? unit) {
    if (unit == null) return;
    _toUnit.value = unit;
    _convert();
  }

  void _convert() {
    double? input = double.tryParse(_inputValue.value);
    if (input == null) {
      _result.value = '0';
      return;
    }

    double fromFactor = _getConversionFactor(_fromUnit.value);
    double toFactor = _getConversionFactor(_toUnit.value);

    double resultValue = input * fromFactor / toFactor;
    _result.value = _formatResult(resultValue);
  }

  double _getConversionFactor(String unit) {
    return _conversionFactors[unit] ?? 1.0;
  }

  String _formatResult(double value) {
    try {
      if (value.isNaN || value.isInfinite) return 'Error';
      if (value == value.toInt()) return value.toInt().toString();
      return value.toStringAsFixed(4).replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '');
    } catch (e) {
      return 'Error';
    }
  }
}
