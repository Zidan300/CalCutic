import 'package:get/get.dart';
import 'package:financial_calculator/history/history_manager.dart';
import 'package:financial_calculator/models/history_model.dart';

/// DEPRECATED: ScientificCalculatorProvider is no longer maintained.
/// 
/// The application has been converted to a basic calculator.
/// Use [CalculatorProvider] instead for all calculator operations.
/// 
/// This class is kept for backward compatibility only and should not be used
/// in new code. It will be removed in a future major version.
@Deprecated(
  'Use CalculatorProvider instead. ScientificCalculatorProvider will be removed in v2.0. '
  'The app has been converted to a basic calculator.'
)
class ScientificCalculatorProvider extends GetxController {
  final HistoryManager _historyManager = HistoryManager();

  final _expression = '0'.obs;
  final _result = '0'.obs;
  final _history = <HistoryModel>[].obs;

  String get expression => _expression.value;
  String get result => _result.value;
  List<HistoryModel> get history => _history;

  @override
  void onInit() {
    super.onInit();
    _loadHistory();
  }

  void _loadHistory() async {
    _history.value = await _historyManager.loadHistory();
  }

  void clearHistory() async {
    await _historyManager.clearHistory();
    _history.clear();
  }

  void reuseHistory(HistoryModel item) {
    _expression.value = item.expression;
    _result.value = item.result;
  }
}
