import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/themes/theme_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  CustomTheme globalTheme = listOfThemes[0];
  late SharedPreferences? _pref;
  List<CustomTheme> themes = listOfThemes;

  ThemeProvider() {
    _getSharedPreferences();
  }

  Future<void> _getSharedPreferences() async {
    _pref = await SharedPreferences.getInstance();

    String themeNme = _pref?.getString('theme') ?? listOfThemes.first.name;

    globalTheme = listOfThemes.firstWhere((theme) {
      return theme.name == themeNme;
    });
  }

  void setTheme(CustomTheme theme) {
    globalTheme = theme;
    _pref?.setString('theme', theme.name);
    notifyListeners();
  }
}
