import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:financial_calculator/utils/constants.dart';

// This provider manages the app's theme (light/dark mode).
class ThemeProvider extends GetxController {
  final _isDarkMode = false.obs;
  SharedPreferences? _prefs;

  bool get isDarkMode => _isDarkMode.value;

  @override
  void onInit() {
    super.onInit();
    _initializeTheme();
  }

  // Loads the saved theme preference or defaults to the system theme.
  Future<void> _initializeTheme() async {
    _prefs = await SharedPreferences.getInstance();
    _isDarkMode.value = _prefs?.getBool(AppConstants.darkModeKey) ?? Get.isPlatformDarkMode;
  }

  // Toggles the theme and saves the user's preference.
  Future<void> toggleTheme() async {
    _prefs ??= await SharedPreferences.getInstance();

    _isDarkMode.value = !_isDarkMode.value;
    await _prefs!.setBool(AppConstants.darkModeKey, _isDarkMode.value);
  }
}
