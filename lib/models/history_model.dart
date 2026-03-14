import 'package:flutter/foundation.dart';

// Defines the data structure for a single calculation history entry.
@immutable
class HistoryModel {
  final String expression;
  final String result;
  final DateTime timestamp;

  const HistoryModel({
    required this.expression,
    required this.result,
    required this.timestamp,
  });

  // Deserializes the history item from a map.
  factory HistoryModel.fromMap(Map<String, dynamic> map) {
    return HistoryModel(
      expression: map['expression'] as String,
      result: map['result'] as String,
      timestamp: DateTime.parse(map['timestamp'] as String),
    );
  }

  // Serializes the history item to a map.
  Map<String, dynamic> toMap() {
    return {
      'expression': expression,
      'result': result,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
