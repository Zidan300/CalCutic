import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:financial_calculator/utils/constants.dart';

// This provider has been refactored for improved stability and user experience.
class ThemeProvider extends GetxController {
  final _isDarkMode = false.obs;
  // Use a nullable SharedPreferences instance to avoid late initialization errors.
  SharedPreferences? _prefs;

  bool get isDarkMode => _isDarkMode.value;

  @override
  void onInit() {
    super.onInit();
    _initializeTheme();
  }

  // Initializes the theme by loading the user's preference from storage.
  // Defaults to the system's theme setting for a better first-time user experience.
  Future<void> _initializeTheme() async {
    _prefs = await SharedPreferences.getInstance();
    // Use Get.isPlatformDarkMode for a clean way to get the system theme.
    _isDarkMode.value = _prefs?.getBool(AppConstants.darkModeKey) ?? Get.isPlatformDarkMode;
  }

  // Toggles the theme between light and dark mode and saves the choice.
  Future<void> toggleTheme() async {
    // This safeguard ensures that SharedPreferences is initialized, even if called early.
    _prefs ??= await SharedPreferences.getInstance();
    
    _isDarkMode.value = !_isDarkMode.value;
    await _prefs!.setBool(AppConstants.darkModeKey, _isDarkMode.value);
  }
}
