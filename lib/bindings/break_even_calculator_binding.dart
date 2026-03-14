import 'package:get/get.dart';
import 'package:financial_calculator/controllers/break_even_calculator_provider.dart';

class BreakEvenCalculatorBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BreakEvenCalculatorProvider());
  }
}
