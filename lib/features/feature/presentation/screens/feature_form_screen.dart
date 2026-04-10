import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/design/app_colors.dart';
import '../../../../core/design/app_tokens.dart';
import '../../../../core/design/app_typography.dart';
import '../../../project/domain/models/project_model.dart';
import '../../../project/presentation/providers/project_providers.dart';
import '../providers/feature_providers.dart';

/// Create or edit a Feature.
/// Project selection is required — site metadata lives on the Project.
class FeatureFormScreen extends ConsumerStatefulWidget {
  const FeatureFormScreen({super.key, this.featureId});

  /// Null for create, non-null for edit.
  final String? featureId;

  @override
  ConsumerState<FeatureFormScreen> createState() => _FeatureFormScreenState();
}

class _FeatureFormScreenState extends ConsumerState<FeatureFormScreen> {
  final _areaCtrl = TextEditingController();
  String? _selectedProjectId;
  bool _loading = false;
  bool _initialized = false;

  bool get _isEditing => widget.featureId != null;

  @override
  void dispose() {
    _areaCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final projectsAsync = ref.watch(projectListProvider);

    // In edit mode, load existing feature data once.
    if (_isEditing && !_initialized) {
      final featureAsync = ref.watch(featureDetailProvider(widget.featureId!));
      return featureAsync.when(
        loading: () {
          final colors = AppColors.of(context);
          return Scaffold(
            backgroundColor: colors.s0,
            body: Center(
              child: CircularProgressIndicator(
                color: colors.primary,
                strokeWidth: 2,
              ),
            ),
          );
        },
        error: (e, _) => Scaffold(body: Center(child: Text('Error: $e'))),
        data: (feature) {
          if (feature != null && !_initialized) {
            _areaCtrl.text = feature.area ?? '';
            _selectedProjectId = feature.projectId;
            _initialized = true;
          }
          return _buildScaffold(context, projectsAsync);
        },
      );
    }
    if (!_initialized) _initialized = true;
    return _buildScaffold(context, projectsAsync);
  }

  Widget _buildScaffold(
    BuildContext context,
    AsyncValue<List<ProjectModel>> projectsAsync,
  ) {
    final colors = AppColors.of(context);
    return Scaffold(
      backgroundColor: colors.s0,
      appBar: AppBar(
        backgroundColor: colors.s0,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close_rounded, size: 20),
          color: colors.t1,
          onPressed: () => context.pop(),
        ),
        title: Text(
          _isEditing ? 'EDIT FEATURE' : 'NEW FEATURE',
          style: TextStyle(
            fontFamily: AppTypography.monoFontFamily,
            fontWeight: FontWeight.w700,
            fontSize: 11,
            letterSpacing: 2.0,
            color: colors.t0,
          ),
        ),
        actions: [
          if (_loading)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space16),
              child: SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  color: colors.primary,
                  strokeWidth: 2,
                ),
              ),
            )
          else
            TextButton(
              onPressed: _submit,
              child: Text(
                'SAVE',
                style: TextStyle(
                  fontFamily: AppTypography.monoFontFamily,
                  fontWeight: FontWeight.w700,
                  fontSize: 11,
                  letterSpacing: 1.5,
                  color: colors.primary,
                ),
              ),
            ),
        ],
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
        data: (projects) => _buildForm(context, projects),
      ),
    );
  }

  Widget _buildForm(BuildContext context, List<ProjectModel> projects) {
    final colors = AppColors.of(context);
    if (projects.isEmpty) {
      return _NoProjectsPrompt(
        onCreateProject: () => context.push('/projects/new').then((_) {
          ref.invalidate(projectListProvider);
        }),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.space16),
      children: [
        // ── Project selection ───────────────────────────────────────────
        _FieldLabel(label: 'PROJECT', required: true),
        const SizedBox(height: AppSpacing.space6),
        ...projects.map(
          (p) => _ProjectOption(
            project: p,
            selected: p.id == _selectedProjectId,
            onTap: () => setState(() => _selectedProjectId = p.id),
          ),
        ),
        const SizedBox(height: AppSpacing.space4),
        TextButton.icon(
          onPressed: () => context.push('/projects/new').then((_) {
            ref.invalidate(projectListProvider);
          }),
          icon: const Icon(Icons.add_rounded, size: 16),
          label: const Text('New project'),
          style: TextButton.styleFrom(
            foregroundColor: colors.t2,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.space4,
              vertical: AppSpacing.space4,
            ),
            textStyle: TextStyle(
              fontFamily: AppTypography.sansFontFamily,
              fontSize: 13,
            ),
          ),
        ),

        const SizedBox(height: AppSpacing.space16),
        Container(height: 1, color: colors.rule),
        const SizedBox(height: AppSpacing.space16),

        // ── Feature-level field ────────────────────────────────────────
        _FieldLabel(label: 'AREA'),
        const SizedBox(height: AppSpacing.space6),
        TextFormField(
          controller: _areaCtrl,
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.none,
          style: TextStyle(
            fontFamily: AppTypography.sansFontFamily,
            fontSize: 15,
            color: colors.t0,
          ),
          decoration: InputDecoration(
            prefixText: 'Area ',
            prefixStyle: TextStyle(
              fontFamily: AppTypography.sansFontFamily,
              fontSize: 15,
              color: colors.t1,
            ),
            hintText: '12, North, or 7A',
            hintStyle: TextStyle(
              fontFamily: AppTypography.sansFontFamily,
              fontSize: 14,
              color: colors.t2,
            ),
            filled: true,
            fillColor: colors.s1,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.space12,
              vertical: AppSpacing.space12,
            ),
            border: OutlineInputBorder(
              borderRadius: AppRadius.smBorderRadius,
              borderSide: BorderSide(color: colors.rule),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: AppRadius.smBorderRadius,
              borderSide: BorderSide(color: colors.rule),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: AppRadius.smBorderRadius,
              borderSide: BorderSide(color: colors.primary, width: 1.5),
            ),
          ),
        ),

        const SizedBox(height: AppSpacing.space80),
      ],
    );
  }

  Future<void> _submit() async {
    if (_selectedProjectId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a project first')),
      );
      return;
    }

    setState(() => _loading = true);
    try {
      final repo = ref.read(featureRepositoryProvider);
      final area =
          _areaCtrl.text.trim().isEmpty ? null : _areaCtrl.text.trim();

      if (_isEditing) {
        final updated = await repo.update(
          id: widget.featureId!,
          projectId: _selectedProjectId!,
          area: area,
        );
        ref.invalidate(featureDetailProvider(updated.id));
        ref.invalidate(featureListProvider);
        ref.invalidate(filteredFeatureListProvider);
        if (mounted) context.pop();
      } else {
        final created = await repo.create(
          projectId: _selectedProjectId!,
          area: area,
        );
        ref.invalidate(featureListProvider);
        ref.invalidate(filteredFeatureListProvider);
        if (mounted) context.pushReplacement('/features/${created.id}');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }
}

// ── Sub-widgets ────────────────────────────────────────────────────────────────

class _FieldLabel extends StatelessWidget {
  const _FieldLabel({required this.label, this.required = false});

  final String label;
  final bool required;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: AppTypography.monoFontFamily,
            fontWeight: FontWeight.w700,
            fontSize: 9,
            letterSpacing: 1.5,
            color: colors.t2,
          ),
        ),
        if (required) ...[
          const SizedBox(width: 4),
          Text(
            '*',
            style: TextStyle(
              fontFamily: AppTypography.monoFontFamily,
              fontSize: 10,
              color: colors.primary,
            ),
          ),
        ],
      ],
    );
  }
}

class _ProjectOption extends StatelessWidget {
  const _ProjectOption({
    required this.project,
    required this.selected,
    required this.onTap,
  });

  final ProjectModel project;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        margin: const EdgeInsets.only(bottom: AppSpacing.space6),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.space12,
          vertical: AppSpacing.space8,
        ),
        decoration: BoxDecoration(
          color: selected ? colors.s2 : colors.s1,
          borderRadius: AppRadius.smBorderRadius,
          border: Border.all(
            color: selected ? colors.primary : colors.rule,
            width: selected ? 1.5 : 1,
          ),
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
                      fontSize: 14,
                      color: selected ? colors.t0 : colors.t1,
                    ),
                  ),
                  if (project.rubiconCode != null ||
                      project.licenceNumber != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      [
                        if (project.rubiconCode != null) project.rubiconCode!,
                        if (project.licenceNumber != null)
                          project.licenceNumber!,
                      ].join(' · '),
                      style: TextStyle(
                        fontFamily: AppTypography.monoFontFamily,
                        fontSize: 10,
                        color: colors.t2,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (selected)
              Icon(
                Icons.check_circle_rounded,
                size: 18,
                color: colors.primary,
              ),
          ],
        ),
      ),
    );
  }
}

class _NoProjectsPrompt extends StatelessWidget {
  const _NoProjectsPrompt({required this.onCreateProject});

  final VoidCallback onCreateProject;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.space48),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: colors.s2,
                borderRadius: AppRadius.smBorderRadius,
              ),
              child: Icon(
                Icons.folder_outlined,
                color: colors.t2,
                size: 28,
              ),
            ),
            const SizedBox(height: AppSpacing.space16),
            Text(
              'NO PROJECTS',
              style: TextStyle(
                fontFamily: AppTypography.monoFontFamily,
                fontWeight: FontWeight.w700,
                fontSize: 10,
                letterSpacing: 2.0,
                color: colors.t2,
              ),
            ),
            const SizedBox(height: AppSpacing.space8),
            Text(
              'Create a project first. Projects store site name, site code, and licence number — shared across all features.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: AppTypography.sansFontFamily,
                fontSize: 13,
                height: 1.5,
                color: colors.t2,
              ),
            ),
            const SizedBox(height: AppSpacing.space24),
            FilledButton.icon(
              onPressed: onCreateProject,
              icon: const Icon(Icons.add_rounded, size: 18),
              label: const Text('CREATE PROJECT'),
              style: FilledButton.styleFrom(
                backgroundColor: colors.primary,
                foregroundColor: colors.s0,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.space24,
                  vertical: AppSpacing.space12,
                ),
                textStyle: TextStyle(
                  fontFamily: AppTypography.monoFontFamily,
                  fontWeight: FontWeight.w700,
                  fontSize: 10,
                  letterSpacing: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
