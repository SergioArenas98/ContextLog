import 'package:flutter/material.dart';

/// PROBE design system — color palette.
///
/// Pure-black instrument substrate + amber-gold readout primary.
/// Philosophy: archaeological fieldwork requires precision instruments,
/// not cozy notebooks. The device is a field station, not a journal.
///
/// Usage in widgets:
///   final colors = AppColors.of(context);  // → _AppPalette adaptive to brightness
///   Container(color: colors.s0)
///
/// Static constants remain for use in ThemeData/ColorScheme definitions
/// (theme.dart) and in design tokens that run before a context is available.
abstract final class AppColors {
  // ── Theme-adaptive accessor ───────────────────────────────────────────────
  /// Returns the correct palette for the current [BuildContext] brightness.
  static _AppPalette of(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark ? _dark : _light;
  }

  // ── Static constants — dark values (kept for ThemeData/ColorScheme) ───────

  // Substrate
  static const Color base = Color(0xFF050505);
  static const Color s0 = Color(0xFF0A0A0A);
  static const Color s1 = Color(0xFF121212);
  static const Color s2 = Color(0xFF1A1A1A);
  static const Color s3 = Color(0xFF222222);
  static const Color s4 = Color(0xFF2A2A2A);

  // Ink
  static const Color t0 = Color(0xFFF0EDE8);
  static const Color t1 = Color(0xFF706C66);
  static const Color t2 = Color(0xFF3A3835);

  // Rules
  static const Color rule = Color(0xFF141414);
  static const Color ruleMid = Color(0xFF1E1E1E);
  static const Color ruleStrong = Color(0xFF282828);

  // Primary — amber gold
  static const Color primary = Color(0xFFC8A040);
  static const Color primaryBright = Color(0xFFE0B850);
  static const Color primaryContainer = Color(0xFF241A00);
  static const Color onPrimary = Color(0xFF050505);
  static const Color onPrimaryContainer = Color(0xFFC8A040);

  // Domain: CUT
  static const Color cut = Color(0xFFA85838);
  static const Color cutSurface = Color(0xFF180800);
  static const Color cutText = Color(0xFFC87858);

  // Domain: FILL
  static const Color fill = Color(0xFF3C7850);
  static const Color fillSurface = Color(0xFF041008);
  static const Color fillText = Color(0xFF68A878);

  // Domain: FIND
  static const Color find = Color(0xFF7050B8);
  static const Color findSurface = Color(0xFF0C0818);
  static const Color findText = Color(0xFF9880D0);

  // Domain: SAMPLE
  static const Color sample = Color(0xFF887040);
  static const Color sampleSurface = Color(0xFF10100A);
  static const Color sampleText = Color(0xFFB0986A);

  // Domain: DOC
  static const Color doc = Color(0xFF3870A0);
  static const Color docSurface = Color(0xFF04101A);
  static const Color docText = Color(0xFF5A90C0);

  // Semantic
  static const Color error = Color(0xFFB83838);
  static const Color errorSurface = Color(0xFF200606);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color onErrorContainer = Color(0xFFD87070);
  static const Color success = Color(0xFF3A8A50);
  static const Color warning = Color(0xFFA07828);

  // ── M3 color role aliases (dark) ──────────────────────────────────────────
  static const Color primaryDark = primary;
  static const Color onPrimaryDark = onPrimary;
  static const Color primaryContainerDark = primaryContainer;
  static const Color onPrimaryContainerDark = onPrimaryContainer;

  static const Color secondaryDark = cut;
  static const Color onSecondaryDark = Color(0xFF050505);
  static const Color secondaryContainerDark = cutSurface;
  static const Color onSecondaryContainerDark = cutText;

  static const Color tertiaryDark = fill;
  static const Color onTertiaryDark = Color(0xFF050505);
  static const Color tertiaryContainerDark = fillSurface;
  static const Color onTertiaryContainerDark = fillText;

  static const Color errorDark = error;
  static const Color onErrorDark = onError;
  static const Color errorContainerDark = errorSurface;
  static const Color onErrorContainerDark = onErrorContainer;

  static const Color surfaceDark = s0;
  static const Color onSurfaceDark = t0;
  static const Color surfaceContainerLowestDark = base;
  static const Color surfaceContainerLowDark = s1;
  static const Color surfaceContainerDark = s2;
  static const Color surfaceContainerHighDark = s3;
  static const Color surfaceContainerHighestDark = s4;
  static const Color onSurfaceVariantDark = t1;
  static const Color outlineDark = ruleStrong;
  static const Color outlineVariantDark = rule;
  static const Color scrimDark = Color(0xFF000000);
  static const Color shadowDark = Color(0xFF000000);
  static const Color inverseSurfaceDark = t0;
  static const Color onInverseSurfaceDark = s0;
  static const Color inversePrimaryDark = Color(0xFF704800);

  // ── M3 color role aliases (light) ─────────────────────────────────────────
  static const Color primaryLight = Color(0xFF7A5400);
  static const Color onPrimaryLight = Color(0xFFFFFFFF);
  static const Color primaryContainerLight = Color(0xFFFFDC8A);
  static const Color onPrimaryContainerLight = Color(0xFF2A1C00);
  static const Color secondaryLight = Color(0xFF703820);
  static const Color onSecondaryLight = Color(0xFFFFFFFF);
  static const Color secondaryContainerLight = Color(0xFFFFD8C8);
  static const Color onSecondaryContainerLight = Color(0xFF2C0E04);
  static const Color tertiaryLight = Color(0xFF1A5E38);
  static const Color onTertiaryLight = Color(0xFFFFFFFF);
  static const Color tertiaryContainerLight = Color(0xFF98E8B4);
  static const Color onTertiaryContainerLight = Color(0xFF001E0C);
  static const Color errorLight = Color(0xFFA01818);
  static const Color onErrorLight = Color(0xFFFFFFFF);
  static const Color errorContainerLight = Color(0xFFFFDEDE);
  static const Color onErrorContainerLight = Color(0xFF3C0606);
  static const Color surfaceLight = Color(0xFFF4F2EE);
  static const Color onSurfaceLight = Color(0xFF141210);
  static const Color outlineVariantLight = Color(0xFFCCC8C0);

  // ── Internal adaptive palettes ────────────────────────────────────────────
  static const _AppPalette _dark = _AppPalette(
    base: base,
    s0: s0, s1: s1, s2: s2, s3: s3, s4: s4,
    t0: t0, t1: t1, t2: t2,
    rule: rule, ruleMid: ruleMid, ruleStrong: ruleStrong,
    primary: primary, primaryBright: primaryBright,
    primaryContainer: primaryContainer,
    onPrimary: onPrimary,
    onPrimaryContainer: onPrimaryContainer,
    error: error, errorSurface: errorSurface, success: success,
    cut: cut, cutSurface: cutSurface, cutText: cutText,
    fill: fill, fillSurface: fillSurface, fillText: fillText,
    find: find, findSurface: findSurface, findText: findText,
    sample: sample, sampleSurface: sampleSurface, sampleText: sampleText,
    doc: doc, docSurface: docSurface, docText: docText,
  );

  static const _AppPalette _light = _AppPalette(
    base: Color(0xFFEBE9E5),
    s0: Color(0xFFF4F2EE),
    s1: Color(0xFFECEAE6),
    s2: Color(0xFFE4E2DE),
    s3: Color(0xFFDCDAD6),
    s4: Color(0xFFD4D2CE),
    t0: Color(0xFF141210),
    t1: Color(0xFF706C66),
    t2: Color(0xFF9C9890),
    rule: Color(0xFFD4D2CE),
    ruleMid: Color(0xFFCCC8C0),
    ruleStrong: Color(0xFFBCB8B0),
    primary: Color(0xFF7A5400),
    primaryBright: Color(0xFF8C6200),
    primaryContainer: Color(0xFFFFDC8A),
    onPrimary: Color(0xFFFFFFFF),
    onPrimaryContainer: Color(0xFF2A1C00),
    error: Color(0xFFA01818),
    errorSurface: Color(0xFFFFDEDE),
    success: Color(0xFF1A5E38),
    cut: Color(0xFF703820),
    cutSurface: Color(0xFFFFD8C8),
    cutText: Color(0xFF2C0E04),
    fill: Color(0xFF1A5E38),
    fillSurface: Color(0xFF98E8B4),
    fillText: Color(0xFF001E0C),
    find: Color(0xFF4830A0),
    findSurface: Color(0xFFE4DCFF),
    findText: Color(0xFF1A0840),
    sample: Color(0xFF5A4018),
    sampleSurface: Color(0xFFEEDFC0),
    sampleText: Color(0xFF241808),
    doc: Color(0xFF1C4E7C),
    docSurface: Color(0xFFCCE4F4),
    docText: Color(0xFF082030),
  );
}

/// Adaptive color palette — one instance per brightness level.
/// Obtained via [AppColors.of(context)].
class _AppPalette {
  const _AppPalette({
    required this.base,
    required this.s0,
    required this.s1,
    required this.s2,
    required this.s3,
    required this.s4,
    required this.t0,
    required this.t1,
    required this.t2,
    required this.rule,
    required this.ruleMid,
    required this.ruleStrong,
    required this.primary,
    required this.primaryBright,
    required this.primaryContainer,
    required this.onPrimary,
    required this.onPrimaryContainer,
    required this.error,
    required this.errorSurface,
    required this.success,
    required this.cut,
    required this.cutSurface,
    required this.cutText,
    required this.fill,
    required this.fillSurface,
    required this.fillText,
    required this.find,
    required this.findSurface,
    required this.findText,
    required this.sample,
    required this.sampleSurface,
    required this.sampleText,
    required this.doc,
    required this.docSurface,
    required this.docText,
  });

  final Color base;
  final Color s0, s1, s2, s3, s4;
  final Color t0, t1, t2;
  final Color rule, ruleMid, ruleStrong;
  final Color primary, primaryBright, primaryContainer, onPrimary, onPrimaryContainer;
  final Color error, errorSurface, success;
  final Color cut, cutSurface, cutText;
  final Color fill, fillSurface, fillText;
  final Color find, findSurface, findText;
  final Color sample, sampleSurface, sampleText;
  final Color doc, docSurface, docText;
}
