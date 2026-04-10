import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/design/app_colors.dart';
import '../../../../core/design/app_tokens.dart';
import '../../../../core/design/app_typography.dart';
import '../providers/project_providers.dart';

/// Create or edit a Project.
class ProjectFormScreen extends ConsumerStatefulWidget {
  const ProjectFormScreen({super.key, this.projectId});

  /// Null = create mode; non-null = edit mode.
  final String? projectId;

  @override
  ConsumerState<ProjectFormScreen> createState() => _ProjectFormScreenState();
}

class _ProjectFormScreenState extends ConsumerState<ProjectFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _rubiconCtrl = TextEditingController();
  final _licenceCtrl = TextEditingController();
  bool _loading = false;

  bool get _isEdit => widget.projectId != null;

  @override
  void initState() {
    super.initState();
    if (_isEdit) _loadExisting();
  }

  Future<void> _loadExisting() async {
    final project = await ref
        .read(projectRepositoryProvider)
        .getById(widget.projectId!);
    if (project != null && mounted) {
      _nameCtrl.text = project.name;
      _rubiconCtrl.text = project.rubiconCode ?? '';
      _licenceCtrl.text = project.licenceNumber ?? '';
      setState(() {});
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _rubiconCtrl.dispose();
    _licenceCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _loading = true);
    try {
      final repo = ref.read(projectRepositoryProvider);
      final name = _nameCtrl.text.trim();
      final rubicon = _rubiconCtrl.text.trim().isNotEmpty
          ? _rubiconCtrl.text.trim()
          : null;
      final licence = _licenceCtrl.text.trim().isNotEmpty
          ? _licenceCtrl.text.trim()
          : null;

      if (_isEdit) {
        await repo.update(
          id: widget.projectId!,
          name: name,
          rubiconCode: rubicon,
          licenceNumber: licence,
        );
      } else {
        await repo.create(
          name: name,
          rubiconCode: rubicon,
          licenceNumber: licence,
        );
      }
      ref.invalidate(projectListProvider);
      if (mounted) context.pop();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save project: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
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
          _isEdit ? 'EDIT PROJECT' : 'NEW PROJECT',
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
              onPressed: _save,
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
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.space16),
          children: [
            _FormField(
              controller: _nameCtrl,
              label: 'SITE NAME',
              hint: 'e.g. Northgate Roman Site',
              required: true,
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Site name is required';
                return null;
              },
            ),
            const SizedBox(height: AppSpacing.space16),
            _FormField(
              controller: _rubiconCtrl,
              label: 'SITE CODE',
              hint: 'e.g. RH1234',
            ),
            const SizedBox(height: AppSpacing.space16),
            _FormField(
              controller: _licenceCtrl,
              label: 'LICENCE NUMBER',
              hint: 'e.g. 25E1234',
            ),
            const SizedBox(height: AppSpacing.space80),
          ],
        ),
      ),
    );
  }
}

// ── Form field ────────────────────────────────────────────────────────────────

class _FormField extends StatelessWidget {
  const _FormField({
    required this.controller,
    required this.label,
    this.hint,
    this.required = false,
    this.validator,
  });

  final TextEditingController controller;
  final String label;
  final String? hint;
  final bool required;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
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
        ),
        const SizedBox(height: AppSpacing.space6),
        TextFormField(
          controller: controller,
          validator: validator,
          style: TextStyle(
            fontFamily: AppTypography.sansFontFamily,
            fontSize: 15,
            color: colors.t0,
          ),
          decoration: InputDecoration(
            hintText: hint,
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
            errorBorder: OutlineInputBorder(
              borderRadius: AppRadius.smBorderRadius,
              borderSide: BorderSide(color: colors.error),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: AppRadius.smBorderRadius,
              borderSide: BorderSide(color: colors.error, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}
