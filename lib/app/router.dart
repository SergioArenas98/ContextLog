import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/context/presentation/screens/context_focus_screen.dart';
import '../features/feature/presentation/screens/feature_detail_screen.dart';
import '../features/feature/presentation/screens/feature_form_screen.dart';
import '../features/feature/presentation/screens/feature_list_screen.dart';
import '../features/splash/splash_screen.dart';

/// Route names for type-safe navigation.
abstract final class AppRoutes {
  static const splash = '/';
  static const featureList = '/features';
  static const featureCreate = '/features/new';
  static const featureDetail = '/features/:id';
  static const featureEdit = '/features/:id/edit';
  static const contextFocus = '/features/:id/contexts/:contextId';
}

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: AppRoutes.featureList,
      builder: (context, state) => const FeatureListScreen(),
    ),
    GoRoute(
      path: AppRoutes.featureCreate,
      builder: (context, state) => const FeatureFormScreen(),
    ),
    GoRoute(
      path: AppRoutes.featureDetail,
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return FeatureDetailScreen(featureId: id);
      },
      routes: [
        GoRoute(
          path: 'edit',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            return FeatureFormScreen(featureId: id);
          },
        ),
        GoRoute(
          path: 'contexts/:contextId',
          builder: (context, state) {
            final featureId = state.pathParameters['id']!;
            final contextId = state.pathParameters['contextId']!;
            return ContextFocusScreen(
              featureId: featureId,
              contextId: contextId,
            );
          },
        ),
      ],
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Text('Page not found: ${state.error}'),
    ),
  ),
);
