import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/constants/enums.dart';
import '../../../../core/design/app_tokens.dart';
import '../../../../core/utils/image_storage.dart';
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
  String? _referenceImagePath;
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
      _referenceImagePath = widget.drawing!.referenceImagePath;
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
            const SizedBox(height: AppSpacing.space16),
            _DrawingReferenceImageButton(
              imagePath: _referenceImagePath,
              onPickImage: _pickImage,
              onRemove: _removeImage,
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

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final xFile = await picker.pickImage(source: source, imageQuality: 80);
    if (xFile != null && mounted) {
      final permanentPath = await ImageStorage.copyToAppStorage(xFile.path);
      // Delete old file if replacing
      await ImageStorage.deleteIfExists(_referenceImagePath);
      setState(() => _referenceImagePath = permanentPath);
    }
  }

  Future<void> _removeImage() async {
    await ImageStorage.deleteIfExists(_referenceImagePath);
    setState(() => _referenceImagePath = null);
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
          referenceImagePath: _referenceImagePath,
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
          referenceImagePath: _referenceImagePath,
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

// ── Reference image button ────────────────────────────────────────────────────

class _DrawingReferenceImageButton extends StatelessWidget {
  const _DrawingReferenceImageButton({
    required this.imagePath,
    required this.onPickImage,
    required this.onRemove,
  });

  final String? imagePath;
  final Future<void> Function(ImageSource source) onPickImage;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final path = imagePath;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Reference image (optional)',
          style: theme.textTheme.labelMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: AppSpacing.space4),
        Text(
          'A visual reminder — not an official excavation photo.',
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: AppSpacing.space8),
        if (path != null)
          Stack(
            children: [
              ClipRRect(
                borderRadius: AppRadius.mdBorderRadius,
                child: Image.file(
                  File(path),
                  width: double.infinity,
                  height: 160,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: 160,
                    color: theme.colorScheme.surfaceContainerHigh,
                    child: const Icon(Icons.broken_image, size: 40),
                  ),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Material(
                  color: theme.colorScheme.surfaceContainerHighest
                      .withAlpha(220),
                  borderRadius: AppRadius.fullBorderRadius,
                  child: InkWell(
                    borderRadius: AppRadius.fullBorderRadius,
                    onTap: onRemove,
                    child: const Padding(
                      padding: EdgeInsets.all(6),
                      child: Icon(Icons.close_rounded, size: 18),
                    ),
                  ),
                ),
              ),
            ],
          )
        else
          Row(
            children: [
              Expanded(
                child: _ImageSourceButton(
                  icon: Icons.camera_alt_rounded,
                  label: 'Camera',
                  onTap: () => onPickImage(ImageSource.camera),
                  theme: theme,
                ),
              ),
              const SizedBox(width: AppSpacing.space8),
              Expanded(
                child: _ImageSourceButton(
                  icon: Icons.photo_library_outlined,
                  label: 'Gallery',
                  onTap: () => onPickImage(ImageSource.gallery),
                  theme: theme,
                ),
              ),
            ],
          ),
      ],
    );
  }
}

class _ImageSourceButton extends StatelessWidget {
  const _ImageSourceButton({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.theme,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppRadius.mdBorderRadius,
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          borderRadius: AppRadius.mdBorderRadius,
          border: Border.all(
            color: theme.colorScheme.outlineVariant,
            width: 1.5,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 24,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: AppSpacing.space4),
            Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
