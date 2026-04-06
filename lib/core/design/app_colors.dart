import 'package:flutter/material.dart';

/// STRATUM design system — color palette.
///
/// Warm-earth dark substrate, terracotta primary, consolidated domain accents.
/// Philosophy: archaeological fieldwork is warm, tactile, material — not cold lab tech.
abstract final class AppColors {
  // ── Substrate (warm near-black — not blue-black) ──────────────────────────
  static const Color base = Color(0xFF0A0908); // deepest canvas
  static const Color s0 = Color(0xFF0F0E0D); // app scaffold
  static const Color s1 = Color(0xFF1A1917); // primary surface (cards)
  static const Color s2 = Color(0xFF242321); // raised surface (inputs)
  static const Color s3 = Color(0xFF2E2C2A); // elevated (modals, menus)
  static const Color s4 = Color(0xFF3A3836); // highest surface

  // ── Ink (warm text hierarchy) ─────────────────────────────────────────────
  static const Color t0 = Color(0xFFF2EDE8); // primary text
  static const Color t1 = Color(0xFF9E9890); // secondary text
  static const Color t2 = Color(0xFF5E5C58); // muted / placeholder

  // ── Rule (warm subtle dividers) ───────────────────────────────────────────
  static const Color rule = Color(0xFF1E1D1B);
  static const Color ruleMid = Color(0xFF2A2927);
  static const Color ruleStrong = Color(0xFF363533);

  // ── Terracotta — primary action (fire, earth, fieldwork) ──────────────────
  static const Color primary = Color(0xFFCF6A38);
  static const Color primaryBright = Color(0xFFE07D4A);
  static const Color primaryContainer = Color(0xFF391808);
  static const Color onPrimary = Color(0xFF0F0E0D);
  static const Color onPrimaryContainer = Color(0xFFE09870);

  // ── Domain: CUT — terracotta (incision, excavation action) ────────────────
  static const Color cut = Color(0xFFC45A32);
  static const Color cutSurface = Color(0xFF2C1008);
  static const Color cutText = Color(0xFFD8886A);

  // ── Domain: FILL — sage green (sediment deposit, accumulation) ────────────
  static const Color fill = Color(0xFF5A9A6A);
  static const Color fillSurface = Color(0xFF0C2410);
  static const Color fillText = Color(0xFF8EC89E);

  // ── Domain: FIND/ARTIFACT — amethyst (precious discovery) ────────────────
  static const Color find = Color(0xFF8268D0);
  static const Color findSurface = Color(0xFF180F38);
  static const Color findText = Color(0xFFAA98E8);

  // ── Domain: DOCUMENTATION — survey blue (photos, drawings, samples) ───────
  static const Color doc = Color(0xFF4484AE);
  static const Color docSurface = Color(0xFF0A1E2E);
  static const Color docText = Color(0xFF80B4D0);

  // ── Semantic ─────────────────────────────────────────────────────────────
  static const Color error = Color(0xFFC84848);
  static const Color errorSurface = Color(0xFF280808);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color onErrorContainer = Color(0xFFE88888);
  static const Color success = Color(0xFF4A9660);
  static const Color warning = Color(0xFFAA8228);

  // ── M3 color role aliases ─────────────────────────────────────────────────
  static const Color primaryDark = primary;
  static const Color onPrimaryDark = onPrimary;
  static const Color primaryContainerDark = primaryContainer;
  static const Color onPrimaryContainerDark = onPrimaryContainer;

  static const Color secondaryDark = cut;
  static const Color onSecondaryDark = Color(0xFF0F0E0D);
  static const Color secondaryContainerDark = cutSurface;
  static const Color onSecondaryContainerDark = cutText;

  static const Color tertiaryDark = fill;
  static const Color onTertiaryDark = Color(0xFF0F0E0D);
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
  static const Color inversePrimaryDark = Color(0xFF7A3518);

  // Light — minimal support (app is dark-primary)
  static const Color primaryLight = Color(0xFF8B3A14);
  static const Color onPrimaryLight = Color(0xFFFFFFFF);
  static const Color primaryContainerLight = Color(0xFFFFDCCA);
  static const Color onPrimaryContainerLight = Color(0xFF3B0E00);
  static const Color secondaryLight = Color(0xFF7A3820);
  static const Color onSecondaryLight = Color(0xFFFFFFFF);
  static const Color secondaryContainerLight = Color(0xFFFFD7C9);
  static const Color onSecondaryContainerLight = Color(0xFF310F03);
  static const Color tertiaryLight = Color(0xFF2C6B40);
  static const Color onTertiaryLight = Color(0xFFFFFFFF);
  static const Color tertiaryContainerLight = Color(0xFFB0F0C3);
  static const Color onTertiaryContainerLight = Color(0xFF00210D);
  static const Color errorLight = Color(0xFFB91C1C);
  static const Color onErrorLight = Color(0xFFFFFFFF);
  static const Color errorContainerLight = Color(0xFFFFE4E4);
  static const Color onErrorContainerLight = Color(0xFF450A0A);
  static const Color surfaceLight = Color(0xFFF5F1EE);
  static const Color onSurfaceLight = Color(0xFF1A1512);
  static const Color outlineVariantLight = Color(0xFFD0C8C0);
}
