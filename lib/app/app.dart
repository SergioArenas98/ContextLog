import 'package:flutter/material.dart';

import 'router.dart';
import 'theme.dart';

class ContextLogApp extends StatelessWidget {
  const ContextLogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'ContextLog',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.dark,
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
