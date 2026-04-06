import 'package:flutter/material.dart';

import 'app_colors.dart';

/// STRATUM domain-semantic colors as a ThemeExtension.
///
/// Consolidated from 6 independent accents to 4 meaningful categories:
/// - Cut: excavation actions (terracotta)
/// - Fill: sediment deposits (sage green)
/// - Find: artifact discoveries (amethyst)
/// - Doc: documentation — photos, drawings, samples (survey blue)
///
/// Access via: `Theme.of(context).extension<AppThemeExtension>()!`
class AppThemeExtension extends ThemeExtension<AppThemeExtension> {
  const AppThemeExtension({
    required this.cutAccent,
    required this.cutSurface,
    required this.cutText,
    required this.fillAccent,
    required this.fillSurface,
    required this.fillText,
    required this.findAccent,
    required this.findSurface,
    required this.findText,
    required this.docAccent,
    required this.docSurface,
    required this.docText,
    required this.monoHighlight,
    required this.divider,
  });

  final Color cutAccent;
  final Color cutSurface;
  final Color cutText;
  final Color fillAccent;
  final Color fillSurface;
  final Color fillText;
  final Color findAccent;
  final Color findSurface;
  final Color findText;
  final Color docAccent;
  final Color docSurface;
  final Color docText;
  final Color monoHighlight;
  final Color divider;

  // Convenience accessors — samples and drawings map to doc category
  Color get sampleAccent => docAccent;
  Color get sampleSurface => docSurface;
  Color get sampleText => docText;
  Color get photoAccent => docAccent;
  Color get photoSurface => docSurface;
  Color get photoText => docText;
  Color get drawingAccent => docAccent;
  Color get drawingSurface => docSurface;
  Color get drawingText => docText;

  static const AppThemeExtension dark = AppThemeExtension(
    cutAccent: AppColors.cut,
    cutSurface: AppColors.cutSurface,
    cutText: AppColors.cutText,
    fillAccent: AppColors.fill,
    fillSurface: AppColors.fillSurface,
    fillText: AppColors.fillText,
    findAccent: AppColors.find,
    findSurface: AppColors.findSurface,
    findText: AppColors.findText,
    docAccent: AppColors.doc,
    docSurface: AppColors.docSurface,
    docText: AppColors.docText,
    monoHighlight: AppColors.primary,
    divider: AppColors.rule,
  );

  static const AppThemeExtension light = AppThemeExtension(
    cutAccent: Color(0xFF8B3A14),
    cutSurface: Color(0xFFFFDCCA),
    cutText: Color(0xFF3B0E00),
    fillAccent: Color(0xFF2C6B40),
    fillSurface: Color(0xFFB0F0C3),
    fillText: Color(0xFF00210D),
    findAccent: Color(0xFF5B3AB8),
    findSurface: Color(0xFFE8E0FF),
    findText: Color(0xFF20104A),
    docAccent: Color(0xFF1D5C8A),
    docSurface: Color(0xFFD0E8F8),
    docText: Color(0xFF082A44),
    monoHighlight: Color(0xFF8B3A14),
    divider: Color(0xFFD0C8C0),
  );

  @override
  AppThemeExtension copyWith({
    Color? cutAccent,
    Color? cutSurface,
    Color? cutText,
    Color? fillAccent,
    Color? fillSurface,
    Color? fillText,
    Color? findAccent,
    Color? findSurface,
    Color? findText,
    Color? docAccent,
    Color? docSurface,
    Color? docText,
    Color? monoHighlight,
    Color? divider,
  }) {
    return AppThemeExtension(
      cutAccent: cutAccent ?? this.cutAccent,
      cutSurface: cutSurface ?? this.cutSurface,
      cutText: cutText ?? this.cutText,
      fillAccent: fillAccent ?? this.fillAccent,
      fillSurface: fillSurface ?? this.fillSurface,
      fillText: fillText ?? this.fillText,
      findAccent: findAccent ?? this.findAccent,
      findSurface: findSurface ?? this.findSurface,
      findText: findText ?? this.findText,
      docAccent: docAccent ?? this.docAccent,
      docSurface: docSurface ?? this.docSurface,
      docText: docText ?? this.docText,
      monoHighlight: monoHighlight ?? this.monoHighlight,
      divider: divider ?? this.divider,
    );
  }

  @override
  AppThemeExtension lerp(AppThemeExtension? other, double t) {
    if (other == null) return this;
    return AppThemeExtension(
      cutAccent: Color.lerp(cutAccent, other.cutAccent, t)!,
      cutSurface: Color.lerp(cutSurface, other.cutSurface, t)!,
      cutText: Color.lerp(cutText, other.cutText, t)!,
      fillAccent: Color.lerp(fillAccent, other.fillAccent, t)!,
      fillSurface: Color.lerp(fillSurface, other.fillSurface, t)!,
      fillText: Color.lerp(fillText, other.fillText, t)!,
      findAccent: Color.lerp(findAccent, other.findAccent, t)!,
      findSurface: Color.lerp(findSurface, other.findSurface, t)!,
      findText: Color.lerp(findText, other.findText, t)!,
      docAccent: Color.lerp(docAccent, other.docAccent, t)!,
      docSurface: Color.lerp(docSurface, other.docSurface, t)!,
      docText: Color.lerp(docText, other.docText, t)!,
      monoHighlight: Color.lerp(monoHighlight, other.monoHighlight, t)!,
      divider: Color.lerp(divider, other.divider, t)!,
    );
  }
}
