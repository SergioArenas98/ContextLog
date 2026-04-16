import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/constants/enums.dart';
import '../../../../core/design/app_tokens.dart';
import '../../../../core/utils/image_storage.dart';
import '../../../../core/widgets/app_sheet_header.dart';
import '../../domain/models/photo_model.dart';
import '../providers/photo_providers.dart';

class PhotoFormSheet extends ConsumerStatefulWidget {
  const PhotoFormSheet({
    super.key,
    required this.featureId,
    this.photo,
    required this.onSaved,
  });

  final String featureId;
  final PhotoModel? photo;
  final VoidCallback onSaved;

  @override
  ConsumerState<PhotoFormSheet> createState() => _PhotoFormSheetState();
}

class _PhotoFormSheetState extends ConsumerState<PhotoFormSheet> {
  final _formKey = GlobalKey<FormState>();
  final _photoNumberCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();
  PhotoStage _stage = PhotoStage.preEx;
  CardinalOrientation _orientation = CardinalOrientation.unknown;
  String? _localImagePath;
  bool _saving = false;

  bool get _isEditing => widget.photo != null;

  @override
  void initState() {
    super.initState();
    if (_isEditing) {
      final p = widget.photo!;
      _photoNumberCtrl.text = p.manualCameraPhotoNumber ?? '';
      _notesCtrl.text = p.notes ?? '';
      _stage = p.stage;
      _orientation = p.cardinalOrientation;
      _localImagePath = p.localImagePath;
    }
  }

  @override
  void dispose() {
    _photoNumberCtrl.dispose();
    _notesCtrl.dispose();
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
              title: _isEditing ? 'Edit Photo' : 'Add Photo',
              onClose: () => Navigator.of(context).pop(),
            ),
            DropdownButtonFormField<PhotoStage>(
              value: _stage,
              decoration: const InputDecoration(labelText: 'Stage'),
              items: PhotoStage.values
                  .map(
                    (s) =>
                        DropdownMenuItem(value: s, child: Text(s.displayName)),
                  )
                  .toList(),
              onChanged: (v) {
                if (v != null) setState(() => _stage = v);
              },
            ),
            const SizedBox(height: AppSpacing.space12),
            TextFormField(
              controller: _photoNumberCtrl,
              decoration: const InputDecoration(
                labelText: 'Photo number',
                hintText: 'Manual roll/frame number',
              ),
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: AppSpacing.space12),
            DropdownButtonFormField<CardinalOrientation>(
              value: _orientation,
              decoration:
                  const InputDecoration(labelText: 'Facing (cardinal direction)'),
              items: CardinalOrientation.values
                  .map(
                    (o) =>
                        DropdownMenuItem(value: o, child: Text(o.displayName)),
                  )
                  .toList(),
              onChanged: (v) {
                if (v != null) setState(() => _orientation = v);
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
            _ReferencePhotoButton(
              imagePath: _localImagePath,
              onCapture: _capturePhoto,
              onRemove: () => setState(() => _localImagePath = null),
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
                          _isEditing ? 'Update' : 'Save Photo',
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _capturePhoto() async {
    final picker = ImagePicker();
    final xFile = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
    );
    if (xFile != null) {
      final permanentPath = await ImageStorage.copyToAppStorage(xFile.path);
      setState(() => _localImagePath = permanentPath);
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    try {
      final repo = ref.read(photoRepositoryProvider);
      if (_isEditing) {
        await repo.update(
          id: widget.photo!.id,
          stage: _stage,
          manualCameraPhotoNumber: _photoNumberCtrl.text.trim().isEmpty
              ? null
              : _photoNumberCtrl.text.trim(),
          cardinalOrientation: _orientation,
          notes:
              _notesCtrl.text.trim().isEmpty ? null : _notesCtrl.text.trim(),
          localImagePath: _localImagePath,
        );
      } else {
        await repo.create(
          featureId: widget.featureId,
          stage: _stage,
          manualCameraPhotoNumber: _photoNumberCtrl.text.trim().isEmpty
              ? null
              : _photoNumberCtrl.text.trim(),
          cardinalOrientation: _orientation,
          notes:
              _notesCtrl.text.trim().isEmpty ? null : _notesCtrl.text.trim(),
          localImagePath: _localImagePath,
        );
      }
      widget.onSaved();
      if (mounted) Navigator.of(context).pop();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving photo: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }
}

class _ReferencePhotoButton extends StatelessWidget {
  const _ReferencePhotoButton({
    required this.imagePath,
    required this.onCapture,
    required this.onRemove,
  });

  final String? imagePath;
  final VoidCallback onCapture;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final path = imagePath;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Reference photo (optional)',
          style: theme.textTheme.labelMedium?.copyWith(
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
          InkWell(
            onTap: onCapture,
            borderRadius: AppRadius.mdBorderRadius,
            child: Container(
              width: double.infinity,
              height: 120,
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
                    Icons.add_a_photo_rounded,
                    size: 32,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(height: AppSpacing.space8),
                  Text(
                    'Tap to capture reference photo',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
