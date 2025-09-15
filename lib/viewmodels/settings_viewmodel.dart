import 'package:flutter/material.dart';
import '../models/settings_model.dart';

class SettingsViewModel extends ChangeNotifier {
  SettingsModel _settings = SettingsModel();

  SettingsModel get settings => _settings;

  void toggleNotifications(bool value) {
    _settings.notifications = value;
    notifyListeners();
  }

  void toggleDarkMode(bool value) {
    _settings.darkMode = value;
    notifyListeners();
  }

  void changeLanguage(String lang) {
    _settings.language = lang;
    notifyListeners();
  }
}
