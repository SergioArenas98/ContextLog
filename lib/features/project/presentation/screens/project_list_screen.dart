import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/design/app_colors.dart';
import '../../../../core/design/app_tokens.dart';
import '../../../../core/design/app_typography.dart';
import '../../../../core/widgets/empty_state_widget.dart';
import '../../domain/models/project_model.dart';
import '../providers/project_providers.dart';

/// Manages the user's excavation projects.
class ProjectListScreen extends ConsumerWidget {
  const ProjectListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = AppColors.of(context);
    final projectsAsync = ref.watch(projectListProvider);

    return Scaffold(
      backgroundColor: colors.base,
      appBar: AppBar(
        backgroundColor: colors.s0,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, size: 20),
          color: colors.t1,
          onPressed: () => context.pop(),
        ),
        title: Text(
          'PROJECTS',
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
      body: projectsAsync.when(
        loading: () => Center(
          child: CircularProgressIndicator(
            color: colors.primary,
            strokeWidth: 2,
          ),
        ),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (projects) {
          if (projects.isEmpty) {
            return EmptyStateWidget(
              icon: Icons.folder_outlined,
              title: 'No projects yet',
              message: 'Create a project to reuse site metadata across features.',
              actionLabel: 'New Project',
              onAction: () => context.push('/projects/new'),
            );
          }
          return ListView.separated(
            itemCount: projects.length,
            separatorBuilder: (_, __) =>
                Container(height: 1, color: colors.rule),
            itemBuilder: (context, index) =>
                _ProjectListItem(project: projects[index]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/projects/new'),
        backgroundColor: colors.primary,
        foregroundColor: colors.s0,
        icon: const Icon(Icons.add_rounded, size: 20),
        label: Text(
          'NEW PROJECT',
          style: TextStyle(
            fontFamily: AppTypography.monoFontFamily,
            fontWeight: FontWeight.w700,
            fontSize: 10,
            letterSpacing: 1.5,
          ),
        ),
      ),
    );
  }
}

// ── Project list item ─────────────────────────────────────────────────────────

class _ProjectListItem extends ConsumerWidget {
  const _ProjectListItem({required this.project});

  final ProjectModel project;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = AppColors.of(context);
    return InkWell(
      onTap: () => context.push('/projects/${project.id}/edit'),
      child: Container(
        color: colors.s0,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.space16,
          vertical: AppSpacing.space12,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project.name,
                    style: TextStyle(
                      fontFamily: AppTypography.sansFontFamily,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: colors.t0,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      if (project.rubiconCode != null) ...[
                        _MetaChip(label: project.rubiconCode!),
                        const SizedBox(width: AppSpacing.space6),
                      ],
                      if (project.licenceNumber != null)
                        _MetaChip(label: project.licenceNumber!),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.space8),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit_outlined, size: 18),
                  color: colors.t2,
                  tooltip: 'Edit',
                  onPressed: () =>
                      context.push('/projects/${project.id}/edit'),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline_rounded, size: 18),
                  color: colors.t2,
                  tooltip: 'Delete',
                  onPressed: () => _confirmDelete(context, ref),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _confirmDelete(BuildContext context, WidgetRef ref) async {
    final colors = AppColors.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: colors.s1,
        title: Text(
          'DELETE PROJECT',
          style: TextStyle(
            fontFamily: AppTypography.monoFontFamily,
            fontWeight: FontWeight.w700,
            fontSize: 12,
            letterSpacing: 1.5,
            color: colors.t0,
          ),
        ),
        content: Text(
          'Delete "${project.name}"? Features linked to this project will lose their project reference.',
          style: TextStyle(
            fontFamily: AppTypography.sansFontFamily,
            fontSize: 14,
            color: colors.t1,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(
              'CANCEL',
              style: TextStyle(
                fontFamily: AppTypography.monoFontFamily,
                fontWeight: FontWeight.w700,
                fontSize: 10,
                letterSpacing: 1.2,
                color: colors.t1,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text(
              'DELETE',
              style: TextStyle(
                fontFamily: AppTypography.monoFontFamily,
                fontWeight: FontWeight.w700,
                fontSize: 10,
                letterSpacing: 1.2,
                color: colors.error,
              ),
            ),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await ref.read(projectRepositoryProvider).delete(project.id);
      ref.invalidate(projectListProvider);
    }
  }
}

class _MetaChip extends StatelessWidget {
  const _MetaChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space6, vertical: 2),
      decoration: BoxDecoration(
        color: colors.s2,
        borderRadius: AppRadius.xsBorderRadius,
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: AppTypography.monoFontFamily,
          fontSize: 9,
          letterSpacing: 0.5,
          color: colors.t2,
        ),
      ),
    );
  }
}
