import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/themes/theme_config.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData globalTheme = pokeBallTheme;

  void setTheme(ThemeData theme) {
    globalTheme = theme;
    notifyListeners();
  }
}
