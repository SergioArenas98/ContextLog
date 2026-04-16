import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/enums.dart';
import '../../../../core/design/app_colors.dart';
import '../../../../core/design/app_typography.dart';
import '../../../../core/design/app_tokens.dart';
import '../../../../core/utils/validation_result.dart';
import '../../../../core/widgets/app_sheet_header.dart';
import '../../../../core/widgets/duplicate_warning_dialog.dart';
import '../../../../core/widgets/section_header.dart';
import '../../domain/models/context_model.dart';
import '../providers/context_providers.dart';

class ContextFormSheet extends ConsumerStatefulWidget {
  const ContextFormSheet({
    super.key,
    required this.featureId,
    required this.featureType,
    this.initialType,
    this.existingContext,
    required this.onSaved,
  });

  final String featureId;
  final FeatureType featureType;
  final ContextType? initialType;
  final ContextModel? existingContext;
  final VoidCallback onSaved;

  @override
  ConsumerState<ContextFormSheet> createState() => _ContextFormSheetState();
}

class _ContextFormSheetState extends ConsumerState<ContextFormSheet> {
  final _formKey = GlobalKey<FormState>();
  final _contextNumberCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();

  // Cut fields
  CutType _cutType = CutType.pit;
  final _customCutTypeCtrl = TextEditingController();
  final _heightCtrl = TextEditingController();
  final _widthCtrl = TextEditingController();
  final _depthCtrl = TextEditingController();

  // Fill fields
  String? _parentCutId;
  FillComposition? _composition;
  final _colorCtrl = TextEditingController();
  FillCompaction? _compaction;
  final _inclusionsCtrl = TextEditingController();

  late ContextType _type;
  bool _saving = false;

  bool get _isEditing => widget.existingContext != null;

  @override
  void initState() {
    super.initState();
    final existing = widget.existingContext;
    if (existing != null) {
      _type = existing.contextType;
      _contextNumberCtrl.text = existing.contextNumber.toString();
      _notesCtrl.text = existing.notes ?? '';

      switch (existing) {
        case CutModel(
              :final cutType,
              :final customCutTypeText,
              :final height,
              :final width,
              :final depth
            ):
          _cutType = cutType ?? CutType.pit;
          _customCutTypeCtrl.text = customCutTypeText ?? '';
          _heightCtrl.text = height?.toString() ?? '';
          _widthCtrl.text = width?.toString() ?? '';
          _depthCtrl.text = depth?.toString() ?? '';
        case FillModel(
              :final parentCutId,
              :final composition,
              :final color,
              :final compaction,
              :final inclusions
            ):
          _parentCutId = parentCutId;
          _composition = composition;
          _colorCtrl.text = color ?? '';
          _compaction = compaction;
          _inclusionsCtrl.text = inclusions ?? '';
      }
    } else {
      // Spread features are fill-only; ignore any initialType override.
      _type = widget.featureType == FeatureType.spread
          ? ContextType.fill
          : (widget.initialType ?? ContextType.cut);
    }
  }

  @override
  void dispose() {
    _contextNumberCtrl.dispose();
    _notesCtrl.dispose();
    _customCutTypeCtrl.dispose();
    _heightCtrl.dispose();
    _widthCtrl.dispose();
    _depthCtrl.dispose();
    _colorCtrl.dispose();
    _inclusionsCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.space24,
            AppSpacing.space16,
            AppSpacing.space24,
            AppSpacing.space24,
          ),
          children: [
            AppSheetHeader(
              title: _isEditing ? 'Edit Context' : 'Add Context',
              onClose: () => Navigator.of(context).pop(),
            ),
            // Spread features are fill-only — hide the type toggle.
            if (!_isEditing && widget.featureType != FeatureType.spread)
              SegmentedButton<ContextType>(
                segments: ContextType.values
                    .map(
                      (t) => ButtonSegment(
                        value: t,
                        label: Text(t.displayName),
                      ),
                    )
                    .toList(),
                selected: {_type},
                onSelectionChanged: (s) =>
                    setState(() => _type = s.first),
              ),
            // Spread feature label
            if (!_isEditing && widget.featureType == FeatureType.spread)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.space12,
                  vertical: AppSpacing.space8,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  borderRadius: AppRadius.smBorderRadius,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.layers_outlined,
                      size: 16,
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                    ),
                    const SizedBox(width: AppSpacing.space8),
                    Text(
                      'Spread — fill only',
                      style: TextStyle(
                        fontFamily: AppTypography.monoFontFamily,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                        color: Theme.of(context).colorScheme.onSecondaryContainer,
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: AppSpacing.space16),
            TextFormField(
              controller: _contextNumberCtrl,
              decoration: const InputDecoration(
                labelText: 'Context number *',
                hintText: 'From external context sheet',
              ),
              keyboardType: TextInputType.number,
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Required';
                if (int.tryParse(v.trim()) == null) {
                  return 'Must be a whole number';
                }
                return null;
              },
            ),
            const SizedBox(height: AppSpacing.space16),
            if (_type == ContextType.cut) ..._buildCutFields(),
            if (_type == ContextType.fill) ..._buildFillFields(),
            const SizedBox(height: AppSpacing.space12),
            TextFormField(
              controller: _notesCtrl,
              decoration: const InputDecoration(
                labelText: 'Notes',
                alignLabelWithHint: true,
              ),
              maxLines: 3,
              textCapitalization: TextCapitalization.sentences,
            ),
            const SizedBox(height: AppSpacing.space24),
            SafeArea(
              top: false,
              child: FilledButton(
                onPressed: _saving ? null : _save,
                style: FilledButton.styleFrom(
                  minimumSize: const Size(double.infinity, 52),
                ),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: _saving
                      ? const SizedBox(
                          key: ValueKey('loading'),
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(
                          key: const ValueKey('label'),
                          _isEditing ? 'Update' : 'Save Context',
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildCutFields() => [
        SectionHeader(label: 'Cut Properties'),
        const SizedBox(height: AppSpacing.space8),
        DropdownButtonFormField<CutType>(
          value: _cutType,
          decoration: const InputDecoration(labelText: 'Cut type'),
          items: CutType.values
              .map(
                (t) =>
                    DropdownMenuItem(value: t, child: Text(t.displayName)),
              )
              .toList(),
          onChanged: (v) {
            if (v != null) setState(() => _cutType = v);
          },
        ),
        if (_cutType == CutType.other) ...[
          const SizedBox(height: AppSpacing.space12),
          TextFormField(
            controller: _customCutTypeCtrl,
            decoration:
                const InputDecoration(labelText: 'Describe cut type *'),
            textCapitalization: TextCapitalization.sentences,
            validator: (v) =>
                _cutType == CutType.other && (v == null || v.trim().isEmpty)
                    ? 'Required for "other"'
                    : null,
          ),
        ],
        const SizedBox(height: AppSpacing.space16),
        SectionHeader(label: 'Dimensions (m)'),
        const SizedBox(height: AppSpacing.space8),
        Row(
          children: [
            Expanded(child: _dimensionField(_heightCtrl, 'Height')),
            const SizedBox(width: AppSpacing.space8),
            Expanded(child: _dimensionField(_widthCtrl, 'Width')),
            const SizedBox(width: AppSpacing.space8),
            Expanded(child: _dimensionField(_depthCtrl, 'Depth')),
          ],
        ),
        const SizedBox(height: AppSpacing.space12),
      ];

  List<Widget> _buildFillFields() {
    final isSpread = widget.featureType == FeatureType.spread;
    final cutsAsync = isSpread ? null : ref.watch(cutsByFeatureProvider(widget.featureId));
    return [
      SectionHeader(label: 'Fill Properties'),
      const SizedBox(height: AppSpacing.space8),
      if (!isSpread)
        cutsAsync!.when(
          loading: () => const CircularProgressIndicator(),
          error: (e, _) => Text('Error loading cuts: $e'),
          data: (cuts) {
            if (cuts.isEmpty) {
              return Container(
                padding: const EdgeInsets.all(AppSpacing.space12),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.errorContainer,
                  borderRadius: AppRadius.smBorderRadius,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.warning_rounded,
                      color: Theme.of(context).colorScheme.error,
                    ),
                    const SizedBox(width: AppSpacing.space8),
                    const Expanded(
                      child: Text(
                        'No cuts in this feature. Create a cut first, then add fills.',
                      ),
                    ),
                  ],
                ),
              );
            }
            return DropdownButtonFormField<String>(
              value: _parentCutId,
              decoration: const InputDecoration(labelText: 'Parent cut *'),
              items: cuts
                  .map(
                    (c) => DropdownMenuItem(
                      value: c.id,
                      child: Text('C${c.contextNumber} — Cut'),
                    ),
                  )
                  .toList(),
              validator: (v) =>
                  v == null || v.isEmpty ? 'A fill must have a parent cut' : null,
              onChanged: (v) => setState(() => _parentCutId = v),
            );
          },
        ),
      const SizedBox(height: AppSpacing.space12),
      DropdownButtonFormField<FillComposition?>(
        value: _composition,
        decoration: const InputDecoration(labelText: 'Composition'),
        items: [
          const DropdownMenuItem(value: null, child: Text('— unspecified —')),
          ...FillComposition.values.map(
            (c) => DropdownMenuItem(value: c, child: Text(c.displayName)),
          ),
        ],
        onChanged: (v) => setState(() => _composition = v),
      ),
      const SizedBox(height: AppSpacing.space12),
      TextFormField(
        controller: _colorCtrl,
        decoration: const InputDecoration(
          labelText: 'Color',
          hintText: 'e.g. Mid brown',
        ),
        textCapitalization: TextCapitalization.sentences,
      ),
      const SizedBox(height: AppSpacing.space12),
      DropdownButtonFormField<FillCompaction?>(
        value: _compaction,
        decoration: const InputDecoration(labelText: 'Compaction'),
        items: [
          const DropdownMenuItem(value: null, child: Text('— unspecified —')),
          ...FillCompaction.values.map(
            (c) => DropdownMenuItem(value: c, child: Text(c.displayName)),
          ),
        ],
        onChanged: (v) => setState(() => _compaction = v),
      ),
      const SizedBox(height: AppSpacing.space12),
      TextFormField(
        controller: _inclusionsCtrl,
        decoration: const InputDecoration(labelText: 'Inclusions'),
        textCapitalization: TextCapitalization.sentences,
      ),
      const SizedBox(height: AppSpacing.space12),
    ];
  }

  Widget _dimensionField(TextEditingController ctrl, String label) =>
      TextFormField(
        controller: ctrl,
        decoration: InputDecoration(labelText: label),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        validator: (v) {
          if (v == null || v.trim().isEmpty) return null;
          if (double.tryParse(v.trim()) == null) return 'Invalid';
          return null;
        },
      );

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);

    try {
      final contextNumber = int.parse(_contextNumberCtrl.text.trim());
      final repo = ref.read(contextRepositoryProvider);
      final validator = ref.read(contextValidatorProvider);

      final ValidationResult numResult;
      if (_type == ContextType.fill) {
        numResult = await validator.validateFill(
          featureId: widget.featureId,
          contextNumber: contextNumber,
          // null for spread fills — parent cut check is skipped in validator
          parentCutId: _parentCutId,
          excludeId: widget.existingContext?.id,
        );
      } else {
        numResult = await validator.validateContextNumber(
          featureId: widget.featureId,
          contextNumber: contextNumber,
          excludeId: widget.existingContext?.id,
        );
      }

      if (!mounted) return;

      switch (numResult) {
        case ValidationInvalid(:final message):
          _showError(message);
          return;
        case ValidationWarning(:final message):
          final confirmed =
              await showDuplicateWarningDialog(context, message: message);
          if (!confirmed || !mounted) return;
        case ValidationValid():
          break;
      }

      if (_type == ContextType.cut) {
        if (_isEditing) {
          await repo.updateCut(
            id: widget.existingContext!.id,
            contextNumber: contextNumber,
            cutType: _cutType,
            customCutTypeText: _cutType == CutType.other
                ? _customCutTypeCtrl.text.trim()
                : null,
            height: _parseDouble(_heightCtrl.text),
            width: _parseDouble(_widthCtrl.text),
            depth: _parseDouble(_depthCtrl.text),
            notes: _notesCtrl.text.trim().isEmpty
                ? null
                : _notesCtrl.text.trim(),
          );
        } else {
          await repo.createCut(
            featureId: widget.featureId,
            contextNumber: contextNumber,
            cutType: _cutType,
            customCutTypeText: _cutType == CutType.other
                ? _customCutTypeCtrl.text.trim()
                : null,
            height: _parseDouble(_heightCtrl.text),
            width: _parseDouble(_widthCtrl.text),
            depth: _parseDouble(_depthCtrl.text),
            notes: _notesCtrl.text.trim().isEmpty
                ? null
                : _notesCtrl.text.trim(),
          );
        }
      } else {
        if (_isEditing) {
          await repo.updateFill(
            id: widget.existingContext!.id,
            contextNumber: contextNumber,
            parentCutId: _parentCutId,
            composition: _composition,
            color: _colorCtrl.text.trim().isEmpty
                ? null
                : _colorCtrl.text.trim(),
            compaction: _compaction,
            inclusions: _inclusionsCtrl.text.trim().isEmpty
                ? null
                : _inclusionsCtrl.text.trim(),
            notes: _notesCtrl.text.trim().isEmpty
                ? null
                : _notesCtrl.text.trim(),
          );
        } else {
          await repo.createFill(
            featureId: widget.featureId,
            contextNumber: contextNumber,
            parentCutId: _parentCutId,
            composition: _composition,
            color: _colorCtrl.text.trim().isEmpty
                ? null
                : _colorCtrl.text.trim(),
            compaction: _compaction,
            inclusions: _inclusionsCtrl.text.trim().isEmpty
                ? null
                : _inclusionsCtrl.text.trim(),
            notes: _notesCtrl.text.trim().isEmpty
                ? null
                : _notesCtrl.text.trim(),
          );
        }
      }

      widget.onSaved();
      if (mounted) Navigator.of(context).pop();
    } catch (e) {
      _showError('Error saving: $e');
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  double? _parseDouble(String s) {
    final trimmed = s.trim();
    if (trimmed.isEmpty) return null;
    return double.tryParse(trimmed);
  }

  void _showError(String message) {
    setState(() => _saving = false);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).colorScheme.error,
      ),
    );
  }
}
