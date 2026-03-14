import 'package:get/get.dart';
import 'package:financial_calculator/controllers/savings_goal_calculator_provider.dart';

class SavingsGoalCalculatorBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SavingsGoalCalculatorProvider());
  }
}
