import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/enums.dart';
import '../../../../core/utils/validation_result.dart';
import '../../../../core/widgets/duplicate_warning_dialog.dart';
import '../../../context/domain/models/context_model.dart';
import '../../../context/presentation/providers/context_providers.dart';
import '../providers/harris_providers.dart';

class RelationFormSheet extends ConsumerStatefulWidget {
  const RelationFormSheet({
    super.key,
    required this.featureId,
    required this.onSaved,
  });

  final String featureId;
  final VoidCallback onSaved;

  @override
  ConsumerState<RelationFormSheet> createState() => _RelationFormSheetState();
}

class _RelationFormSheetState extends ConsumerState<RelationFormSheet> {
  String? _fromContextId;
  String? _toContextId;
  HarrisRelationType _relationType = HarrisRelationType.above;
  bool _saving = false;

  @override
  Widget build(BuildContext context) {
    final contextsAsync =
        ref.watch(contextsByFeatureProvider(widget.featureId));

    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(24),
        children: [
          Row(
            children: [
              Text(
                'Add Stratigraphic Relation',
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
          contextsAsync.when(
            loading: () => const CircularProgressIndicator(),
            error: (e, _) => Text('Error: $e'),
            data: (contexts) {
              if (contexts.isEmpty) {
                return const Text('No contexts yet. Add contexts first.');
              }

              final items = contexts
                  .map(
                    (c) => DropdownMenuItem<String>(
                      value: c.id,
                      child: Text(
                        'C${c.contextNumber} — ${c is CutModel ? 'Cut' : 'Fill'}',
                      ),
                    ),
                  )
                  .toList();

              return Column(
                children: [
                  DropdownButtonFormField<String>(
                    value: _fromContextId,
                    decoration:
                        const InputDecoration(labelText: 'From context *'),
                    items: items,
                    onChanged: (v) => setState(() => _fromContextId = v),
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<HarrisRelationType>(
                    value: _relationType,
                    decoration:
                        const InputDecoration(labelText: 'Relation type'),
                    items: HarrisRelationType.values
                        .map(
                          (r) => DropdownMenuItem(
                            value: r,
                            child: Text(r.displayName),
                          ),
                        )
                        .toList(),
                    onChanged: (v) {
                      if (v != null) setState(() => _relationType = v);
                    },
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    value: _toContextId,
                    decoration:
                        const InputDecoration(labelText: 'To context *'),
                    items: items,
                    onChanged: (v) => setState(() => _toContextId = v),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 8),
          _RelationHelpText(relationType: _relationType),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: (_saving ||
                    _fromContextId == null ||
                    _toContextId == null)
                ? null
                : _save,
            child: _saving
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Add Relation'),
          ),
        ],
      ),
    );
  }

  Future<void> _save() async {
    if (_fromContextId == null || _toContextId == null) return;
    setState(() => _saving = true);

    try {
      final validator = ref.read(harrisRelationValidatorProvider);
      final result = await validator.validate(
        fromContextId: _fromContextId!,
        toContextId: _toContextId!,
      );

      if (!mounted) return;

      switch (result) {
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

      await ref.read(harrisRelationRepositoryProvider).create(
            featureId: widget.featureId,
            fromContextId: _fromContextId!,
            toContextId: _toContextId!,
            relationType: _relationType,
          );

      widget.onSaved();
      if (mounted) Navigator.of(context).pop();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
        setState(() => _saving = false);
      }
    }
  }
}

class _RelationHelpText extends StatelessWidget {
  const _RelationHelpText({required this.relationType});

  final HarrisRelationType relationType;

  @override
  Widget build(BuildContext context) {
    final helpText = switch (relationType) {
      HarrisRelationType.above =>
        'From context is stratigraphically above (later than) to context',
      HarrisRelationType.below =>
        'From context is stratigraphically below (earlier than) to context',
      HarrisRelationType.cuts => 'From context (cut) cuts into to context',
      HarrisRelationType.cutBy =>
        'From context is cut by to context',
      HarrisRelationType.equalTo =>
        'Both contexts are interpreted as the same deposit',
      HarrisRelationType.contemporaryWith =>
        'Both contexts are broadly contemporary',
    };

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_outline,
            size: 16,
            color: Theme.of(context).colorScheme.outline,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              helpText,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
