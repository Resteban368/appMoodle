// ignore_for_file: file_names

import 'package:campus_virtual/theme/app_bar_theme.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData currentTheme;

  ThemeProvider({required bool isDarkmode})
      : currentTheme = isDarkmode ? ThemeData.dark() : ThemeData.light();

  setLightMode() {
    currentTheme = AppTheme.lightTheme;
    notifyListeners();
  }

  setDarkmode() {
    currentTheme = AppTheme.darkTheme;
    notifyListeners();
  }
}
