import 'package:get/get.dart';

class DiscountCalculatorProvider extends GetxController {
  final _originalPrice = 0.0.obs;
  final _discountPercentage = 0.0.obs;
  final _savedAmount = 0.0.obs;
  final _finalPrice = 0.0.obs;

  double get originalPrice => _originalPrice.value;
  double get discountPercentage => _discountPercentage.value;
  double get savedAmount => _savedAmount.value;
  double get finalPrice => _finalPrice.value;

  void setOriginalPrice(String value) {
    _originalPrice.value = double.tryParse(value) ?? 0;
    calculate();
  }

  void setDiscountPercentage(String value) {
    _discountPercentage.value = double.tryParse(value) ?? 0;
    calculate();
  }

  void calculate() {
    if (_originalPrice.value > 0 && _discountPercentage.value > 0) {
      double saved = _originalPrice.value * (_discountPercentage.value / 100);
      _savedAmount.value = saved;
      _finalPrice.value = _originalPrice.value - saved;
    } else {
      _savedAmount.value = 0;
      _finalPrice.value = _originalPrice.value;
    }
  }
}
