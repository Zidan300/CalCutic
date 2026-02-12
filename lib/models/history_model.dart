
class HistoryModel {
  final String expression;
  final String result;
  final DateTime timestamp;

  HistoryModel({
    required this.expression,
    required this.result,
    required this.timestamp,
  });

  // From map
  factory HistoryModel.fromMap(Map<String, dynamic> map) {
    return HistoryModel(
      expression: map['expression'],
      result: map['result'],
      timestamp: DateTime.parse(map['timestamp']),
    );
  }

  // To map
  Map<String, dynamic> toMap() {
    return {
      'expression': expression,
      'result': result,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
