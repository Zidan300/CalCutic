import 'package:financial_calculator/models/history_model.dart';
import 'package:financial_calculator/services/local_storage_service.dart';

// Manages loading, adding, and clearing calculation history.
class HistoryManager {
  static const _historyKey = 'calculation_history';
  final LocalStorageService _storageService = LocalStorageService();

  // Loads the list of history items from local storage.
  Future<List<HistoryModel>> loadHistory() async {
    final data = await _storageService.loadData(_historyKey);
    if (data is List) {
      try {
        return data.map((item) => HistoryModel.fromMap(item)).toList();
      } catch (e) {
        // If data is corrupt, clear it and return an empty list.
        await clearHistory();
        return [];
      }
    }
    return [];
  }

  // Adds a new item to the history, preventing duplicates.
  Future<void> addToHistory(HistoryModel item) async {
    final history = await loadHistory();
    // Prevent duplicate consecutive entries.
    if (history.isNotEmpty && history.first.expression == item.expression) {
      return;
    }
    history.insert(0, item);
    await _storageService.saveData(_historyKey, history.map((e) => e.toMap()).toList());
  }

  // Clears all history from local storage.
  Future<void> clearHistory() async {
    await _storageService.clearData(_historyKey);
  }
}
