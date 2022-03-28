import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeState extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;
  
  bool get isDark => themeMode == ThemeMode.dark;

  void changeDark(bool value) {
    themeMode = value ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

final themeState = ChangeNotifierProvider<ThemeState>((ref) => ThemeState());