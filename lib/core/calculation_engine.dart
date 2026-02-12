import 'dart:math';
import 'package:math_expressions/math_expressions.dart';
import 'package:financial_calculator/core/precision_handler.dart';

class CalculationEngine {
  String evaluate(String expression, {bool isDeg = true}) {
    try {
      if (expression.isEmpty) return '0';

      // Preprocess: replace constants with precise values
      String processedExpr = expression
          .replaceAll('π', pi.toString())
          .replaceAll('e', e.toString());

      // Replace display operators to ASCII format
      processedExpr = processedExpr
          .replaceAll('÷', '/')
          .replaceAll('×', '*')
          .replaceAll('−', '-');

      // Convert scientific function notations before factorial handling
      processedExpr = _convertScientificFunctions(processedExpr);

      // Handle factorial notation (must be after function conversions)
      processedExpr = _handleFactorial(processedExpr);

      // Handle trigonometric functions with degree conversion
      if (isDeg) {
        processedExpr = _convertDegreesToRadians(processedExpr);
      }

      // Check for invalid operations before parsing
      if (_hasInvalidOperations(processedExpr)) {
        return 'Error';
      }

      // Parse and evaluate
      final parser = GrammarParser();
      final expressionObj = parser.parse(processedExpr);
      // ignore: deprecated_member_use
      final result = expressionObj.evaluate(EvaluationType.REAL, ContextModel()) as double?;

      if (result == null) {
        return 'Error';
      }

      // Check for invalid results (NaN, Infinity)
      if (result.isNaN || result.isInfinite) {
        return 'Error';
      }

      // Check if result is an extremely large number
      if (result.abs() > 1e308) {
        return 'Error';
      }

      return PrecisionHandler.format(result.toDouble());
    } catch (e) {
      return 'Error';
    }
  }

  String _convertScientificFunctions(String expr) {
    // Convert ln to log (natural logarithm in math_expressions)
    expr = _replaceFunctionArgs(expr, 'ln', 'log');
    
    // Convert log to log(x)/log(10) (base-10 logarithm)
    expr = _convertLog10(expr);
    
    // Convert √ to sqrt
    expr = expr.replaceAll('√', 'sqrt');
    
    // Convert cbrt to pow(x, 1/3)
    expr = _convertCbrt(expr);
    
    // Note: Keep ^ as-is, math_expressions supports it natively
    // No need to convert ^ to pow()
    
    return expr;
  }

  String _replaceFunctionArgs(String expr, String oldFunc, String newFunc) {
    // Simple replacement of function names while preserving arguments
    final pattern = RegExp('$oldFunc\\s*\\(');
    return expr.replaceAll(pattern, '$newFunc(');
  }

  String _convertLog10(String expr) {
    // Replace log(x) with log(x)/log(10)
    // This is tricky with nested parentheses, so we process carefully
    final pattern = RegExp(r'log\(');
    int startIndex = 0;
    final buffer = StringBuffer();
    
    for (final match in pattern.allMatches(expr)) {
      buffer.write(expr.substring(startIndex, match.start));
      
      // Find the matching closing parenthesis
      int depth = 0;
      int endIndex = match.end;
      for (int i = match.end; i < expr.length; i++) {
        if (expr[i] == '(') depth++;
        if (expr[i] == ')') {
          if (depth == 0) {
            endIndex = i;
            break;
          }
          depth--;
        }
      }
      
      // Extract the argument
      final arg = expr.substring(match.end, endIndex);
      buffer.write('(log($arg)/log(10))');
      startIndex = endIndex + 1;
    }
    
    buffer.write(expr.substring(startIndex));
    return buffer.toString();
  }

  String _convertCbrt(String expr) {
    // Convert cbrt(x) to pow(x, 0.333...)
    final pattern = RegExp(r'cbrt\(');
    int startIndex = 0;
    final buffer = StringBuffer();
    
    for (final match in pattern.allMatches(expr)) {
      buffer.write(expr.substring(startIndex, match.start));
      
      // Find the matching closing parenthesis
      int depth = 0;
      int endIndex = match.end;
      for (int i = match.end; i < expr.length; i++) {
        if (expr[i] == '(') depth++;
        if (expr[i] == ')') {
          if (depth == 0) {
            endIndex = i;
            break;
          }
          depth--;
        }
      }
      
      // Extract the argument
      final arg = expr.substring(match.end, endIndex);
      buffer.write('pow($arg,0.333333333)');
      startIndex = endIndex + 1;
    }
    
    buffer.write(expr.substring(startIndex));
    return buffer.toString();
  }

  bool _hasInvalidOperations(String expr) {
    // Check for log(0) or log(negative)
    if (_matchesFunctionWithBadArg(expr, 'log', [0.0])) {
      return true;
    }
    
    // Check for sqrt(negative) - math_expressions should handle this, but let's be safe
    // We'll let the library handle it and catch NaN/Infinity
    
    // Check for division by zero
    if (_containsDivisionByZero(expr)) {
      return true;
    }
    
    return false;
  }

  bool _matchesFunctionWithBadArg(String expr, String func, List<double> badArgs) {
    // This is a simplified check - more robust would parse properly
    // For now, simple pattern check for obvious cases
    final pattern = RegExp('$func\\s*\\(\\s*0\\s*[)/+\\-]');
    return pattern.hasMatch(expr);
  }

  bool _containsDivisionByZero(String expr) {
    // Check for patterns like /0, / 0, /0.0
    final patterns = [r'/\s*0(?:\s|$|[\)\+\-\*\/])', r'/\s*0\.0'];
    for (final pattern in patterns) {
      if (RegExp(pattern).hasMatch(expr)) {
        return true;
      }
    }
    return false;
  }

  String _handleFactorial(String expr) {
    // Process factorials from left to right, handling only complete numbers
    final pattern = RegExp(r'(\d+)\s*!');
    String result = expr;
    
    while (pattern.hasMatch(result)) {
      result = result.replaceFirstMapped(pattern, (match) {
        final num = int.parse(match.group(1)!);
        if (num < 0 || num > 170) {
          // Factorial beyond 170 causes overflow in double
          return 'Error';
        }
        return _factorial(num).toString();
      });
    }
    
    return result;
  }

  String _convertDegreesToRadians(String expr) {
    // Convert degree-based trig functions to radian-based
    // Use pi constant from dart:math for better precision
    final piStr = pi.toString();
    
    expr = _convertTrigFunction(expr, 'sin', piStr);
    expr = _convertTrigFunction(expr, 'cos', piStr);
    expr = _convertTrigFunction(expr, 'tan', piStr);
    expr = _convertInverseTrigFunction(expr, 'asin', piStr);
    expr = _convertInverseTrigFunction(expr, 'acos', piStr);
    expr = _convertInverseTrigFunction(expr, 'atan', piStr);
    
    return expr;
  }

  String _convertTrigFunction(String expr, String func, String piStr) {
    // Convert sin(x) to sin(x*π/180) for degree mode
    final pattern = RegExp('$func\\(');
    int startIndex = 0;
    final buffer = StringBuffer();
    
    for (final match in pattern.allMatches(expr)) {
      buffer.write(expr.substring(startIndex, match.start));
      
      // Find the matching closing parenthesis
      int depth = 0;
      int endIndex = match.end;
      for (int i = match.end; i < expr.length; i++) {
        if (expr[i] == '(') depth++;
        if (expr[i] == ')') {
          if (depth == 0) {
            endIndex = i;
            break;
          }
          depth--;
        }
      }
      
      // Extract the argument
      final arg = expr.substring(match.end, endIndex);
      buffer.write('$func(($arg)*$piStr/180)');
      startIndex = endIndex + 1;
    }
    
    buffer.write(expr.substring(startIndex));
    return buffer.toString();
  }

  String _convertInverseTrigFunction(String expr, String func, String piStr) {
    // Convert asin(x) to asin(x)*180/π for degree mode
    final pattern = RegExp('$func\\(');
    int startIndex = 0;
    final buffer = StringBuffer();
    
    for (final match in pattern.allMatches(expr)) {
      buffer.write(expr.substring(startIndex, match.start));
      
      // Find the matching closing parenthesis
      int depth = 0;
      int endIndex = match.end;
      for (int i = match.end; i < expr.length; i++) {
        if (expr[i] == '(') depth++;
        if (expr[i] == ')') {
          if (depth == 0) {
            endIndex = i;
            break;
          }
          depth--;
        }
      }
      
      // Extract the argument
      final arg = expr.substring(match.end, endIndex);
      buffer.write('($func($arg)*180/$piStr)');
      startIndex = endIndex + 1;
    }
    
    buffer.write(expr.substring(startIndex));
    return buffer.toString();
  }

  int _factorial(int n) {
    if (n < 0) throw Exception('Factorial of negative number');
    if (n == 0 || n == 1) return 1;
    
    int result = 1;
    for (int i = 2; i <= n; i++) {
      result *= i;
      // Check for overflow
      if (result < 0) throw Exception('Factorial overflow');
    }
    return result;
  }
}

