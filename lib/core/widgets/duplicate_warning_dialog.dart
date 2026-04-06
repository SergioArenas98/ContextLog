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
      icon: Icon(
        Icons.warning_rounded,
        color: Theme.of(ctx).colorScheme.secondary,
        size: 32,
      ),
      title: const Text('Duplicate Number'),
      content: Text(
        message,
        style: Theme.of(ctx).textTheme.bodyMedium?.copyWith(
              color: Theme.of(ctx).colorScheme.onSurfaceVariant,
            ),
      ),
      actions: [
        OutlinedButton(
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
