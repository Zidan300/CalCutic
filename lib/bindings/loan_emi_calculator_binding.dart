import 'package:get/get.dart';
import 'package:financial_calculator/controllers/loan_emi_calculator_provider.dart';

class LoanEmiCalculatorBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoanEmiCalculatorProvider());
  }
}
