import 'package:event_app/core/services/local_storge_key.dart';
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
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    LocalStorgeServices.setBpol(LocalStorgeKey.isDark, _themeMode == ThemeMode.dark); // Fixed typo
    notifyListeners();
  }

  void setThemeMode(ThemeMode mode) {
    if (_themeMode == mode) return;
    _themeMode = mode;
    LocalStorgeServices.setBpol(LocalStorgeKey.isDark, mode == ThemeMode.dark); // Fixed typo
    notifyListeners();
  }

  void toggleLocale() {
    _locale = _locale.languageCode == 'en' ? const Locale('ar') : const Locale('en');
    LocalStorgeServices.setString(LocalStorgeKey.locale, _locale.languageCode); // Fixed typo
    notifyListeners();
  }

  void setLocale(Locale newLocale) {
    if (_locale == newLocale) return;
    _locale = newLocale;
    LocalStorgeServices.setString(LocalStorgeKey.locale, newLocale.languageCode); // Fixed typo
    notifyListeners();
  }

  Future<void> loadSettings() async {
    await Future.wait([
      _loadTheme(),
      _loadLocale(),
    ]);
  }

  Future<void> _loadTheme() async {
    bool? isDark = await LocalStorgeServices.getBool(LocalStorgeKey.isDark); // Fixed typo
    _themeMode = isDark == true ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  Future<void> _loadLocale() async {
    String? localeCode = await LocalStorgeServices.getString(LocalStorgeKey.locale); // Fixed typo
    _locale = localeCode != null ? Locale(localeCode) : const Locale('en');
    notifyListeners();
  }
}