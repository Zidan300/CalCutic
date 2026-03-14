import 'package:get/get.dart';
import 'package:financial_calculator/controllers/simple_interest_calculator_provider.dart';

class SimpleInterestCalculatorBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SimpleInterestCalculatorProvider());
  }
}
