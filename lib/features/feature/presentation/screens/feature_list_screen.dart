import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/design/app_colors.dart';
import '../../../../core/design/app_tokens.dart';
import '../../../../core/design/app_typography.dart';
import '../../../../core/widgets/empty_state_widget.dart';
import '../providers/feature_providers.dart';
import '../widgets/feature_card.dart';

/// Site dashboard — feature grid overview.
///
/// Structural change: feature list was a vertical ListView of generic cards.
/// New: 2-column grid of feature blocks where the feature number dominates.
/// Conveys "this is a site overview" not "this is a list of records".
class FeatureListScreen extends ConsumerWidget {
  const FeatureListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchQuery = ref.watch(featureSearchQueryProvider);
    final featuresAsync = ref.watch(filteredFeatureListProvider);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: AppColors.base,
      body: CustomScrollView(
        slivers: [
          // ── Site header (SliverAppBar with pinned identity strip) ──────────
          SliverAppBar(
            backgroundColor: AppColors.s0,
            surfaceTintColor: Colors.transparent,
            pinned: true,
            expandedHeight: 96,
            collapsedHeight: 60,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.fromLTRB(
                AppSpacing.space16, 0, AppSpacing.space16, 14,
              ),
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'STRATUM',
                    style: TextStyle(
                      fontFamily: AppTypography.monoFontFamily,
                      fontWeight: FontWeight.w800,
                      fontSize: 11,
                      letterSpacing: 2.5,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.space12),
                  featuresAsync.when(
                    loading: () => const SizedBox.shrink(),
                    error: (_, __) => const SizedBox.shrink(),
                    data: (features) => Text(
                      '${features.length} feature${features.length == 1 ? '' : 's'}',
                      style: TextStyle(
                        fontFamily: AppTypography.monoFontFamily,
                        fontWeight: FontWeight.w400,
                        fontSize: 11,
                        letterSpacing: 0.5,
                        color: AppColors.t2,
                      ),
                    ),
                  ),
                ],
              ),
              background: Container(
                color: AppColors.s0,
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.space16,
                  AppSpacing.space16,
                  AppSpacing.space16,
                  AppSpacing.space8,
                ),
                alignment: Alignment.bottomLeft,
                child: Text(
                  'ContextLog',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: AppColors.t0,
                    fontFamily: AppTypography.monoFontFamily,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.info_outline_rounded),
                tooltip: 'About',
                onPressed: () => _showAboutDialog(context),
              ),
            ],
          ),

          // ── Search bar ───────────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.space16,
                AppSpacing.space12,
                AppSpacing.space16,
                AppSpacing.space4,
              ),
              child: _StratumSearchBar(query: searchQuery, ref: ref),
            ),
          ),

          // ── Section label ────────────────────────────────────────────────
          if (featuresAsync.hasValue && (featuresAsync.value?.isNotEmpty ?? false))
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.space16,
                  AppSpacing.space16,
                  AppSpacing.space16,
                  AppSpacing.space8,
                ),
                child: Text(
                  'EXCAVATION UNITS',
                  style: TextStyle(
                    fontFamily: AppTypography.monoFontFamily,
                    fontWeight: FontWeight.w700,
                    fontSize: 10,
                    letterSpacing: 2.0,
                    color: AppColors.t2,
                  ),
                ),
              ),
            ),

          // ── Feature grid / loading / empty ───────────────────────────────
          featuresAsync.when(
            loading: () => const SliverFillRemaining(
              child: Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              ),
            ),
            error: (err, _) => SliverFillRemaining(
              child: Center(
                child: Text(
                  'Error: $err',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.error,
                  ),
                ),
              ),
            ),
            data: (features) {
              if (features.isEmpty) {
                return SliverFillRemaining(
                  child: EmptyStateWidget(
                    icon: Icons.terrain_outlined,
                    title: searchQuery.isEmpty
                        ? 'No excavation units'
                        : 'No results for "$searchQuery"',
                    message: searchQuery.isEmpty
                        ? 'Tap the button below to record your first feature.'
                        : 'Try a different search term.',
                    actionLabel: searchQuery.isEmpty ? 'Add Feature' : null,
                    onAction: searchQuery.isEmpty
                        ? () => context.push('/features/new')
                        : null,
                  ),
                );
              }

              return SliverPadding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.space16,
                  0,
                  AppSpacing.space16,
                  AppSpacing.space80 + 16,
                ),
                sliver: SliverGrid.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.9,
                  ),
                  itemCount: features.length,
                  itemBuilder: (context, index) =>
                      FeatureCard(feature: features[index]),
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/features/new'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.s0,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: AppRadius.lgBorderRadius,
        ),
        child: const Icon(Icons.add_rounded, size: 28),
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'ContextLog',
      applicationVersion: '2.0.0',
      applicationLegalese: 'Archaeological field recording for Android',
    );
  }
}

// ── Stratum search bar ─────────────────────────────────────────────────────────

class _StratumSearchBar extends StatelessWidget {
  const _StratumSearchBar({required this.query, required this.ref});

  final String query;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      hintText: 'Search features…',
      leading: const Icon(Icons.search_rounded, size: 20),
      trailing: query.isNotEmpty
          ? [
              IconButton(
                icon: const Icon(Icons.clear_rounded, size: 18),
                onPressed: () =>
                    ref.read(featureSearchQueryProvider.notifier).state = '',
              ),
            ]
          : null,
      onChanged: (value) =>
          ref.read(featureSearchQueryProvider.notifier).state = value,
    );
  }
}

