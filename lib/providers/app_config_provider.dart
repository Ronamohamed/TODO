import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppConfiguresProvider extends ChangeNotifier {
  /// [ MARK ] Variables: -
  String currentLanguage = 'en';
  ThemeMode currentMode = ThemeMode.light;
  SharedPreferences? _sharedPreferences;

  /// [ MARK ] Utilities: -
  void changeAppLanguage(String newLanguge) {
    if (currentLanguage == newLanguge) {
      return;
    }
    currentLanguage = newLanguge;
    if (currentLanguage == 'ar') {
      _saveAppLanguage(true);
    } else {
      _saveAppLanguage(false);
    }
    notifyListeners();
  }

  void changeAppMode(ThemeMode newMode) {
    if (currentMode == newMode) {
      return;
    }
    currentMode = newMode;
    if (currentMode == ThemeMode.light) {
      saveAppMode(true);
    } else {
      saveAppMode(false);
    }
    notifyListeners();
  }

  ///* SharedPreferences Utilities :-
  Future<void> _saveAppLanguage(bool isArabic) async {
    await _sharedPreferences?.setBool("isArabic", isArabic);
  }

  Future<void> saveAppMode(bool isLight) async {
    await _sharedPreferences?.setBool("isLight", isLight);
  }

  bool? _getAppLanguage() {
    return _sharedPreferences?.getBool("isArabic");
  }

  bool? _getAppMode() {
    return _sharedPreferences?.getBool("isLight");
  }

  Future<void> readAppConfigsData() async {
    _sharedPreferences = await SharedPreferences.getInstance();

    if (_getAppLanguage() ?? false) {
      currentLanguage = 'ar';
    } else {
      currentLanguage = 'en';
    }

    if (_getAppMode() ?? false) {
      currentMode = ThemeMode.light;
    } else {
      currentMode = ThemeMode.dark;
    }
  }
}
