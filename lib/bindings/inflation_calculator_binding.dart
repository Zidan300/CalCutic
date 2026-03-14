import 'package:get/get.dart';
import 'package:financial_calculator/controllers/inflation_calculator_provider.dart';

class InflationCalculatorBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InflationCalculatorProvider());
  }
}
