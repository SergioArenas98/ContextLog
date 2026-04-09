import 'package:flutter/material.dart';

import 'app_colors.dart';

/// PROBE domain-semantic colors as a ThemeExtension.
///
/// Five distinct domain categories (sample is now separate from doc):
/// - Cut: excavation actions (oxidized copper)
/// - Fill: sediment deposits (deep viridian)
/// - Find: artifact discoveries (deep indigo)
/// - Sample: organic/earth material (raw umber)
/// - Doc: documentation — photos, drawings (steel blue)
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
    required this.sampleAccent,
    required this.sampleSurface,
    required this.sampleText,
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
  final Color sampleAccent;
  final Color sampleSurface;
  final Color sampleText;
  final Color docAccent;
  final Color docSurface;
  final Color docText;
  final Color monoHighlight;
  final Color divider;

  // Convenience: photos and drawings map to doc category
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
    sampleAccent: AppColors.sample,
    sampleSurface: AppColors.sampleSurface,
    sampleText: AppColors.sampleText,
    docAccent: AppColors.doc,
    docSurface: AppColors.docSurface,
    docText: AppColors.docText,
    monoHighlight: AppColors.primary,
    divider: AppColors.rule,
  );

  static const AppThemeExtension light = AppThemeExtension(
    cutAccent: Color(0xFF703820),
    cutSurface: Color(0xFFFFD8C8),
    cutText: Color(0xFF2C0E04),
    fillAccent: Color(0xFF1A5E38),
    fillSurface: Color(0xFF98E8B4),
    fillText: Color(0xFF001E0C),
    findAccent: Color(0xFF4830A0),
    findSurface: Color(0xFFE4DCFF),
    findText: Color(0xFF1A0840),
    sampleAccent: Color(0xFF5A4018),
    sampleSurface: Color(0xFFEEDFC0),
    sampleText: Color(0xFF241808),
    docAccent: Color(0xFF1C4E7C),
    docSurface: Color(0xFFCCE4F4),
    docText: Color(0xFF082030),
    monoHighlight: Color(0xFF7A5400),
    divider: Color(0xFFCCC8C0),
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
    Color? sampleAccent,
    Color? sampleSurface,
    Color? sampleText,
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
      sampleAccent: sampleAccent ?? this.sampleAccent,
      sampleSurface: sampleSurface ?? this.sampleSurface,
      sampleText: sampleText ?? this.sampleText,
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
      sampleAccent: Color.lerp(sampleAccent, other.sampleAccent, t)!,
      sampleSurface: Color.lerp(sampleSurface, other.sampleSurface, t)!,
      sampleText: Color.lerp(sampleText, other.sampleText, t)!,
      docAccent: Color.lerp(docAccent, other.docAccent, t)!,
      docSurface: Color.lerp(docSurface, other.docSurface, t)!,
      docText: Color.lerp(docText, other.docText, t)!,
      monoHighlight: Color.lerp(monoHighlight, other.monoHighlight, t)!,
      divider: Color.lerp(divider, other.divider, t)!,
    );
  }
}
