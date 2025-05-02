import 'package:flutter/material.dart';

// DARK THEME!

class ThemeProvider extends ChangeNotifier{
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void toggleDarkMode(bool value){
    _isDarkMode = value;
    notifyListeners();
  }
}