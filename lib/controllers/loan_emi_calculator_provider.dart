import 'package:get/get.dart';
import 'dart:math';
import 'package:financial_calculator/history/history_manager.dart';
import 'package:financial_calculator/models/history_model.dart';
import 'package:financial_calculator/utils/number_formatter.dart';

class LoanEmiCalculatorProvider extends GetxController {
  final HistoryManager _historyManager = HistoryManager();
  final _loanAmount = 0.0.obs;
  final _interestRate = 0.0.obs;
  final _tenure = 0.0.obs;
  final _emi = 0.0.obs;
  final _totalInterest = 0.0.obs;
  final _totalAmount = 0.0.obs;

  double get loanAmount => _loanAmount.value;
  double get interestRate => _interestRate.value;
  double get tenure => _tenure.value;
  double get emi => _emi.value;
  double get totalInterest => _totalInterest.value;
  double get totalAmount => _totalAmount.value;

  void setLoanAmount(String value) {
    _loanAmount.value = double.tryParse(value) ?? 0;
    calculate();
  }

  void setInterestRate(String value) {
    _interestRate.value = double.tryParse(value) ?? 0;
    calculate();
  }

  void setTenure(String value) {
    _tenure.value = double.tryParse(value) ?? 0;
    calculate();
  }

  void calculate() {
    if (_loanAmount.value > 0 && _interestRate.value > 0 && _tenure.value > 0) {
      double monthlyInterestRate = (_interestRate.value / 12) / 100;
      double numberOfMonths = _tenure.value * 12;
      double emiValue = (_loanAmount.value * monthlyInterestRate * pow(1 + monthlyInterestRate, numberOfMonths)) / (pow(1 + monthlyInterestRate, numberOfMonths) - 1);
      _emi.value = emiValue;
      double totalAmountValue = emiValue * numberOfMonths;
      _totalAmount.value = totalAmountValue;
      _totalInterest.value = totalAmountValue - _loanAmount.value;

      // Add to history
      final expression = 'Loan: ${NumberFormatter.formatDecimal(_loanAmount.value)}, Rate: ${NumberFormatter.formatDecimal(_interestRate.value)}%, Tenure: ${NumberFormatter.formatDecimal(_tenure.value)} yrs';
      final result = 'EMI: ${NumberFormatter.formatDecimal(_emi.value)}, Total Interest: ${NumberFormatter.formatDecimal(_totalInterest.value)}, Total Amount: ${NumberFormatter.formatDecimal(_totalAmount.value)}';
      _historyManager.addToHistory(HistoryModel(expression: expression, result: result, timestamp: DateTime.now()));
    } else {
      _emi.value = 0;
      _totalInterest.value = 0;
      _totalAmount.value = _loanAmount.value;
    }
  }
}
