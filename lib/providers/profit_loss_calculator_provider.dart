import 'package:get/get.dart';

class ProfitLossCalculatorProvider extends GetxController {
  final _costPrice = 0.0.obs;
  final _sellingPrice = 0.0.obs;
  final _profitOrLoss = 0.0.obs;
  final _isProfit = false.obs;

  double get costPrice => _costPrice.value;
  double get sellingPrice => _sellingPrice.value;
  double get profitOrLoss => _profitOrLoss.value;
  bool get isProfit => _isProfit.value;

  void setCostPrice(String value) {
    _costPrice.value = double.tryParse(value) ?? 0;
    calculate();
  }

  void setSellingPrice(String value) {
    _sellingPrice.value = double.tryParse(value) ?? 0;
    calculate();
  }

  void calculate() {
    if (_costPrice.value > 0 && _sellingPrice.value > 0) {
      double difference = _sellingPrice.value - _costPrice.value;
      _profitOrLoss.value = difference.abs();
      _isProfit.value = difference > 0;
    } else {
      _profitOrLoss.value = 0;
    }
  }
}
