import 'package:flutter/material.dart';

/// Friendzy-inspired design system color palette
class AppColors {
  AppColors._();

  // Primary brand palette - Friendzy vibrant berry-pink & gradient tones
  static const Color primary = Color(0xFFE94057);
  static const Color primaryLight = Color(0xFFFF6584);
  static const Color primaryDark = Color(0xFFC2185B);

  // Deep plum/eggplant for high-contrast buttons, dark elements, and titles
  static const Color deepPlum = Color(0xFF2D1437);
  static const Color darkAccent = Color(0xFF381544);

  // Secondary & Accents
  static const Color accent = Color(0xFFF27121);
  static const Color accentLight = Color(0xFFFFF0F3);

  // Backgrounds & Surfaces
  static const Color background = Color(0xFFFAF8FB);
  static const Color surface = Colors.white;
  static const Color surfaceVariant = Color(0xFFF5EFF6);

  // Connection badge & mutual connection highlight (Friendzy soft rose)
  static const Color connectionHighlightBg = Color(0xFFFFF0F5);
  static const Color connectionHighlightBorder = Color(0xFFFDCAD7);
  static const Color connectionHighlightText = Color(0xFFE94057);

  // Neutral text hierarchy
  static const Color textPrimary = Color(0xFF1D0E25);
  static const Color textSecondary = Color(0xFF6E6377);
  static const Color textTertiary = Color(0xFFA59CAE);

  // States & Dividers
  static const Color error = Color(0xFFE53935);
  static const Color errorContainer = Color(0xFFFFEBEE);
  static const Color success = Color(0xFF2E7D32);
  static const Color divider = Color(0xFFF0EAF2);
  static const Color border = Color(0xFFEDE5EE);
}
