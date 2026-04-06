import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/design/app_tokens.dart';
import '../../../../core/widgets/section_header.dart';
import '../providers/feature_providers.dart';

class FeatureFormScreen extends ConsumerStatefulWidget {
  const FeatureFormScreen({super.key, this.featureId});

  /// Null for create, non-null for edit.
  final String? featureId;

  @override
  ConsumerState<FeatureFormScreen> createState() => _FeatureFormScreenState();
}

class _FeatureFormScreenState extends ConsumerState<FeatureFormScreen> {
  final _rubiconCodeCtrl = TextEditingController();
  final _licenseCtrl = TextEditingController();
  final _areaCtrl = TextEditingController();
  bool _loading = false;
  bool _initialized = false;

  bool get _isEditing => widget.featureId != null;

  @override
  void dispose() {
    _rubiconCodeCtrl.dispose();
    _licenseCtrl.dispose();
    _areaCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isEditing && !_initialized) {
      final featureAsync = ref.watch(featureDetailProvider(widget.featureId!));
      return featureAsync.when(
        loading: () =>
            const Scaffold(body: Center(child: CircularProgressIndicator())),
        error: (e, _) => Scaffold(body: Center(child: Text('Error: $e'))),
        data: (feature) {
          if (feature != null && !_initialized) {
            _rubiconCodeCtrl.text = feature.rubiconCode ?? '';
            _licenseCtrl.text = feature.license ?? '';
            _areaCtrl.text = feature.area ?? '';
            _initialized = true;
          }
          return _buildForm(context);
        },
      );
    }
    _initialized = true;
    return _buildForm(context);
  }

  Widget _buildForm(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Feature' : 'New Feature'),
        actions: [
          if (_loading)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.space16),
              child: Center(
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
            )
          else
            Padding(
              padding: const EdgeInsets.only(right: AppSpacing.space8),
              child: FilledButton(
                onPressed: _submit,
                style: FilledButton.styleFrom(
                  minimumSize: const Size(80, 36),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                ),
                child: const Text('Save'),
              ),
            ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.space16,
          AppSpacing.space16,
          AppSpacing.space16,
          AppSpacing.space48,
        ),
        children: [
          SectionHeader(label: 'Optional metadata'),
          const SizedBox(height: AppSpacing.space4),
          Text(
            'Feature number and date are assigned automatically.',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
          const SizedBox(height: AppSpacing.space16),
          _field(_areaCtrl, 'Area', hint: 'e.g. North trench'),
          const SizedBox(height: AppSpacing.space12),
          _field(_rubiconCodeCtrl, 'Rubicon Code', hint: 'e.g. RC-2024-001'),
          const SizedBox(height: AppSpacing.space12),
          _field(_licenseCtrl, 'License', hint: 'e.g. ABC-12345'),
        ],
      ),
    );
  }

  Widget _field(TextEditingController ctrl, String label, {String? hint}) =>
      TextFormField(
        controller: ctrl,
        decoration: InputDecoration(labelText: label, hintText: hint),
        textCapitalization: TextCapitalization.words,
      );

  Future<void> _submit() async {
    setState(() => _loading = true);

    try {
      final repo = ref.read(featureRepositoryProvider);

      if (_isEditing) {
        final updated = await repo.update(
          id: widget.featureId!,
          rubiconCode:
              _rubiconCodeCtrl.text.trim().isEmpty ? null : _rubiconCodeCtrl.text.trim(),
          license:
              _licenseCtrl.text.trim().isEmpty ? null : _licenseCtrl.text.trim(),
          area: _areaCtrl.text.trim().isEmpty ? null : _areaCtrl.text.trim(),
        );
        ref.invalidate(featureDetailProvider(updated.id));
      } else {
        final created = await repo.create(
          rubiconCode:
              _rubiconCodeCtrl.text.trim().isEmpty ? null : _rubiconCodeCtrl.text.trim(),
          license:
              _licenseCtrl.text.trim().isEmpty ? null : _licenseCtrl.text.trim(),
          area: _areaCtrl.text.trim().isEmpty ? null : _areaCtrl.text.trim(),
        );
        ref.invalidate(featureListProvider);
        ref.invalidate(filteredFeatureListProvider);
        if (mounted) context.pushReplacement('/features/${created.id}');
        return;
      }

      ref.invalidate(featureListProvider);
      ref.invalidate(filteredFeatureListProvider);
      if (mounted) context.pop();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to save: $e'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }
}
