import 'package:get/get.dart';

class LoanEmiCalculatorProvider extends GetxController {
  final _principal = '0'.obs;
  final _annualRate = '0'.obs;
  final _timeValue = '1'.obs;
  final _timeUnit = 'years'.obs; // years or months
  final _monthlyEMI = '0.0'.obs;
  final _totalInterest = '0.0'.obs;
  final _totalPayment = '0.0'.obs;

  String get principal => _principal.value;
  String get annualRate => _annualRate.value;
  String get timeValue => _timeValue.value;
  String get timeUnit => _timeUnit.value;
  String get monthlyEMI => _monthlyEMI.value;
  String get totalInterest => _totalInterest.value;
  String get totalPayment => _totalPayment.value;

  void setPrincipal(String value) {
    _principal.value = value;
    _calculateEMI();
  }

  void setAnnualRate(String value) {
    _annualRate.value = value;
    _calculateEMI();
  }

  void setTimeValue(String value) {
    _timeValue.value = value;
    _calculateEMI();
  }

  void setTimeUnit(String? unit) {
    if (unit == null) return;
    _timeUnit.value = unit;
    _calculateEMI();
  }

  void _calculateEMI() {
    double? principal = double.tryParse(_principal.value);
    double? annualRate = double.tryParse(_annualRate.value);
    double? timeValue = double.tryParse(_timeValue.value);

    if (principal == null || annualRate == null || timeValue == null || 
        principal <= 0 || annualRate < 0 || timeValue <= 0) {
      _monthlyEMI.value = '0.0';
      _totalInterest.value = '0.0';
      _totalPayment.value = '0.0';
      return;
    }

    // Convert time to months
    int totalMonths = _timeUnit.value == 'years' ? 
        (timeValue * 12).toInt() : timeValue.toInt();

    if (totalMonths <= 0) {
      _monthlyEMI.value = '0.0';
      _totalInterest.value = '0.0';
      _totalPayment.value = '0.0';
      return;
    }

    // Monthly interest rate
    double monthlyRate = annualRate / 12 / 100;

    double emi = 0.0;
    
    if (monthlyRate == 0) {
      // If interest rate is 0, simple division
      emi = principal / totalMonths;
    } else {
      // EMI formula: P * r * (1 + r)^n / ((1 + r)^n - 1)
      double numerator = principal * monthlyRate * 
          _power(1 + monthlyRate, totalMonths);
      double denominator = _power(1 + monthlyRate, totalMonths) - 1;
      emi = numerator / denominator;
    }

    double totalPayment = emi * totalMonths;
    double totalInterest = totalPayment - principal;

    _monthlyEMI.value = emi.toStringAsFixed(2);
    _totalInterest.value = totalInterest.toStringAsFixed(2);
    _totalPayment.value = totalPayment.toStringAsFixed(2);
  }

  // Helper function for power calculation
  double _power(double base, int exponent) {
    double result = 1.0;
    for (int i = 0; i < exponent; i++) {
      result *= base;
    }
    return result;
  }

  void clear() {
    _principal.value = '0';
    _annualRate.value = '0';
    _timeValue.value = '1';
    _timeUnit.value = 'years';
    _monthlyEMI.value = '0.0';
    _totalInterest.value = '0.0';
    _totalPayment.value = '0.0';
  }
}
