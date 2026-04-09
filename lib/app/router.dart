import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/design/app_colors.dart';
import '../core/design/app_typography.dart';
import '../features/context/presentation/screens/context_focus_screen.dart';
import '../features/drawing/presentation/widgets/drawing_list_tab.dart';
import '../features/feature/presentation/screens/feature_detail_screen.dart';
import '../features/feature/presentation/screens/feature_form_screen.dart';
import '../features/feature/presentation/screens/feature_list_screen.dart';
import '../features/find/presentation/widgets/find_list_tab.dart';
import '../features/harris_matrix/presentation/screens/matrix_full_screen.dart';
import '../features/photo/presentation/widgets/photo_list_tab.dart';
import '../features/project/presentation/screens/project_form_screen.dart';
import '../features/project/presentation/screens/project_list_screen.dart';
import '../features/sample/presentation/widgets/sample_list_tab.dart';
import '../features/settings/presentation/screens/settings_screen.dart';
import '../features/splash/splash_screen.dart';

/// Route definitions.
///
/// New routes added in PROBE redesign:
/// - /features/:id/matrix — Full-screen interactive Harris Matrix
/// - /features/:id/evidence/photos — Feature-level photo list
/// - /features/:id/evidence/drawings — Feature-level drawing list
/// - /features/:id/evidence/finds — Feature-level finds list
/// - /features/:id/evidence/samples — Feature-level samples list
///
/// Navigation model change:
/// - /features/:id/contexts/:contextId is now the EDIT/DETAIL screen only.
///   Normal context interaction happens via the ContextStationPanel overlay.
///   This route is reached by tapping "expand" in the overlay, not by
///   direct navigation from the matrix/roster.
abstract final class AppRoutes {
  static const splash = '/';
  static const featureList = '/features';
  static const featureCreate = '/features/new';
  static const featureDetail = '/features/:id';
  static const featureEdit = '/features/:id/edit';
  static const featureMatrix = '/features/:id/matrix';
  static const contextDetail = '/features/:id/contexts/:contextId';
  static const settings = '/settings';
  static const changelog = '/settings/changelog';
  static const projectList = '/projects';
  static const projectCreate = '/projects/new';
  static const projectEdit = '/projects/:projectId/edit';
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
      path: AppRoutes.settings,
      builder: (context, state) => const SettingsScreen(),
      routes: [
        GoRoute(
          path: 'changelog',
          builder: (context, state) => const ChangelogScreen(),
        ),
      ],
    ),
    GoRoute(
      path: AppRoutes.projectList,
      builder: (context, state) => const ProjectListScreen(),
    ),
    GoRoute(
      path: AppRoutes.projectCreate,
      builder: (context, state) => const ProjectFormScreen(),
    ),
    GoRoute(
      path: '/projects/:projectId/edit',
      builder: (context, state) {
        final id = state.pathParameters['projectId']!;
        return ProjectFormScreen(projectId: id);
      },
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
          path: 'matrix',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            return MatrixFullScreen(featureId: id);
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
        GoRoute(
          path: 'evidence/photos',
          builder: (context, state) {
            final featureId = state.pathParameters['id']!;
            return _EvidenceShell(
              title: 'PHOTOS',
              featureId: featureId,
              routeKey: 'photos',
            );
          },
        ),
        GoRoute(
          path: 'evidence/drawings',
          builder: (context, state) {
            final featureId = state.pathParameters['id']!;
            return _EvidenceShell(
              title: 'DRAWINGS',
              featureId: featureId,
              routeKey: 'drawings',
            );
          },
        ),
        GoRoute(
          path: 'evidence/finds',
          builder: (context, state) {
            final featureId = state.pathParameters['id']!;
            return _EvidenceShell(
              title: 'FINDS',
              featureId: featureId,
              routeKey: 'finds',
            );
          },
        ),
        GoRoute(
          path: 'evidence/samples',
          builder: (context, state) {
            final featureId = state.pathParameters['id']!;
            return _EvidenceShell(
              title: 'SAMPLES',
              featureId: featureId,
              routeKey: 'samples',
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

// ── Evidence shell ────────────────────────────────────────────────────────────

class _EvidenceShell extends StatelessWidget {
  const _EvidenceShell({
    required this.title,
    required this.featureId,
    required this.routeKey,
  });

  final String title;
  final String featureId;
  final String routeKey;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Scaffold(
      backgroundColor: colors.s0,
      appBar: AppBar(
        backgroundColor: colors.s0,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleSpacing: 0,
        title: Text(
          title,
          style: TextStyle(
            fontFamily: AppTypography.monoFontFamily,
            fontWeight: FontWeight.w800,
            fontSize: 12,
            letterSpacing: 2.5,
            color: colors.t0,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: colors.rule),
        ),
      ),
      body: switch (routeKey) {
        'photos' => PhotoListTab(featureId: featureId),
        'drawings' => DrawingListTab(featureId: featureId),
        'finds' => FindListTab(featureId: featureId),
        'samples' => SampleListTab(featureId: featureId),
        _ => const SizedBox.shrink(),
      },
    );
  }
}
