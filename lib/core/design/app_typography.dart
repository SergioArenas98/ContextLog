import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// STRATUM typography.
///
/// Identifiers / numbers / matrix labels → JetBrains Mono (technical, code-like)
/// Body / UI prose / forms              → DM Sans (modern, clean, highly legible)
abstract final class AppTypography {
  static TextTheme get textTheme {
    final mono = GoogleFonts.jetBrainsMonoTextTheme(const TextTheme());
    final sans = GoogleFonts.dmSansTextTheme(const TextTheme());

    return TextTheme(
      // ── Display — JetBrains Mono (large data readouts, feature numbers) ───
      displayLarge: mono.displayLarge?.copyWith(
        fontWeight: FontWeight.w800,
        fontSize: 54,
        letterSpacing: -2,
        height: 1.08,
      ),
      displayMedium: mono.displayMedium?.copyWith(
        fontWeight: FontWeight.w700,
        fontSize: 42,
        letterSpacing: -1.5,
        height: 1.12,
      ),
      displaySmall: mono.displaySmall?.copyWith(
        fontWeight: FontWeight.w700,
        fontSize: 34,
        letterSpacing: -1,
        height: 1.18,
      ),

      // ── Headline — JetBrains Mono (context IDs, matrix nodes) ────────────
      headlineLarge: mono.headlineLarge?.copyWith(
        fontWeight: FontWeight.w700,
        fontSize: 30,
        letterSpacing: -0.75,
        height: 1.22,
      ),
      headlineMedium: mono.headlineMedium?.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: 26,
        letterSpacing: -0.5,
        height: 1.27,
      ),
      headlineSmall: mono.headlineSmall?.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: 22,
        letterSpacing: -0.25,
        height: 1.30,
      ),

      // ── Title — DM Sans (section headers, card titles, bottom nav) ────────
      titleLarge: sans.titleLarge?.copyWith(
        fontWeight: FontWeight.w700,
        fontSize: 20,
        letterSpacing: -0.2,
        height: 1.30,
      ),
      titleMedium: sans.titleMedium?.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: 15,
        letterSpacing: -0.1,
        height: 1.45,
      ),
      titleSmall: sans.titleSmall?.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: 13,
        letterSpacing: 0,
        height: 1.40,
      ),

      // ── Body — DM Sans ────────────────────────────────────────────────────
      bodyLarge: sans.bodyLarge?.copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 15,
        letterSpacing: 0,
        height: 1.55,
      ),
      bodyMedium: sans.bodyMedium?.copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 13,
        letterSpacing: 0.05,
        height: 1.50,
      ),
      bodySmall: sans.bodySmall?.copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 11,
        letterSpacing: 0.1,
        height: 1.45,
      ),

      // ── Label — JetBrains Mono (tags, badges, enum labels, counts) ───────
      labelLarge: mono.labelLarge?.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 13,
        letterSpacing: 0.2,
        height: 1.40,
      ),
      labelMedium: mono.labelMedium?.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: 11,
        letterSpacing: 0.5,
        height: 1.35,
      ),
      labelSmall: mono.labelSmall?.copyWith(
        fontWeight: FontWeight.w700,
        fontSize: 10,
        letterSpacing: 0.8,
        height: 1.40,
      ),
    );
  }

  static String get monoFontFamily =>
      GoogleFonts.jetBrainsMono().fontFamily ?? 'JetBrains Mono';

  static String get sansFontFamily =>
      GoogleFonts.dmSans().fontFamily ?? 'DM Sans';
}
