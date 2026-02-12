// lib/models/calculator_result.dart

class CalculatorResult<T> {
  final bool success;
  final T? data;
  final String? error;

  CalculatorResult({
    this.success = true,
    this.data,
    this.error,
  });

  factory CalculatorResult.success(T data) {
    return CalculatorResult(success: true, data: data);
  }

  factory CalculatorResult.error(String error) {
    return CalculatorResult(success: false, error: error);
  }
}
