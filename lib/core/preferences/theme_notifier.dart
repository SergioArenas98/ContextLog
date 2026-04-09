import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'theme_preferences.dart';

/// Provides the current [ThemeMode] and allows changing it.
/// Persists the selection via [ThemePreferences].
final themeNotifierProvider =
    AsyncNotifierProvider<ThemeNotifier, ThemeMode>(ThemeNotifier.new);

class ThemeNotifier extends AsyncNotifier<ThemeMode> {
  @override
  Future<ThemeMode> build() async {
    return ThemePreferences.load();
  }

  Future<void> setTheme(ThemeMode mode) async {
    await ThemePreferences.save(mode);
    state = AsyncData(mode);
  }
}
