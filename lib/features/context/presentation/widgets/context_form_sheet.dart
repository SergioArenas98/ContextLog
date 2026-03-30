import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/enums.dart';
import '../../../../core/utils/validation_result.dart';
import '../../../../core/widgets/duplicate_warning_dialog.dart';
import '../../domain/models/context_model.dart';
import '../providers/context_providers.dart';

class ContextFormSheet extends ConsumerStatefulWidget {
  const ContextFormSheet({
    super.key,
    required this.featureId,
    this.initialType,
    this.existingContext,
    required this.onSaved,
  });

  final String featureId;
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
  final _compositionCtrl = TextEditingController();
  final _colorCtrl = TextEditingController();
  final _compactionCtrl = TextEditingController();
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
        case CutModel(:final cutType, :final customCutTypeText, :final height,
              :final width, :final depth):
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
          _compositionCtrl.text = composition ?? '';
          _colorCtrl.text = color ?? '';
          _compactionCtrl.text = compaction ?? '';
          _inclusionsCtrl.text = inclusions ?? '';
      }
    } else {
      _type = widget.initialType ?? ContextType.cut;
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
    _compositionCtrl.dispose();
    _colorCtrl.dispose();
    _compactionCtrl.dispose();
    _inclusionsCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(24),
          children: [
            Row(
              children: [
                Text(
                  _isEditing ? 'Edit Context' : 'Add Context',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (!_isEditing)
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
            const SizedBox(height: 16),
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
            const SizedBox(height: 16),
            if (_type == ContextType.cut) ..._buildCutFields(),
            if (_type == ContextType.fill) ..._buildFillFields(),
            const SizedBox(height: 12),
            TextFormField(
              controller: _notesCtrl,
              decoration: const InputDecoration(
                labelText: 'Notes',
                alignLabelWithHint: true,
              ),
              maxLines: 3,
              textCapitalization: TextCapitalization.sentences,
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _saving ? null : _save,
              child: _saving
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(_isEditing ? 'Update' : 'Save Context'),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildCutFields() => [
        DropdownButtonFormField<CutType>(
          value: _cutType,
          decoration: const InputDecoration(labelText: 'Cut type'),
          items: CutType.values
              .map(
                (t) => DropdownMenuItem(value: t, child: Text(t.displayName)),
              )
              .toList(),
          onChanged: (v) {
            if (v != null) setState(() => _cutType = v);
          },
        ),
        if (_cutType == CutType.other) ...[
          const SizedBox(height: 12),
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
        const SizedBox(height: 16),
        Text(
          'Dimensions (m)',
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: Theme.of(context).colorScheme.outline,
              ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(child: _dimensionField(_heightCtrl, 'Height')),
            const SizedBox(width: 8),
            Expanded(child: _dimensionField(_widthCtrl, 'Width')),
            const SizedBox(width: 8),
            Expanded(child: _dimensionField(_depthCtrl, 'Depth')),
          ],
        ),
        const SizedBox(height: 12),
      ];

  List<Widget> _buildFillFields() {
    final cutsAsync = ref.watch(cutsByFeatureProvider(widget.featureId));
    return [
      cutsAsync.when(
        loading: () => const CircularProgressIndicator(),
        error: (e, _) => Text('Error loading cuts: $e'),
        data: (cuts) {
          if (cuts.isEmpty) {
            return Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.errorContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.warning_amber,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  const SizedBox(width: 8),
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
      const SizedBox(height: 12),
      TextFormField(
        controller: _compositionCtrl,
        decoration: const InputDecoration(labelText: 'Composition'),
        textCapitalization: TextCapitalization.sentences,
      ),
      const SizedBox(height: 12),
      TextFormField(
        controller: _colorCtrl,
        decoration: const InputDecoration(
          labelText: 'Color',
          hintText: 'e.g. Mid brown',
        ),
        textCapitalization: TextCapitalization.sentences,
      ),
      const SizedBox(height: 12),
      TextFormField(
        controller: _compactionCtrl,
        decoration: const InputDecoration(labelText: 'Compaction'),
        textCapitalization: TextCapitalization.sentences,
      ),
      const SizedBox(height: 12),
      TextFormField(
        controller: _inclusionsCtrl,
        decoration: const InputDecoration(labelText: 'Inclusions'),
        textCapitalization: TextCapitalization.sentences,
      ),
      const SizedBox(height: 12),
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

      // Validate context number (warns on duplicate)
      final ValidationResult numResult;
      if (_type == ContextType.fill && _parentCutId != null) {
        numResult = await validator.validateFill(
          featureId: widget.featureId,
          contextNumber: contextNumber,
          parentCutId: _parentCutId!,
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
            customCutTypeText:
                _cutType == CutType.other ? _customCutTypeCtrl.text.trim() : null,
            height: _parseDouble(_heightCtrl.text),
            width: _parseDouble(_widthCtrl.text),
            depth: _parseDouble(_depthCtrl.text),
            notes: _notesCtrl.text.trim().isEmpty ? null : _notesCtrl.text.trim(),
          );
        } else {
          await repo.createCut(
            featureId: widget.featureId,
            contextNumber: contextNumber,
            cutType: _cutType,
            customCutTypeText:
                _cutType == CutType.other ? _customCutTypeCtrl.text.trim() : null,
            height: _parseDouble(_heightCtrl.text),
            width: _parseDouble(_widthCtrl.text),
            depth: _parseDouble(_depthCtrl.text),
            notes: _notesCtrl.text.trim().isEmpty ? null : _notesCtrl.text.trim(),
          );
        }
      } else {
        if (_isEditing) {
          await repo.updateFill(
            id: widget.existingContext!.id,
            contextNumber: contextNumber,
            parentCutId: _parentCutId!,
            composition: _compositionCtrl.text.trim().isEmpty
                ? null
                : _compositionCtrl.text.trim(),
            color: _colorCtrl.text.trim().isEmpty
                ? null
                : _colorCtrl.text.trim(),
            compaction: _compactionCtrl.text.trim().isEmpty
                ? null
                : _compactionCtrl.text.trim(),
            inclusions: _inclusionsCtrl.text.trim().isEmpty
                ? null
                : _inclusionsCtrl.text.trim(),
            notes: _notesCtrl.text.trim().isEmpty ? null : _notesCtrl.text.trim(),
          );
        } else {
          await repo.createFill(
            featureId: widget.featureId,
            contextNumber: contextNumber,
            parentCutId: _parentCutId!,
            composition: _compositionCtrl.text.trim().isEmpty
                ? null
                : _compositionCtrl.text.trim(),
            color: _colorCtrl.text.trim().isEmpty
                ? null
                : _colorCtrl.text.trim(),
            compaction: _compactionCtrl.text.trim().isEmpty
                ? null
                : _compactionCtrl.text.trim(),
            inclusions: _inclusionsCtrl.text.trim().isEmpty
                ? null
                : _inclusionsCtrl.text.trim(),
            notes: _notesCtrl.text.trim().isEmpty ? null : _notesCtrl.text.trim(),
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
