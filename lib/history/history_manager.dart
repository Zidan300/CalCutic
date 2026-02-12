
import 'package:financial_calculator/models/history_model.dart';
import 'package:financial_calculator/history/local_storage_service.dart';

class HistoryManager {
  static const _historyKey = 'calculation_history';
  final LocalStorageService _storageService = LocalStorageService();

  Future<List<HistoryModel>> loadHistory() async {
    final data = await _storageService.loadData(_historyKey);
    if (data is List) {
      return data.map((item) => HistoryModel.fromMap(item)).toList();
    }
    return [];
  }

  Future<void> addToHistory(HistoryModel item) async {
    final history = await loadHistory();
    // Prevent duplicate consecutive entries
    if (history.isNotEmpty &&
        history.first.expression == item.expression &&
        history.first.result == item.result) {
      return;
    }
    history.insert(0, item);
    await _storageService.saveData(_historyKey, history.map((e) => e.toMap()).toList());
  }

  Future<void> clearHistory() async {
    await _storageService.clearData(_historyKey);
  }
}
