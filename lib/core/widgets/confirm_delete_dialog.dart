import 'package:flutter/material.dart';

import '../design/app_tokens.dart';

/// Reusable confirmation dialog for destructive deletes.
/// Returns true if user confirmed, false if cancelled.
Future<bool> showConfirmDeleteDialog(
  BuildContext context, {
  required String title,
  required String message,
}) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      icon: Icon(
        Icons.delete_rounded,
        color: Theme.of(ctx).colorScheme.error,
        size: 32,
      ),
      title: Text(title),
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
        const SizedBox(width: AppSpacing.space8),
        FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: Theme.of(ctx).colorScheme.error,
            foregroundColor: Theme.of(ctx).colorScheme.onError,
            minimumSize: const Size(100, 48),
            shape: RoundedRectangleBorder(
              borderRadius: AppRadius.smBorderRadius,
            ),
          ),
          onPressed: () => Navigator.of(ctx).pop(true),
          child: const Text('Delete'),
        ),
      ],
    ),
  );
  return result ?? false;
}
