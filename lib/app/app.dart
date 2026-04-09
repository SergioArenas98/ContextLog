import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/preferences/theme_notifier.dart';
import 'router.dart';
import 'theme.dart';

class ContextLogApp extends ConsumerWidget {
  const ContextLogApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeAsync = ref.watch(themeNotifierProvider);
    final themeMode = themeAsync.valueOrNull ?? ThemeMode.dark;

    return MaterialApp.router(
      title: 'ContextLog',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
