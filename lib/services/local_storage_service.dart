import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

// A service that handles saving and loading data from the device's local storage.
class LocalStorageService {
  // Saves data to a given key after JSON encoding it.
  Future<void> saveData(String key, dynamic data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, jsonEncode(data));
  }

  // Loads data from a given key and decodes it from JSON.
  Future<dynamic> loadData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final dataString = prefs.getString(key);
    if (dataString != null) {
      try {
        return jsonDecode(dataString);
      } catch (e) {
        // If decoding fails, the data is corrupt. Clear it.
        await clearData(key);
        return null;
      }
    }
    return null;
  }

  // Clears data associated with a key.
  Future<void> clearData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }
}
