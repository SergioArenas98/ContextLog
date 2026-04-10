import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/design/app_colors.dart';
import '../../../../core/design/app_tokens.dart';
import '../../../../core/design/app_typography.dart';
import '../../../../core/widgets/empty_state_widget.dart';
import '../providers/feature_providers.dart';
import '../widgets/feature_card.dart';

/// Site Roster — the field station mission control.
///
/// Structural change from previous design:
/// - Was: 2-column grid of square feature blocks with a number as hero
/// - Now: Single-column roster — compact numbered rows with context
///   depth indicators, last-activity date, and status signals
///
/// The roster format reflects how archaeologists actually use the list:
/// - They scan by first cut number (dominant mono label)
/// - They need to see the area quickly (inline tag)
///
/// No cards. No grid. A roster.
class FeatureListScreen extends ConsumerWidget {
  const FeatureListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = AppColors.of(context);
    final searchQuery = ref.watch(featureSearchQueryProvider);
    final featuresAsync = ref.watch(filteredFeatureListProvider);

    return Scaffold(
      backgroundColor: colors.base,
      body: CustomScrollView(
        slivers: [
          // ── Station header ────────────────────────────────────────────────
          SliverAppBar(
            backgroundColor: colors.s0,
            surfaceTintColor: Colors.transparent,
            pinned: true,
            expandedHeight: 104,
            collapsedHeight: 56,
            actions: [
              IconButton(
                icon: const Icon(Icons.settings_outlined, size: 20),
                color: colors.t1,
                tooltip: 'Settings',
                onPressed: () => context.push('/settings'),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.fromLTRB(
                AppSpacing.space16, 0, AppSpacing.space16, 16,
              ),
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'CONTEXTLOG',
                    style: TextStyle(
                      fontFamily: AppTypography.monoFontFamily,
                      fontWeight: FontWeight.w800,
                      fontSize: 11,
                      letterSpacing: 2.8,
                      color: colors.primary,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.space12),
                  featuresAsync.when(
                    loading: () => const SizedBox.shrink(),
                    error: (_, _) => const SizedBox.shrink(),
                    data: (features) => Text(
                      '${features.length} UNIT${features.length == 1 ? '' : 'S'}',
                      style: TextStyle(
                        fontFamily: AppTypography.monoFontFamily,
                        fontWeight: FontWeight.w500,
                        fontSize: 10,
                        letterSpacing: 1.5,
                        color: colors.t2,
                      ),
                    ),
                  ),
                ],
              ),
              background: Container(
                color: colors.s0,
                alignment: Alignment.bottomLeft,
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.space16,
                  0,
                  AppSpacing.space16,
                  44.0,
                ),
                child: Text(
                  'Field Station',
                  style: TextStyle(
                    fontFamily: AppTypography.sansFontFamily,
                    fontWeight: FontWeight.w300,
                    fontSize: 22,
                    letterSpacing: -0.5,
                    color: colors.t0.withValues(alpha: 0.6),
                    height: 1,
                  ),
                ),
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1),
              child: Container(height: 1, color: colors.rule),
            ),
          ),

          // ── Search ────────────────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Container(
              color: colors.s0,
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.space12,
                AppSpacing.space8,
                AppSpacing.space12,
                AppSpacing.space8,
              ),
              child: _RosterSearchField(query: searchQuery, ref: ref),
            ),
          ),

          SliverToBoxAdapter(
            child: Container(height: 1, color: colors.rule),
          ),

          // ── Column header ─────────────────────────────────────────────────
          featuresAsync.when(
            loading: () => const SliverToBoxAdapter(child: SizedBox.shrink()),
            error: (_, _) => const SliverToBoxAdapter(child: SizedBox.shrink()),
            data: (features) {
              if (features.isEmpty) return const SliverToBoxAdapter(child: SizedBox.shrink());
              return SliverToBoxAdapter(
                child: Container(
                  color: colors.s1,
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.space16,
                    AppSpacing.space6,
                    AppSpacing.space16,
                    AppSpacing.space6,
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 56,
                        child: Text(
                          'FEATURE',
                          style: TextStyle(
                            fontFamily: AppTypography.monoFontFamily,
                            fontWeight: FontWeight.w700,
                            fontSize: 9,
                            letterSpacing: 1.5,
                            color: colors.t2,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          ' SITE INFORMATION ',
                          style: TextStyle(
                            fontFamily: AppTypography.monoFontFamily,
                            fontWeight: FontWeight.w700,
                            fontSize: 9,
                            letterSpacing: 1.5,
                            color: colors.t2,
                          ),
                        ),
                      ),
                      Text(
                        'DATE',
                        style: TextStyle(
                          fontFamily: AppTypography.monoFontFamily,
                          fontWeight: FontWeight.w700,
                          fontSize: 9,
                          letterSpacing: 1.5,
                          color: colors.t2,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

          SliverToBoxAdapter(
            child: Container(height: 1, color: colors.rule),
          ),

          // ── Roster list / loading / empty ─────────────────────────────────
          featuresAsync.when(
            loading: () => SliverFillRemaining(
              child: Center(
                child: CircularProgressIndicator(
                  color: colors.primary,
                  strokeWidth: 2,
                ),
              ),
            ),
            error: (err, _) => SliverFillRemaining(
              child: Center(
                child: Text(
                  'Error: $err',
                  style: TextStyle(
                    fontFamily: AppTypography.monoFontFamily,
                    fontSize: 12,
                    color: colors.error,
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
                        ? 'Open a feature to begin field recording.'
                        : 'Try a different search term.',
                    actionLabel: searchQuery.isEmpty ? 'Add Feature' : null,
                    onAction: searchQuery.isEmpty
                        ? () => context.push('/features/new')
                        : null,
                  ),
                );
              }

              return SliverList.separated(
                itemCount: features.length,
                separatorBuilder: (_, _) => Container(
                  height: 1,
                  color: colors.rule,
                ),
                itemBuilder: (context, index) =>
                    FeatureRosterItem(feature: features[index]),
              );
            },
          ),

          // Bottom padding for FAB clearance
          const SliverToBoxAdapter(
            child: SizedBox(height: AppSpacing.space80 + 24),
          ),
        ],
      ),
      floatingActionButton: _AddFeatureFab(),
    );
  }
}

// ── Search field ──────────────────────────────────────────────────────────────

class _RosterSearchField extends StatelessWidget {
  const _RosterSearchField({required this.query, required this.ref});

  final String query;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return TextField(
      controller: TextEditingController(text: query)
        ..selection = TextSelection.collapsed(offset: query.length),
      onChanged: (value) =>
          ref.read(featureSearchQueryProvider.notifier).state = value,
      style: TextStyle(
        fontFamily: AppTypography.monoFontFamily,
        fontSize: 13,
        color: colors.t0,
      ),
      decoration: InputDecoration(
        hintText: 'Search by number, area, or code…',
        hintStyle: TextStyle(
          fontFamily: AppTypography.sansFontFamily,
          fontSize: 13,
          color: colors.t2,
        ),
        prefixIcon: Icon(Icons.search_rounded, size: 18, color: colors.t2),
        suffixIcon: query.isNotEmpty
            ? IconButton(
                icon: Icon(Icons.clear_rounded, size: 16, color: colors.t2),
                onPressed: () =>
                    ref.read(featureSearchQueryProvider.notifier).state = '',
              )
            : null,
        filled: true,
        fillColor: colors.s2,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.space12,
          vertical: 10.0,
        ),
        border: OutlineInputBorder(
          borderRadius: AppRadius.smBorderRadius,
          borderSide: BorderSide(color: colors.ruleMid, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadius.smBorderRadius,
          borderSide: BorderSide(color: colors.ruleMid, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadius.smBorderRadius,
          borderSide: BorderSide(color: colors.primary, width: 1.5),
        ),
      ),
    );
  }
}

// ── Add feature FAB ───────────────────────────────────────────────────────────

class _AddFeatureFab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return FloatingActionButton.extended(
      onPressed: () => context.push('/features/new'),
      backgroundColor: colors.primary,
      foregroundColor: colors.s0,
      elevation: 0,
      icon: const Icon(Icons.add_rounded, size: 20),
      label: Text(
        'NEW FEATURE',
        style: TextStyle(
          fontFamily: AppTypography.monoFontFamily,
          fontWeight: FontWeight.w700,
          fontSize: 11,
          letterSpacing: 1.5,
        ),
      ),
    );
  }
}
