import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  final SharedPreferences prefs;

  SettingsProvider(this.prefs) {
    _loadSettings();
  }

  String _country = 'us';
  String _language = 'en';
  bool _isDarkMode = true;
  bool _isFirstLaunch = true;

  String get country => _country;
  String get language => _language;
  bool get isDarkMode => _isDarkMode;
  bool get isFirstLaunch => _isFirstLaunch;

  void _loadSettings() {
    _country = prefs.getString('country') ?? 'us';
    _language = prefs.getString('language') ?? 'en';
    _isDarkMode = prefs.getBool('isDarkMode') ?? true;
    _isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;
    notifyListeners();
  }

  Future<void> setCountry(String country) async {
    _country = country;
    await prefs.setString('country', country);
    notifyListeners();
  }

  Future<void> setLanguage(String language) async {
    _language = language;
    await prefs.setString('language', language);
    notifyListeners();
  }

  Future<void> setDarkMode(bool value) async {
    _isDarkMode = value;
    await prefs.setBool('isDarkMode', value);
    notifyListeners();
  }

  Future<void> completeOnboarding() async {
    _isFirstLaunch = false;
    await prefs.setBool('isFirstLaunch', false);
    notifyListeners();
  }
}
