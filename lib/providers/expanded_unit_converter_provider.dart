import 'package:get/get.dart';

class ExpandedUnitConverterProvider extends GetxController {
  final _inputValue = '0'.obs;
  final _fromUnit = 'Millimeter'.obs;
  final _toUnit = 'Centimeter'.obs;
  final _result = '0'.obs;
  final _conversionType = 'Length'.obs;

  String get inputValue => _inputValue.value;
  String get fromUnit => _fromUnit.value;
  String get toUnit => _toUnit.value;
  String get result => _result.value;
  String get conversionType => _conversionType.value;

  final Map<String, List<String>> unitTypes = {
    'Length': ['Millimeter', 'Centimeter', 'Meter', 'Kilometer'],
    'Weight': ['Gram', 'Kilogram', 'Pound'],
    'Volume': ['Milliliter', 'Liter'],
    'Temperature': ['Celsius', 'Fahrenheit'],
  };

  // Base unit conversion factors (all converted to base unit)
  final Map<String, double> _conversionFactors = {
    // Length - base: meter
    'Millimeter': 0.001,
    'Centimeter': 0.01,
    'Meter': 1.0,
    'Kilometer': 1000.0,
    // Weight - base: kilogram
    'Gram': 0.001,
    'Kilogram': 1.0,
    'Pound': 0.453592,
    // Volume - base: liter
    'Milliliter': 0.001,
    'Liter': 1.0,
    // Temperature - handled separately
    'Celsius': 0.0, // placeholder
    'Fahrenheit': 32.0, // placeholder
  };

  void setConversionType(String? type) {
    if (type == null) return;
    _conversionType.value = type;
    _fromUnit.value = unitTypes[type]![0];
    _toUnit.value = unitTypes[type]![1];
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
    if (_conversionType.value == 'Temperature') {
      _convertTemperature();
      return;
    }

    double? input = double.tryParse(_inputValue.value);
    if (input == null || input < 0) {
      _result.value = '0';
      return;
    }

    double? fromFactor = _conversionFactors[_fromUnit.value];
    double? toFactor = _conversionFactors[_toUnit.value];

    if (fromFactor == null || toFactor == null) {
      _result.value = 'Error';
      return;
    }

    double resultValue = input * fromFactor / toFactor;
    _result.value = _formatResult(resultValue);
  }

  void _convertTemperature() {
    double? input = double.tryParse(_inputValue.value);
    if (input == null) {
      _result.value = '0';
      return;
    }

    double resultValue = 0.0;

    if (_fromUnit.value == 'Celsius' && _toUnit.value == 'Fahrenheit') {
      resultValue = (input * 9 / 5) + 32;
    } else if (_fromUnit.value == 'Fahrenheit' && _toUnit.value == 'Celsius') {
      resultValue = (input - 32) * 5 / 9;
    } else {
      resultValue = input; // Same unit
    }

    _result.value = _formatResult(resultValue);
  }

  String _formatResult(double value) {
    if (value.isNaN || value.isInfinite) return 'Error';
    if (value == value.toInt()) return value.toInt().toString();
    return value.toStringAsFixed(6).replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '');
  }
}
