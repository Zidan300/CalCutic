import 'package:get/get.dart';

class BMICalculatorProvider extends GetxController {
  final _heightCm = '0'.obs;
  final _weightKg = '0'.obs;
  final _bmiValue = '0.0'.obs;
  final _bmiCategory = 'N/A'.obs;
  final _categoryColor = '#FFFF00'.obs;

  String get heightCm => _heightCm.value;
  String get weightKg => _weightKg.value;
  String get bmiValue => _bmiValue.value;
  String get bmiCategory => _bmiCategory.value;
  String get categoryColor => _categoryColor.value;

  void setHeight(String value) {
    _heightCm.value = value;
    _calculateBMI();
  }

  void setWeight(String value) {
    _weightKg.value = value;
    _calculateBMI();
  }

  void _calculateBMI() {
    double? height = double.tryParse(_heightCm.value);
    double? weight = double.tryParse(_weightKg.value);

    if (height == null || weight == null || height <= 0 || weight <= 0) {
      _bmiValue.value = '0.0';
      _bmiCategory.value = 'N/A';
      _categoryColor.value = '#FFFF00'; // Yellow
      return;
    }

    // BMI = weight (kg) / (height (m))^2
    double heightInMeters = height / 100;
    double bmi = weight / (heightInMeters * heightInMeters);

    _bmiValue.value = bmi.toStringAsFixed(1);
    _setCategory(bmi);
  }

  void _setCategory(double bmi) {
    if (bmi < 18.5) {
      _bmiCategory.value = 'Underweight';
      _categoryColor.value = '#3498DB'; // Blue
    } else if (bmi >= 18.5 && bmi < 25.0) {
      _bmiCategory.value = 'Normal Weight';
      _categoryColor.value = '#2ECC71'; // Green
    } else if (bmi >= 25.0 && bmi < 30.0) {
      _bmiCategory.value = 'Overweight';
      _categoryColor.value = '#F39C12'; // Orange
    } else {
      _bmiCategory.value = 'Obese';
      _categoryColor.value = '#E74C3C'; // Red
    }
  }

  void clear() {
    _heightCm.value = '0';
    _weightKg.value = '0';
    _bmiValue.value = '0.0';
    _bmiCategory.value = 'N/A';
    _categoryColor.value = '#FFFF00';
  }
}
