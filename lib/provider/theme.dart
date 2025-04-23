import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier extends ChangeNotifier {
  late SharedPreferences prefs;
  late String _theme = 'light';
  late String _colorScheme = 'main';

  String get theme => _theme;
  String get colorScheme => _colorScheme;

  ThemeNotifier() {
    _theme = 'light';
    _colorScheme = 'main';
    loadFromPrefs('theme');
    loadFromPrefs('scheme');
  }

  toggleTheme() {
    if (_theme == 'light') {
      _theme = 'dark';
    } else {
      _theme = 'light';
    }
    saveToPrefs('theme');
    notifyListeners();
  }

  toggleColorScheme(String value) {
      _colorScheme = value;
      saveToPrefs('scheme');
      notifyListeners();
  }

  _initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  loadFromPrefs(String key) async {
    await _initPrefs();
    _theme = prefs.getString(key) ?? 'light';
    notifyListeners();
  }

  saveToPrefs(String key) async {
    await _initPrefs();
    prefs.setString(key, _theme);
    notifyListeners();
  }
}
