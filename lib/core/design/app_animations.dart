import 'package:flutter/material.dart';

/// Duration constants for animations.
abstract final class AppDurations {
  static const Duration fastest = Duration(milliseconds: 120);
  static const Duration fast = Duration(milliseconds: 200);
  static const Duration medium = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 450);
  static const Duration slowest = Duration(milliseconds: 600);
}

/// Curve constants for animations.
abstract final class AppCurves {
  static const Curve standard = Curves.easeInOut;
  static const Curve decelerate = Curves.decelerate;
  static const Curve accelerate = Curves.easeIn;
  static const Curve emphasized = Curves.fastOutSlowIn;
  static const Curve spring = Curves.elasticOut;
}
