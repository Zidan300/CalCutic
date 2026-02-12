
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  Future<void> saveData(String key, dynamic data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, jsonEncode(data));
  }

  Future<dynamic> loadData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final dataString = prefs.getString(key);
    if (dataString != null) {
      return jsonDecode(dataString);
    }
    return null;
  }

  Future<void> clearData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }
}
