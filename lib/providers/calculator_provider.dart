import 'package:flutter/foundation.dart';

class CalculatorProvider extends ChangeNotifier {
  String _expression = '0';
  String _result = '0';
  bool _isResultComputed = false;

  String get expression => _expression;
  String get result => _result;

  void buttonPressed(String buttonText) {
    if (_isResultComputed) {
      if (['+', '−', '×', '÷', '%'].contains(buttonText)) {
        _expression = _result;
      } else {
        _expression = '0';
      }
      _isResultComputed = false;
    }

    if (_expression == '0' && buttonText != '.') {
      _expression = '';
    }

    _expression += buttonText;
    notifyListeners();
  }

  void clear() {
    _expression = '0';
    _result = '0';
    _isResultComputed = false;
    notifyListeners();
  }

  void backspace() {
    if (_expression.isNotEmpty) {
      if (_expression.length == 1) {
        _expression = '0';
      } else {
        _expression = _expression.substring(0, _expression.length - 1);
      }
      notifyListeners();
    }
  }

  void calculate() {
    if (_expression.isEmpty) return;

    try {
      String finalExpression = _expression
          .replaceAll('×', '*')
          .replaceAll('÷', '/')
          .replaceAll('−', '-');

      if (finalExpression.contains('%')) {
        finalExpression = finalExpression.replaceAll('%', '/100');
      }
      
      List<String> tokens = _tokenize(finalExpression);
      double eval = _evaluate(tokens);

      _result = _formatResult(eval);
      _isResultComputed = true;

    } catch (e) {
      _result = 'Error';
      _isResultComputed = true;
    }
    notifyListeners();
  }

  List<String> _tokenize(String expression) {
    // Add spaces around operators to make splitting easier
    expression = expression.replaceAllMapped(RegExp(r'([*\/+-])'), (match) => ' ${match.group(0)} ');
    return expression.split(' ').where((s) => s.isNotEmpty).toList();
  }

  double _evaluate(List<String> tokens) {
    List<double> values = [];
    List<String> ops = [];

    for (int i = 0; i < tokens.length; i++) {
      if (i.isEven) {
        values.add(double.parse(tokens[i]));
      } else {
        ops.add(tokens[i]);
      }
    }

    // Perform multiplication and division first
    for (int i = 0; i < ops.length; i++) {
      if (ops[i] == '*' || ops[i] == '/') {
        double result = ops[i] == '*' ? values[i] * values[i+1] : values[i] / values[i+1];
        values[i] = result;
        values.removeAt(i+1);
        ops.removeAt(i);
        i--;
      }
    }

    // Perform addition and subtraction
    double result = values[0];
    for (int i = 0; i < ops.length; i++) {
      if (ops[i] == '+') {
        result += values[i+1];
      } else if (ops[i] == '-') {
        result -= values[i+1];
      }
    }

    return result;
  }

  String _formatResult(double value) {
    if (value.isNaN || value.isInfinite) return 'Error';
    if (value == value.toInt()) return value.toInt().toString();
    return value.toStringAsFixed(8).replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '');
  }
}
