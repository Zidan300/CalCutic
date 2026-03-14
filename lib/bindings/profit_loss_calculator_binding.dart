import 'package:get/get.dart';
import 'package:financial_calculator/controllers/profit_loss_calculator_provider.dart';

class ProfitLossCalculatorBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfitLossCalculatorProvider());
  }
}
