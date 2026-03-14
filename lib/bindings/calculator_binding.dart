import 'package:get/get.dart';
import 'package:financial_calculator/controllers/calculator_provider.dart';

class CalculatorBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CalculatorProvider());
  }
}
