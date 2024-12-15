import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier extends StateNotifier<ThemeMode> {
  ThemeNotifier() : super(ThemeMode.light) {
    _loadThemePreference();
  }

  // Toggle between light and dark theme
  void toggleTheme() async {
    state = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    _saveThemePreference(state);
  }

  // Set light theme
  void setLightTheme() async {
    state = ThemeMode.light;
    _saveThemePreference(state);
  }

  // Set light theme
  void setDarkTheme() async {
    state = ThemeMode.dark;
    _saveThemePreference(state);
  }

  // Load theme preference from SharedPreferences
  Future<void> _loadThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    final isDarkMode = prefs.getBool('isDarkMode') ?? false;
    state = isDarkMode ? ThemeMode.dark : ThemeMode.light;
  }

  // Save theme preference to SharedPreferences
  Future<void> _saveThemePreference(ThemeMode themeMode) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', themeMode == ThemeMode.dark);
  }
}

// Provider for the ThemeNotifier
final themeNotifierProvider =
    StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  return ThemeNotifier();
});
