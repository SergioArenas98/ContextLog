import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/validation_result.dart';
import '../../../../core/widgets/duplicate_warning_dialog.dart';
import '../providers/feature_providers.dart';

class FeatureFormScreen extends ConsumerStatefulWidget {
  const FeatureFormScreen({super.key, this.featureId});

  /// Null for create, non-null for edit.
  final String? featureId;

  @override
  ConsumerState<FeatureFormScreen> createState() => _FeatureFormScreenState();
}

class _FeatureFormScreenState extends ConsumerState<FeatureFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _siteCtrl = TextEditingController();
  final _trenchCtrl = TextEditingController();
  final _areaCtrl = TextEditingController();
  final _featureNumberCtrl = TextEditingController();
  final _excavatorCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();
  DateTime _date = DateTime.now();
  bool _loading = false;
  bool _initialized = false;

  bool get _isEditing => widget.featureId != null;

  @override
  void dispose() {
    _siteCtrl.dispose();
    _trenchCtrl.dispose();
    _areaCtrl.dispose();
    _featureNumberCtrl.dispose();
    _excavatorCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isEditing && !_initialized) {
      final featureAsync =
          ref.watch(featureDetailProvider(widget.featureId!));
      return featureAsync.when(
        loading: () =>
            const Scaffold(body: Center(child: CircularProgressIndicator())),
        error: (e, _) => Scaffold(body: Center(child: Text('Error: $e'))),
        data: (feature) {
          if (feature != null && !_initialized) {
            _siteCtrl.text = feature.site;
            _trenchCtrl.text = feature.trench;
            _areaCtrl.text = feature.area;
            _featureNumberCtrl.text = feature.featureNumber;
            _excavatorCtrl.text = feature.excavator;
            _notesCtrl.text = feature.notes ?? '';
            _date = feature.date;
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
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Center(
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
            )
          else
            TextButton(
              onPressed: _submit,
              child: const Text('Save'),
            ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _sectionHeader(context, 'Location'),
            _field(_siteCtrl, 'Site *', hint: 'e.g. Carrowmore'),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: _field(_trenchCtrl, 'Trench *')),
                const SizedBox(width: 12),
                Expanded(child: _field(_areaCtrl, 'Area *')),
              ],
            ),
            const SizedBox(height: 24),
            _sectionHeader(context, 'Identity'),
            _field(_featureNumberCtrl, 'Feature Number *',
                hint: 'e.g. 001', keyboardType: TextInputType.text),
            const SizedBox(height: 12),
            _field(_excavatorCtrl, 'Excavator *', hint: 'e.g. J. Murphy'),
            const SizedBox(height: 24),
            _sectionHeader(context, 'Date'),
            _DatePickerField(
              date: _date,
              onChanged: (d) => setState(() => _date = d),
            ),
            const SizedBox(height: 24),
            _sectionHeader(context, 'Notes'),
            TextFormField(
              controller: _notesCtrl,
              decoration: const InputDecoration(
                labelText: 'General notes',
                alignLabelWithHint: true,
              ),
              maxLines: 4,
              textCapitalization: TextCapitalization.sentences,
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _sectionHeader(BuildContext context, String title) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Text(
          title,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
      );

  Widget _field(
    TextEditingController ctrl,
    String label, {
    String? hint,
    TextInputType keyboardType = TextInputType.text,
  }) =>
      TextFormField(
        controller: ctrl,
        decoration: InputDecoration(labelText: label, hintText: hint),
        keyboardType: keyboardType,
        textCapitalization: TextCapitalization.words,
        validator: (v) {
          if (label.endsWith('*') && (v == null || v.trim().isEmpty)) {
            return 'Required';
          }
          return null;
        },
      );

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);

    try {
      final validator = ref.read(featureValidatorProvider);
      final repo = ref.read(featureRepositoryProvider);

      final ValidationResult result;
      if (_isEditing) {
        result = await validator.validateForUpdate(
          id: widget.featureId!,
          site: _siteCtrl.text.trim(),
          trench: _trenchCtrl.text.trim(),
          area: _areaCtrl.text.trim(),
          featureNumber: _featureNumberCtrl.text.trim(),
          excavator: _excavatorCtrl.text.trim(),
        );
      } else {
        result = await validator.validateForCreate(
          site: _siteCtrl.text.trim(),
          trench: _trenchCtrl.text.trim(),
          area: _areaCtrl.text.trim(),
          featureNumber: _featureNumberCtrl.text.trim(),
          excavator: _excavatorCtrl.text.trim(),
        );
      }

      if (!mounted) return;

      switch (result) {
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

      if (_isEditing) {
        final updated = await repo.update(
          id: widget.featureId!,
          site: _siteCtrl.text.trim(),
          trench: _trenchCtrl.text.trim(),
          area: _areaCtrl.text.trim(),
          featureNumber: _featureNumberCtrl.text.trim(),
          excavator: _excavatorCtrl.text.trim(),
          date: _date,
          notes: _notesCtrl.text.trim().isEmpty ? null : _notesCtrl.text.trim(),
        );
        ref.invalidate(featureDetailProvider(updated.id));
      } else {
        final created = await repo.create(
          site: _siteCtrl.text.trim(),
          trench: _trenchCtrl.text.trim(),
          area: _areaCtrl.text.trim(),
          featureNumber: _featureNumberCtrl.text.trim(),
          excavator: _excavatorCtrl.text.trim(),
          date: _date,
          notes: _notesCtrl.text.trim().isEmpty ? null : _notesCtrl.text.trim(),
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
      _showError('Failed to save: $e');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).colorScheme.error,
      ),
    );
    setState(() => _loading = false);
  }
}

class _DatePickerField extends StatelessWidget {
  const _DatePickerField({required this.date, required this.onChanged});

  final DateTime date;
  final ValueChanged<DateTime> onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(4),
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: date,
          firstDate: DateTime(1900),
          lastDate: DateTime.now().add(const Duration(days: 365)),
        );
        if (picked != null) onChanged(picked);
      },
      child: InputDecorator(
        decoration: const InputDecoration(
          labelText: 'Date',
          suffixIcon: Icon(Icons.calendar_today_outlined),
        ),
        child: Text(
          '${date.day.toString().padLeft(2, '0')}/'
          '${date.month.toString().padLeft(2, '0')}/'
          '${date.year}',
        ),
      ),
    );
  }
}
