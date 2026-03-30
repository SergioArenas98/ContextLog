import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/constants/enums.dart';
import '../../../../core/utils/image_storage.dart';
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
          padding: const EdgeInsets.all(24),
          children: [
            Row(
              children: [
                Text(
                  _isEditing ? 'Edit Photo' : 'Add Photo',
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
            _StageDropdown(
              value: _stage,
              onChanged: (v) => setState(() => _stage = v),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _photoNumberCtrl,
              decoration: const InputDecoration(
                labelText: 'Camera photo number',
                hintText: 'Manual roll/frame number',
              ),
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 12),
            _OrientationPicker(
              value: _orientation,
              onChanged: (v) => setState(() => _orientation = v),
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
            const SizedBox(height: 16),
            _ReferencePhotoButton(
              imagePath: _localImagePath,
              onCapture: _capturePhoto,
              onRemove: () => setState(() => _localImagePath = null),
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
                  : Text(_isEditing ? 'Update' : 'Save Photo'),
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
          notes: _notesCtrl.text.trim().isEmpty ? null : _notesCtrl.text.trim(),
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
          notes: _notesCtrl.text.trim().isEmpty ? null : _notesCtrl.text.trim(),
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

class _StageDropdown extends StatelessWidget {
  const _StageDropdown({required this.value, required this.onChanged});

  final PhotoStage value;
  final ValueChanged<PhotoStage> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<PhotoStage>(
      value: value,
      decoration: const InputDecoration(labelText: 'Stage'),
      items: PhotoStage.values
          .map(
            (s) => DropdownMenuItem(value: s, child: Text(s.displayName)),
          )
          .toList(),
      onChanged: (v) {
        if (v != null) onChanged(v);
      },
    );
  }
}

class _OrientationPicker extends StatelessWidget {
  const _OrientationPicker({required this.value, required this.onChanged});

  final CardinalOrientation value;
  final ValueChanged<CardinalOrientation> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<CardinalOrientation>(
      value: value,
      decoration: const InputDecoration(labelText: 'Facing (cardinal direction)'),
      items: CardinalOrientation.values
          .map(
            (o) => DropdownMenuItem(value: o, child: Text(o.displayName)),
          )
          .toList(),
      onChanged: (v) {
        if (v != null) onChanged(v);
      },
    );
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
    final path = imagePath;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Reference photo (optional)',
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: Theme.of(context).colorScheme.outline,
              ),
        ),
        const SizedBox(height: 8),
        if (path != null)
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.file(
                  File(path),
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                      const Icon(Icons.broken_image, size: 40),
                ),
              ),
              const SizedBox(width: 12),
              OutlinedButton.icon(
                icon: const Icon(Icons.delete_outline),
                label: const Text('Remove'),
                onPressed: onRemove,
              ),
            ],
          )
        else
          OutlinedButton.icon(
            icon: const Icon(Icons.camera_alt_outlined),
            label: const Text('Capture reference photo'),
            onPressed: onCapture,
          ),
      ],
    );
  }
}
