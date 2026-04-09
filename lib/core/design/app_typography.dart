import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// PROBE typography system.
///
/// Identifiers / numbers / context codes → JetBrains Mono
///   (technical precision, unambiguous numeric readout)
///
/// UI text / labels / body / forms → Space Grotesk
///   (geometric, cold, modern — replaces the warm DM Sans)
///
/// The shift from DM Sans to Space Grotesk is intentional:
/// - DM Sans is friendly and soft → appropriate for a consumer notebook app
/// - Space Grotesk is geometric and clinical → appropriate for a field instrument
///
/// Typography philosophy: numbers dominate, text is secondary.
/// Large mono numerals are the visual anchor of every screen.
abstract final class AppTypography {
  static TextTheme get textTheme {
    final mono = GoogleFonts.jetBrainsMonoTextTheme(const TextTheme());
    final sans = GoogleFonts.spaceGroteskTextTheme(const TextTheme());

    return TextTheme(
      // ── Display — JetBrains Mono (context numbers, matrix readouts) ───────
      displayLarge: mono.displayLarge?.copyWith(
        fontWeight: FontWeight.w800,
        fontSize: 56,
        letterSpacing: -3,
        height: 1.0,
      ),
      displayMedium: mono.displayMedium?.copyWith(
        fontWeight: FontWeight.w800,
        fontSize: 44,
        letterSpacing: -2,
        height: 1.05,
      ),
      displaySmall: mono.displaySmall?.copyWith(
        fontWeight: FontWeight.w700,
        fontSize: 34,
        letterSpacing: -1.5,
        height: 1.1,
      ),

      // ── Headline — JetBrains Mono (feature IDs, site codes) ──────────────
      headlineLarge: mono.headlineLarge?.copyWith(
        fontWeight: FontWeight.w700,
        fontSize: 28,
        letterSpacing: -1,
        height: 1.15,
      ),
      headlineMedium: mono.headlineMedium?.copyWith(
        fontWeight: FontWeight.w700,
        fontSize: 24,
        letterSpacing: -0.75,
        height: 1.2,
      ),
      headlineSmall: mono.headlineSmall?.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: 20,
        letterSpacing: -0.5,
        height: 1.25,
      ),

      // ── Title — Space Grotesk (section headers, panel titles) ─────────────
      titleLarge: sans.titleLarge?.copyWith(
        fontWeight: FontWeight.w700,
        fontSize: 18,
        letterSpacing: -0.3,
        height: 1.30,
      ),
      titleMedium: sans.titleMedium?.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: 15,
        letterSpacing: -0.1,
        height: 1.40,
      ),
      titleSmall: sans.titleSmall?.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: 13,
        letterSpacing: 0,
        height: 1.35,
      ),

      // ── Body — Space Grotesk ───────────────────────────────────────────────
      bodyLarge: sans.bodyLarge?.copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 15,
        letterSpacing: 0,
        height: 1.55,
      ),
      bodyMedium: sans.bodyMedium?.copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 13,
        letterSpacing: 0,
        height: 1.50,
      ),
      bodySmall: sans.bodySmall?.copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 11,
        letterSpacing: 0.05,
        height: 1.45,
      ),

      // ── Label — JetBrains Mono (type badges, enum tags, counts) ──────────
      labelLarge: mono.labelLarge?.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: 12,
        letterSpacing: 0.3,
        height: 1.35,
      ),
      labelMedium: mono.labelMedium?.copyWith(
        fontWeight: FontWeight.w700,
        fontSize: 10,
        letterSpacing: 0.8,
        height: 1.3,
      ),
      labelSmall: mono.labelSmall?.copyWith(
        fontWeight: FontWeight.w700,
        fontSize: 9,
        letterSpacing: 1.2,
        height: 1.3,
      ),
    );
  }

  static String get monoFontFamily =>
      GoogleFonts.jetBrainsMono().fontFamily ?? 'JetBrains Mono';

  /// UI / form font — Space Grotesk replaces DM Sans.
  static String get sansFontFamily =>
      GoogleFonts.spaceGrotesk().fontFamily ?? 'Space Grotesk';
}
