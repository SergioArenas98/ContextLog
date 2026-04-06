import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/enums.dart';
import '../../../../core/design/app_tokens.dart';
import '../../../../core/widgets/app_sheet_header.dart';
import '../../domain/models/drawing_model.dart';
import '../providers/drawing_providers.dart';

class DrawingFormSheet extends ConsumerStatefulWidget {
  const DrawingFormSheet({
    super.key,
    required this.featureId,
    this.drawing,
    required this.onSaved,
  });

  final String featureId;
  final DrawingModel? drawing;
  final VoidCallback onSaved;

  @override
  ConsumerState<DrawingFormSheet> createState() => _DrawingFormSheetState();
}

class _DrawingFormSheetState extends ConsumerState<DrawingFormSheet> {
  final _formKey = GlobalKey<FormState>();
  final _drawingNumberCtrl = TextEditingController();
  final _boardNumberCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();
  DrawingType? _drawingType;
  CardinalOrientation _facing = CardinalOrientation.unknown;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    if (widget.drawing != null) {
      _drawingNumberCtrl.text = widget.drawing!.drawingNumber;
      _boardNumberCtrl.text = widget.drawing!.boardNumber ?? '';
      _notesCtrl.text = widget.drawing!.notes ?? '';
      _drawingType = widget.drawing!.drawingType;
      _facing = widget.drawing!.facing;
    }
  }

  @override
  void dispose() {
    _drawingNumberCtrl.dispose();
    _boardNumberCtrl.dispose();
    _notesCtrl.dispose();
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
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.space24,
            AppSpacing.space16,
            AppSpacing.space24,
            AppSpacing.space24,
          ),
          children: [
            AppSheetHeader(
              title: widget.drawing == null ? 'Add Drawing' : 'Edit Drawing',
              onClose: () => Navigator.of(context).pop(),
            ),
            TextFormField(
              controller: _drawingNumberCtrl,
              decoration: const InputDecoration(
                labelText: 'Drawing number *',
                hintText: 'e.g. D01',
              ),
              textCapitalization: TextCapitalization.words,
              validator: (v) =>
                  v == null || v.trim().isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: AppSpacing.space12),
            TextFormField(
              controller: _boardNumberCtrl,
              decoration: const InputDecoration(
                labelText: 'Board number',
                hintText: 'e.g. B3',
              ),
            ),
            const SizedBox(height: AppSpacing.space12),
            // Drawing type dropdown
            DropdownButtonFormField<DrawingType?>(
              value: _drawingType,
              decoration: const InputDecoration(labelText: 'Type'),
              items: [
                const DropdownMenuItem(value: null, child: Text('—')),
                ...DrawingType.values.map(
                  (t) => DropdownMenuItem(
                    value: t,
                    child: Text(t.displayName),
                  ),
                ),
              ],
              onChanged: (v) => setState(() => _drawingType = v),
            ),
            const SizedBox(height: AppSpacing.space12),
            // Facing dropdown
            DropdownButtonFormField<CardinalOrientation>(
              value: _facing,
              decoration: const InputDecoration(labelText: 'Facing'),
              items: CardinalOrientation.values
                  .map(
                    (o) => DropdownMenuItem(
                      value: o,
                      child: Text(o.displayName),
                    ),
                  )
                  .toList(),
              onChanged: (v) {
                if (v != null) setState(() => _facing = v);
              },
            ),
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
                          widget.drawing == null ? 'Save Drawing' : 'Update',
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
    setState(() => _saving = true);
    try {
      final repo = ref.read(drawingRepositoryProvider);
      if (widget.drawing != null) {
        await repo.update(
          id: widget.drawing!.id,
          drawingNumber: _drawingNumberCtrl.text.trim(),
          boardNumber: _boardNumberCtrl.text.trim().isEmpty
              ? null
              : _boardNumberCtrl.text.trim(),
          drawingType: _drawingType,
          facing: _facing,
          notes:
              _notesCtrl.text.trim().isEmpty ? null : _notesCtrl.text.trim(),
        );
      } else {
        await repo.create(
          featureId: widget.featureId,
          drawingNumber: _drawingNumberCtrl.text.trim(),
          boardNumber: _boardNumberCtrl.text.trim().isEmpty
              ? null
              : _boardNumberCtrl.text.trim(),
          drawingType: _drawingType,
          facing: _facing,
          notes:
              _notesCtrl.text.trim().isEmpty ? null : _notesCtrl.text.trim(),
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
