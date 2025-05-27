import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier extends ChangeNotifier {
  late SharedPreferences prefs;
  late String _theme = 'light';
  late String _colorScheme = 'main';
  var deviceBrightness =
      SchedulerBinding.instance.platformDispatcher.platformBrightness;
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
    saveToPrefs('theme', _theme);
    notifyListeners();
  }

  toggleColorTheme(String value) {
    _theme = value;
    print(_theme);
    saveToPrefs('theme', _theme);
    notifyListeners();
  }

  toggleColorScheme(String value) {
    _colorScheme = value;
    saveToPrefs('scheme', value);
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

  saveToPrefs(String key, String value) async {
    await _initPrefs();
    prefs.setString(key, value);
    notifyListeners();
  }
}
