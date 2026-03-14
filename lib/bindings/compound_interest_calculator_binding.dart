import 'package:get/get.dart';
import 'package:financial_calculator/controllers/compound_interest_calculator_provider.dart';

class CompoundInterestCalculatorBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CompoundInterestCalculatorProvider());
  }
}
