import 'package:flutter/material.dart';

/// Dialog shown when a duplicate number warning is triggered.
/// Returns true if user chooses to save anyway, false to cancel.
Future<bool> showDuplicateWarningDialog(
  BuildContext context, {
  required String message,
}) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      icon: const Icon(Icons.warning_amber_outlined),
      iconColor: Theme.of(ctx).colorScheme.tertiary,
      title: const Text('Duplicate Number'),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(ctx).pop(false),
          child: const Text('Cancel'),
        ),
        FilledButton.tonal(
          onPressed: () => Navigator.of(ctx).pop(true),
          child: const Text('Save Anyway'),
        ),
      ],
    ),
  );
  return result ?? false;
}
