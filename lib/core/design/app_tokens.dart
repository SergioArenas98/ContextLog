import 'package:flutter/material.dart';

/// Spacing scale — 4-point base, 8-point primary grid.
abstract final class AppSpacing {
  static const double space2 = 2.0;
  static const double space4 = 4.0;
  static const double space6 = 6.0;
  static const double space8 = 8.0;
  static const double space12 = 12.0;
  static const double space16 = 16.0;
  static const double space20 = 20.0;
  static const double space24 = 24.0;
  static const double space32 = 32.0;
  static const double space40 = 40.0;
  static const double space48 = 48.0;
  static const double space56 = 56.0;
  static const double space64 = 64.0;
  static const double space80 = 80.0;
}

/// Corner radius tokens.
///
/// PROBE uses hard-edge, precise corners.
/// Consumer apps use generous rounded corners (lg=16, xl=24).
/// Instrument panels use sharp corners with minimal rounding.
/// Max panel radius: 10. Chip radius: 6. Badge: 4.
abstract final class AppRadius {
  static const double none = 0.0;
  static const double xs = 3.0;  // badges, tight chips
  static const double sm = 6.0;  // inputs, buttons, small chips
  static const double md = 10.0; // panels, cards
  static const double lg = 14.0; // modals, dialogs
  static const double xl = 18.0; // bottom sheets
  static const double xxl = 24.0;
  static const double full = 999.0;

  static const BorderRadius noneBorderRadius =
      BorderRadius.all(Radius.circular(none));
  static const BorderRadius xsBorderRadius =
      BorderRadius.all(Radius.circular(xs));
  static const BorderRadius smBorderRadius =
      BorderRadius.all(Radius.circular(sm));
  static const BorderRadius mdBorderRadius =
      BorderRadius.all(Radius.circular(md));
  static const BorderRadius lgBorderRadius =
      BorderRadius.all(Radius.circular(lg));
  static const BorderRadius xlBorderRadius =
      BorderRadius.all(Radius.circular(xl));
  static const BorderRadius xxlBorderRadius =
      BorderRadius.all(Radius.circular(xxl));
  static const BorderRadius fullBorderRadius =
      BorderRadius.all(Radius.circular(full));
}

/// Left-accent stripe widths (context-type indicators).
abstract final class AppBorder {
  static const double accentStripe = 3.0;
  static const double accentStripeLg = 4.0;
  static const double thin = 1.0;
}

/// Shadow tokens — minimal, purposeful.
/// Instrument surfaces rely on color layering, not shadows.
abstract final class AppElevation {
  static const List<BoxShadow> none = [];

  static const List<BoxShadow> level1 = [
    BoxShadow(
      color: Color(0x28000000),
      blurRadius: 4,
      offset: Offset(0, 1),
    ),
  ];

  static const List<BoxShadow> level2 = [
    BoxShadow(
      color: Color(0x44000000),
      blurRadius: 10,
      offset: Offset(0, 3),
    ),
    BoxShadow(
      color: Color(0x1E000000),
      blurRadius: 2,
      offset: Offset(0, 1),
    ),
  ];

  static const List<BoxShadow> level3 = [
    BoxShadow(
      color: Color(0x60000000),
      blurRadius: 20,
      offset: Offset(0, 6),
    ),
    BoxShadow(
      color: Color(0x38000000),
      blurRadius: 4,
      offset: Offset(0, 2),
    ),
  ];
}
