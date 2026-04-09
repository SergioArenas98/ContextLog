import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Persists and retrieves the user's [ThemeMode] preference.
class ThemePreferences {
  static const _key = 'theme_mode';

  /// Loads the persisted [ThemeMode]. Defaults to [ThemeMode.dark].
  static Future<ThemeMode> load() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(_key);
    return _fromString(value);
  }

  /// Persists [mode] to local storage.
  static Future<void> save(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, _toString(mode));
  }

  static String _toString(ThemeMode mode) => switch (mode) {
        ThemeMode.light => 'light',
        ThemeMode.dark => 'dark',
        ThemeMode.system => 'system',
      };

  static ThemeMode _fromString(String? value) => switch (value) {
        'light' => ThemeMode.light,
        'dark' => ThemeMode.dark,
        'system' => ThemeMode.system,
        _ => ThemeMode.dark,
      };
}
