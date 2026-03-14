import 'package:get/get.dart';
import 'package:financial_calculator/controllers/discount_calculator_provider.dart';

class DiscountCalculatorBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DiscountCalculatorProvider());
  }
}
