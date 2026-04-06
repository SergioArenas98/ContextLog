import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/enums.dart';
import '../../../../core/design/app_tokens.dart';
import '../../../../core/widgets/app_sheet_header.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../context/domain/models/context_model.dart';
import '../../../context/presentation/providers/context_providers.dart';
import '../../domain/models/find_model.dart';
import '../providers/find_providers.dart';

class FindFormSheet extends ConsumerStatefulWidget {
  const FindFormSheet({
    super.key,
    required this.featureId,
    this.find,
    required this.onSaved,
  });

  final String featureId;
  final FindModel? find;
  final VoidCallback onSaved;

  @override
  ConsumerState<FindFormSheet> createState() => _FindFormSheetState();
}

class _FindFormSheetState extends ConsumerState<FindFormSheet> {
  final _formKey = GlobalKey<FormState>();
  final _findNumberCtrl = TextEditingController();
  final _quantityCtrl = TextEditingController(text: '1');
  final _descriptionCtrl = TextEditingController();
  final _customMaterialCtrl = TextEditingController();
  FindMaterialType _materialType = FindMaterialType.flint;
  String? _fillId;
  bool _saving = false;
  bool _suggestedNumber = false;

  @override
  void initState() {
    super.initState();
    if (widget.find != null) {
      final f = widget.find!;
      _findNumberCtrl.text = f.findNumber.toString();
      _quantityCtrl.text = f.quantity.toString();
      _descriptionCtrl.text = f.description ?? '';
      _materialType = f.materialType;
      _customMaterialCtrl.text = f.customMaterialText ?? '';
      _fillId = f.fillId;
    }
  }

  @override
  void dispose() {
    _findNumberCtrl.dispose();
    _quantityCtrl.dispose();
    _descriptionCtrl.dispose();
    _customMaterialCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Auto-suggest next find number if creating
    if (!_suggestedNumber && widget.find == null) {
      final nextAsync = ref.watch(nextFindNumberProvider(widget.featureId));
      nextAsync.whenData((n) {
        if (!_suggestedNumber) {
          _findNumberCtrl.text = n.toString();
          _suggestedNumber = true;
        }
      });
    }

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
              title: widget.find == null ? 'Add Find' : 'Edit Find',
              onClose: () => Navigator.of(context).pop(),
            ),
            TextFormField(
              controller: _findNumberCtrl,
              decoration: InputDecoration(
                labelText: 'Find number *',
                hintText: 'Auto-suggested, can be changed',
                suffixIcon: _suggestedNumber
                    ? Icon(
                        Icons.auto_awesome_rounded,
                        size: 16,
                        color: Theme.of(context).colorScheme.primary,
                      )
                    : null,
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
                  return _noFillsWarning(context);
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
            SectionHeader(label: 'Material'),
            const SizedBox(height: AppSpacing.space8),
            DropdownButtonFormField<FindMaterialType>(
              value: _materialType,
              decoration: const InputDecoration(labelText: 'Material type'),
              items: FindMaterialType.values
                  .map(
                    (t) =>
                        DropdownMenuItem(value: t, child: Text(t.displayName)),
                  )
                  .toList(),
              onChanged: (v) {
                if (v != null) setState(() => _materialType = v);
              },
            ),
            if (_materialType == FindMaterialType.other) ...[
              const SizedBox(height: AppSpacing.space12),
              TextFormField(
                controller: _customMaterialCtrl,
                decoration:
                    const InputDecoration(labelText: 'Describe material *'),
                textCapitalization: TextCapitalization.sentences,
                validator: (v) =>
                    _materialType == FindMaterialType.other &&
                            (v == null || v.trim().isEmpty)
                        ? 'Required for "other"'
                        : null,
              ),
            ],
            const SizedBox(height: AppSpacing.space16),
            SectionHeader(label: 'Details'),
            const SizedBox(height: AppSpacing.space8),
            // Quantity with +/- buttons
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove_rounded),
                  onPressed: () {
                    final n =
                        int.tryParse(_quantityCtrl.text.trim()) ?? 1;
                    if (n > 1) {
                      setState(() => _quantityCtrl.text = '${n - 1}');
                    }
                  },
                  style: IconButton.styleFrom(
                    minimumSize: const Size(44, 44),
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    controller: _quantityCtrl,
                    decoration: const InputDecoration(labelText: 'Quantity *'),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) return 'Required';
                      final n = int.tryParse(v.trim());
                      if (n == null || n <= 0) {
                        return 'Must be a positive number';
                      }
                      return null;
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add_rounded),
                  onPressed: () {
                    final n =
                        int.tryParse(_quantityCtrl.text.trim()) ?? 0;
                    setState(() => _quantityCtrl.text = '${n + 1}');
                  },
                  style: IconButton.styleFrom(
                    minimumSize: const Size(44, 44),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.space12),
            TextFormField(
              controller: _descriptionCtrl,
              decoration: const InputDecoration(
                labelText: 'Description',
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
                          widget.find == null ? 'Save Find' : 'Update',
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _noFillsWarning(BuildContext context) {
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
            child: Text('No fills in this feature. Create a fill first.'),
          ),
        ],
      ),
    );
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    if (_fillId == null) return;
    setState(() => _saving = true);
    try {
      final repo = ref.read(findRepositoryProvider);
      final findNumber = int.parse(_findNumberCtrl.text.trim());
      final quantity = int.parse(_quantityCtrl.text.trim());

      if (widget.find != null) {
        await repo.update(
          id: widget.find!.id,
          fillId: _fillId!,
          findNumber: findNumber,
          materialType: _materialType,
          customMaterialText:
              _materialType == FindMaterialType.other ? _customMaterialCtrl.text.trim() : null,
          quantity: quantity,
          description: _descriptionCtrl.text.trim().isEmpty
              ? null
              : _descriptionCtrl.text.trim(),
        );
      } else {
        await repo.create(
          featureId: widget.featureId,
          fillId: _fillId!,
          findNumber: findNumber,
          materialType: _materialType,
          customMaterialText:
              _materialType == FindMaterialType.other ? _customMaterialCtrl.text.trim() : null,
          quantity: quantity,
          description: _descriptionCtrl.text.trim().isEmpty
              ? null
              : _descriptionCtrl.text.trim(),
        );
      }
      widget.onSaved();
      if (mounted) Navigator.of(context).pop();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }
}
