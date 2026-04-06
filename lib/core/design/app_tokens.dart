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
/// STRATUM uses generous modern radii — premium tool feel, not lab instrument.
abstract final class AppRadius {
  static const double none = 0.0;
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 24.0;
  static const double xxl = 32.0;
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

/// Left-accent stripe widths (for context-type indicators).
abstract final class AppBorder {
  static const double accentStripe = 4.0;
  static const double accentStripeLg = 5.0;
  static const double thin = 1.0;
}

/// Shadow / elevation tokens.
abstract final class AppElevation {
  static const List<BoxShadow> none = [];

  static const List<BoxShadow> level1 = [
    BoxShadow(
      color: Color(0x3D000000),
      blurRadius: 6,
      offset: Offset(0, 2),
    ),
  ];

  static const List<BoxShadow> level2 = [
    BoxShadow(
      color: Color(0x55000000),
      blurRadius: 12,
      offset: Offset(0, 4),
    ),
    BoxShadow(
      color: Color(0x28000000),
      blurRadius: 3,
      offset: Offset(0, 1),
    ),
  ];

  static const List<BoxShadow> level3 = [
    BoxShadow(
      color: Color(0x70000000),
      blurRadius: 24,
      offset: Offset(0, 8),
    ),
    BoxShadow(
      color: Color(0x40000000),
      blurRadius: 6,
      offset: Offset(0, 2),
    ),
  ];
}
