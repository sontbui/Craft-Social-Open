import 'package:clone_gpt/contains/contains.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyThemeProvider extends ChangeNotifier {
  bool _isDarkThem = true;
  bool get themeType => _isDarkThem;

  set setTheme(bool value) {
    _isDarkThem = value;
    saveThemeToSharedPreferences(value: value);
    notifyListeners();
  }

  void saveThemeToSharedPreferences({required bool value}) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setBool(Contains.themeStatus, value);
  }

  getThemesStatus() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    _isDarkThem = sharedPreferences.getBool(Contains.themeStatus) ?? false;
    notifyListeners();
  }
}
