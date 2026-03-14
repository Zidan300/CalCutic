import 'package:get/get.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:financial_calculator/history/history_manager.dart';
import 'package:financial_calculator/models/history_model.dart';

// This provider is refactored for basic arithmetic and stability.
class CalculatorProvider extends GetxController {
  final HistoryManager _historyManager = HistoryManager();
  final Parser _parser = Parser();

  final _expression = '0'.obs;
  final _result = '0'.obs;
  final _history = <HistoryModel>[].obs;
  bool _isResultComputed = false;

  String get expression => _expression.value;
  String get result => _result.value;
  List<HistoryModel> get history => _history;

  @override
  void onInit() {
    super.onInit();
    _loadHistory();
  }

  void clearHistory() {
    _history.clear();
    _historyManager.clearHistory(); // Clear history from local storage
  }

  void _loadHistory() async {
    _history.value = await _historyManager.loadHistory();
  }

  void buttonPressed(String buttonText) {
    if (_isResultComputed) {
      if (['+', '−', '×', '÷', '%'].contains(buttonText)) {
        _expression.value = _result.value;
      } else {
        _expression.value = '0';
      }
      _isResultComputed = false;
    }

    if (_expression.value == '0' && buttonText != '.') {
      _expression.value = '';
    }

    _expression.value += buttonText;
  }

  void clear() {
    _expression.value = '0';
    _result.value = '0';
    _isResultComputed = false;
  }

  void backspace() {
    if (_expression.value.isNotEmpty) {
      if (_expression.value.length == 1 || _expression.value == 'Error') {
        _expression.value = '0';
      } else {
        _expression.value = _expression.value.substring(0, _expression.value.length - 1);
      }
    }
  }

  void calculate() {
    if (_expression.value.isEmpty || _expression.value == 'Error') return;

    try {
      String finalExpression = _expression.value
          .replaceAll('×', '*')
          .replaceAll('÷', '/')
          .replaceAll('−', '-')
          .replaceAll('%', '/100');

      Expression exp = _parser.parse(finalExpression);
      double eval = exp.evaluate(EvaluationType.REAL, ContextModel());

      _result.value = _formatResult(eval);
      _isResultComputed = true;

      if (_result.value != 'Error') {
        final historyItem = HistoryModel(
          expression: _expression.value,
          result: _result.value,
          timestamp: DateTime.now(),
        );
        _historyManager.addToHistory(historyItem);
        _history.insert(0, historyItem);
      }
    } catch (e) {
      _result.value = 'Error';
      _isResultComputed = true;
    }
  }

  String _formatResult(double value) {
    if (value.isNaN || value.isInfinite) return 'Error';
    if (value == value.toInt()) return value.toInt().toString();
    return value.toStringAsFixed(8).replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '');
  }
}
