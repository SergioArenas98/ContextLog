import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../design/app_tokens.dart';

/// DEEP FIELD: square monospace badge for identifiers (C12, F01, S4, etc.).
///
/// Square, no border radius. Monospace font. ALL-CAPS style data tag.
class StatusBadge extends StatelessWidget {
  const StatusBadge({
    super.key,
    required this.label,
    required this.backgroundColor,
    required this.foregroundColor,
    this.pill = false, // ignored — always square in new design
    this.small = false,
  });

  final String label;
  final Color backgroundColor;
  final Color foregroundColor;
  final bool pill;
  final bool small;

  @override
  Widget build(BuildContext context) {
    final fontSize = small ? 10.0 : 11.0;
    final hPad = small ? AppSpacing.space6 : AppSpacing.space8;
    final vPad = small ? AppSpacing.space2 : AppSpacing.space4;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: vPad),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: AppRadius.xsBorderRadius,
      ),
      child: Text(
        label,
        style: GoogleFonts.jetBrainsMono(
          fontSize: fontSize,
          fontWeight: FontWeight.w700,
          color: foregroundColor,
          letterSpacing: 0.5,
          height: 1.2,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

/// Compact data chip: icon + label, used for counts and metadata.
class DataChip extends StatelessWidget {
  const DataChip({
    super.key,
    required this.label,
    this.icon,
    required this.color,
  });

  final String label;
  final IconData? icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Icon(icon, size: 10, color: color.withAlpha(200)),
          const SizedBox(width: 3),
        ],
        Text(
          label,
          style: GoogleFonts.jetBrainsMono(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: color,
            letterSpacing: 0.3,
          ),
        ),
      ],
    );
  }
}
