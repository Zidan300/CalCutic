
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:financial_calculator/models/history_model.dart';

class HistoryService {
  static const _historyKey = 'calculation_history';

  // Load history
  Future<List<HistoryModel>> loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final historyString = prefs.getString(_historyKey);
    if (historyString != null) {
      final List<dynamic> historyList = jsonDecode(historyString);
      return historyList.map((item) => HistoryModel.fromMap(item)).toList();
    }
    return [];
  }

  // Add to history
  Future<void> addToHistory(HistoryModel item) async {
    final prefs = await SharedPreferences.getInstance();
    final history = await loadHistory();
    history.insert(0, item);
    await prefs.setString(_historyKey, jsonEncode(history.map((e) => e.toMap()).toList()));
  }

  // Clear history
  Future<void> clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_historyKey);
  }
}
