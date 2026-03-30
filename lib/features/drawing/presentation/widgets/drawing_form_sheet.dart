import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    if (widget.drawing != null) {
      _drawingNumberCtrl.text = widget.drawing!.drawingNumber;
      _boardNumberCtrl.text = widget.drawing!.boardNumber ?? '';
      _notesCtrl.text = widget.drawing!.notes ?? '';
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
          padding: const EdgeInsets.all(24),
          children: [
            Row(
              children: [
                Text(
                  widget.drawing == null ? 'Add Drawing' : 'Edit Drawing',
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
            const SizedBox(height: 12),
            TextFormField(
              controller: _boardNumberCtrl,
              decoration: const InputDecoration(
                labelText: 'Board number',
                hintText: 'e.g. B3',
              ),
            ),
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
                  : Text(widget.drawing == null ? 'Save Drawing' : 'Update'),
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
