import 'package:get/get.dart';
import 'package:financial_calculator/controllers/theme_provider.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(ThemeProvider());
  }
}
