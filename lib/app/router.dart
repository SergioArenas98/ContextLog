import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/feature/presentation/screens/feature_list_screen.dart';
import '../features/feature/presentation/screens/feature_detail_screen.dart';
import '../features/feature/presentation/screens/feature_form_screen.dart';

/// Route names for type-safe navigation.
abstract final class AppRoutes {
  static const featureList = '/features';
  static const featureDetail = '/features/:id';
  static const featureCreate = '/features/new';
  static const featureEdit = '/features/:id/edit';
}

final appRouter = GoRouter(
  initialLocation: AppRoutes.featureList,
  routes: [
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
      ],
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Text('Page not found: ${state.error}'),
    ),
  ),
);
