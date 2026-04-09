import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:context_log/core/preferences/theme_preferences.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  group('ThemePreferences', () {
    test('defaults to dark when no preference is stored', () async {
      final mode = await ThemePreferences.load();
      expect(mode, ThemeMode.dark);
    });

    test('persists and reloads light mode', () async {
      await ThemePreferences.save(ThemeMode.light);
      final mode = await ThemePreferences.load();
      expect(mode, ThemeMode.light);
    });

    test('persists and reloads dark mode', () async {
      await ThemePreferences.save(ThemeMode.dark);
      final mode = await ThemePreferences.load();
      expect(mode, ThemeMode.dark);
    });

    test('persists and reloads system mode', () async {
      await ThemePreferences.save(ThemeMode.system);
      final mode = await ThemePreferences.load();
      expect(mode, ThemeMode.system);
    });

    test('overwriting preference reflects new value', () async {
      await ThemePreferences.save(ThemeMode.light);
      await ThemePreferences.save(ThemeMode.system);
      final mode = await ThemePreferences.load();
      expect(mode, ThemeMode.system);
    });
  });
}
