import 'package:get/get.dart';
import 'package:financial_calculator/controllers/gst_calculator_provider.dart';

class GstCalculatorBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GstCalculatorProvider());
  }
}
