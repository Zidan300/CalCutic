// lib/models/calculation_history.dart

class CalculationHistory {
  final String id;
  final String calculatorType;
  final String title;
  final Map<String, dynamic> inputs;
  final Map<String, dynamic> outputs;
  final DateTime timestamp;

  CalculationHistory({
    required this.id,
    required this.calculatorType,
    required this.title,
    required this.inputs,
    required this.outputs,
    required this.timestamp,
  });

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'calculatorType': calculatorType,
      'title': title,
      'inputs': inputs,
      'outputs': outputs,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  // Create from JSON
  factory CalculationHistory.fromJson(Map<String, dynamic> json) {
    return CalculationHistory(
      id: json['id'] as String,
      calculatorType: json['calculatorType'] as String,
      title: json['title'] as String,
      inputs: json['inputs'] as Map<String, dynamic>,
      outputs: json['outputs'] as Map<String, dynamic>,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }
}
