import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  static final SettingsProvider _instance = SettingsProvider._internal();
  factory SettingsProvider() => _instance;
  SettingsProvider._internal();

  String _country = 'us';
  String _language = 'en';
  bool _isDarkMode = true; // Default to dark mode

  String get country => _country;
  String get language => _language;
  bool get isDarkMode => _isDarkMode;

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _country = prefs.getString('country') ?? 'us';
    _language = prefs.getString('language') ?? 'en';
    _isDarkMode = prefs.getBool('isDarkMode') ?? true; // Load dark mode setting, default to true
    notifyListeners();
  }

  Future<void> setCountry(String country) async {
    _country = country;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('country', country);
    notifyListeners();
  }

  Future<void> setLanguage(String language) async {
    _language = language;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', language);
    notifyListeners();
  }

  Future<void> setDarkMode(bool value) async {
    _isDarkMode = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', value);
    notifyListeners();
  }
}