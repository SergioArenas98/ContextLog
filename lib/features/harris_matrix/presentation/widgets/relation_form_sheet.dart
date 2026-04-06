import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/enums.dart';
import '../../../../core/design/app_tokens.dart';
import '../../../../core/utils/validation_result.dart';
import '../../../../core/widgets/app_sheet_header.dart';
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
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.space24,
          AppSpacing.space16,
          AppSpacing.space24,
          AppSpacing.space24,
        ),
        children: [
          AppSheetHeader(
            title: 'Add Relation',
            onClose: () => Navigator.of(context).pop(),
          ),
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
                    decoration: const InputDecoration(
                      labelText: 'From context *',
                    ),
                    items: items,
                    onChanged: (v) => setState(() => _fromContextId = v),
                  ),
                  const SizedBox(height: AppSpacing.space12),
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
                  const SizedBox(height: AppSpacing.space12),
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
          const SizedBox(height: AppSpacing.space8),
          _RelationHelpText(relationType: _relationType),
          const SizedBox(height: AppSpacing.space24),
          SafeArea(
            top: false,
            child: FilledButton(
              onPressed:
                  (_saving || _fromContextId == null || _toContextId == null)
                      ? null
                      : _save,
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
                    : const Text(key: ValueKey('label'), 'Add Relation'),
              ),
            ),
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
      padding: const EdgeInsets.all(AppSpacing.space12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHigh,
        borderRadius: AppRadius.smBorderRadius,
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_rounded,
            size: 16,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: AppSpacing.space8),
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
