import 'package:event_app/core/services/local_storge_services.dart';
import 'package:flutter/material.dart';


class AppSettingProvider extends ChangeNotifier {
  static final AppSettingProvider _instance = AppSettingProvider._internal();

  factory AppSettingProvider() => _instance;

  AppSettingProvider._internal();


  ThemeMode _themeMode = ThemeMode.system;
  Locale _locale = const Locale('en');

  ThemeMode get themeMode => _themeMode;

  Locale get locale => _locale;

  bool get isDarkMode => _themeMode == ThemeMode.dark;

  void toggleTheme() {
    _themeMode =
        _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void setThemeMode(ThemeMode mode) {
    if (_themeMode == mode) return;

    _themeMode = mode;
    notifyListeners();
  }

  void setLightMode() {
    _themeMode = ThemeMode.light;
    LocalStorgeServices.setBpol("isDark", false);

    notifyListeners();
  }

  void setDarkMode() {
    _themeMode = ThemeMode.dark;
    LocalStorgeServices.setBpol("isDark", true);

    notifyListeners();
  }

  void toggleLocale() {
    if (_locale.languageCode == 'en') {
      _locale = const Locale('ar');
    } else {
      _locale = const Locale('en');
    }

    notifyListeners();
  }

  void setLocale(Locale newLocale) {
    _locale = newLocale;
    notifyListeners();
  }

  void _loadTheme() {
    bool? isDark= LocalStorgeServices.getBool("isDark");

  }
}
