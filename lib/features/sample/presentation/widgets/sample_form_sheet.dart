import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/enums.dart';
import '../../../../core/design/app_tokens.dart';
import '../../../../core/utils/validation_result.dart';
import '../../../../core/widgets/app_sheet_header.dart';
import '../../../../core/widgets/duplicate_warning_dialog.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../context/domain/models/context_model.dart';
import '../../../context/presentation/providers/context_providers.dart';
import '../../domain/models/sample_model.dart';
import '../providers/sample_providers.dart';

class SampleFormSheet extends ConsumerStatefulWidget {
  const SampleFormSheet({
    super.key,
    required this.featureId,
    this.sample,
    required this.onSaved,
  });

  final String featureId;
  final SampleModel? sample;
  final VoidCallback onSaved;

  @override
  ConsumerState<SampleFormSheet> createState() => _SampleFormSheetState();
}

class _SampleFormSheetState extends ConsumerState<SampleFormSheet> {
  final _formKey = GlobalKey<FormState>();
  final _sampleNumberCtrl = TextEditingController();
  final _litersCtrl = TextEditingController();
  final _customTypeCtrl = TextEditingController();
  SampleType _sampleType = SampleType.soil;
  StorageType _storageType = StorageType.bag;
  int _storageCount = 1;
  String? _fillId;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    if (widget.sample != null) {
      final s = widget.sample!;
      _sampleNumberCtrl.text = s.sampleNumber.toString();
      _litersCtrl.text = s.liters?.toString() ?? '';
      _sampleType = s.sampleType;
      _customTypeCtrl.text = s.customSampleTypeText ?? '';
      _storageType = s.storageType;
      _storageCount = s.storageCount;
      _fillId = s.fillId;
    }
  }

  @override
  void dispose() {
    _sampleNumberCtrl.dispose();
    _litersCtrl.dispose();
    _customTypeCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fillsAsync = ref.watch(fillsByFeatureProvider(widget.featureId));

    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
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
              title: widget.sample == null ? 'Add Sample' : 'Edit Sample',
              onClose: () => Navigator.of(context).pop(),
            ),
            TextFormField(
              controller: _sampleNumberCtrl,
              decoration: const InputDecoration(
                labelText: 'Sample number *',
                helperText: 'Globally unique — warned if already used',
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
            SectionHeader(label: 'Provenance'),
            const SizedBox(height: AppSpacing.space8),
            fillsAsync.when(
              loading: () => const CircularProgressIndicator(),
              error: (e, _) => Text('Error: $e'),
              data: (fills) {
                if (fills.isEmpty) {
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
                            'No fills in this feature. Create a fill first.',
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return DropdownButtonFormField<String>(
                  value: _fillId,
                  decoration: const InputDecoration(labelText: 'From fill *'),
                  items: fills
                      .cast<FillModel>()
                      .map(
                        (f) => DropdownMenuItem(
                          value: f.id,
                          child: Text('C${f.contextNumber} — Fill'),
                        ),
                      )
                      .toList(),
                  validator: (v) => v == null ? 'Select a fill' : null,
                  onChanged: (v) => setState(() => _fillId = v),
                );
              },
            ),
            const SizedBox(height: AppSpacing.space16),
            SectionHeader(label: 'Sample Type'),
            const SizedBox(height: AppSpacing.space8),
            DropdownButtonFormField<SampleType>(
              value: _sampleType,
              decoration: const InputDecoration(labelText: 'Sample type'),
              items: SampleType.values
                  .map(
                    (t) =>
                        DropdownMenuItem(value: t, child: Text(t.displayName)),
                  )
                  .toList(),
              onChanged: (v) {
                if (v != null) setState(() => _sampleType = v);
              },
            ),
            if (_sampleType == SampleType.other) ...[
              const SizedBox(height: AppSpacing.space12),
              TextFormField(
                controller: _customTypeCtrl,
                decoration:
                    const InputDecoration(labelText: 'Describe sample type *'),
                textCapitalization: TextCapitalization.sentences,
                validator: (v) =>
                    _sampleType == SampleType.other &&
                            (v == null || v.trim().isEmpty)
                        ? 'Required for "other"'
                        : null,
              ),
            ],
            const SizedBox(height: AppSpacing.space16),
            SectionHeader(label: 'Storage'),
            const SizedBox(height: AppSpacing.space8),
            DropdownButtonFormField<StorageType>(
              value: _storageType,
              decoration: const InputDecoration(labelText: 'Storage type'),
              items: StorageType.values
                  .map(
                    (t) =>
                        DropdownMenuItem(value: t, child: Text(t.displayName)),
                  )
                  .toList(),
              onChanged: (v) {
                if (v != null) setState(() => _storageType = v);
              },
            ),
            const SizedBox(height: AppSpacing.space12),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove_rounded),
                  onPressed: _storageCount > 1
                      ? () => setState(() => _storageCount--)
                      : null,
                  style: IconButton.styleFrom(minimumSize: const Size(44, 44)),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        '$_storageCount',
                        style: Theme.of(context).textTheme.titleMedium,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'units',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add_rounded),
                  onPressed: () => setState(() => _storageCount++),
                  style: IconButton.styleFrom(minimumSize: const Size(44, 44)),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.space12),
            TextFormField(
              controller: _litersCtrl,
              decoration: const InputDecoration(
                labelText: 'Volume',
                hintText: 'e.g. 5',
                suffixText: 'L',
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              validator: (v) {
                if (v == null || v.trim().isEmpty) return null;
                if (double.tryParse(v.trim()) == null) return 'Invalid number';
                return null;
              },
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
                          widget.sample == null ? 'Save Sample' : 'Update',
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    if (_fillId == null) return;
    setState(() => _saving = true);

    try {
      final sampleNumber = int.parse(_sampleNumberCtrl.text.trim());
      final validator = ref.read(sampleValidatorProvider);

      // Check global sample number uniqueness
      final numResult = await validator.validateSampleNumber(
        sampleNumber: sampleNumber,
        excludeId: widget.sample?.id,
      );

      if (!mounted) return;

      switch (numResult) {
        case ValidationInvalid(:final message):
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
          setState(() => _saving = false);
          return;
        case ValidationWarning(:final message):
          final confirmed =
              await showDuplicateWarningDialog(context, message: message);
          if (!confirmed || !mounted) {
            setState(() => _saving = false);
            return;
          }
        case ValidationValid():
          break;
      }

      // Derive cutId from fill's parentCutId.
      // Spread fills have no parent cut; use '' as sentinel.
      final contextRepo = ref.read(contextRepositoryProvider);
      final fill = await contextRepo.getById(_fillId!);
      if (fill is! FillModel) {
        _showError('Selected fill is invalid');
        return;
      }
      final cutId = fill.parentCutId ?? '';

      final repo = ref.read(sampleRepositoryProvider);
      if (widget.sample != null) {
        await repo.update(
          id: widget.sample!.id,
          fillId: _fillId!,
          cutId: cutId,
          sampleNumber: sampleNumber,
          sampleType: _sampleType,
          customSampleTypeText:
              _sampleType == SampleType.other ? _customTypeCtrl.text.trim() : null,
          storageType: _storageType,
          storageCount: _storageCount,
          liters: _litersCtrl.text.trim().isEmpty
              ? null
              : double.parse(_litersCtrl.text.trim()),
        );
      } else {
        await repo.create(
          featureId: widget.featureId,
          fillId: _fillId!,
          cutId: cutId,
          sampleNumber: sampleNumber,
          sampleType: _sampleType,
          customSampleTypeText:
              _sampleType == SampleType.other ? _customTypeCtrl.text.trim() : null,
          storageType: _storageType,
          storageCount: _storageCount,
          liters: _litersCtrl.text.trim().isEmpty
              ? null
              : double.parse(_litersCtrl.text.trim()),
        );
      }

      widget.onSaved();
      if (mounted) Navigator.of(context).pop();
    } catch (e) {
      _showError('Error: $e');
    } finally {
      if (mounted) setState(() => _saving = false);
    }
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
