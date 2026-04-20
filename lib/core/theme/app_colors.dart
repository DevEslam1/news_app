import 'package:flutter/material.dart';

class AppColors {
  // Primary & Secondary
  static const Color primary = Color(0xFF0A146A);
  static const Color secondary = Color(0xFFE91E63);

  // Neutral / Backgrounds
  static const Color background = Color(0xFF0A0E21);
  static const Color surface = Color(0xFF1D1E33);
  static const Color surfaceVariant = Color(0xFF26294D);
  
  // Tonal Layering (Design System Rule)
  static const Color surfaceTier1 = Color(0xFF111428);
  static const Color surfaceTier2 = Color(0xFF1C1F3E);
  static const Color surfaceTier3 = Color(0xFF2E325A);

  // Text
  static const Color onBackground = Colors.white;
  static const Color onSurface = Colors.white;
  static const Color onSurfaceVariant = Color(0xFFAEB2D1);
  static const Color grey = Color(0xFF8E8E93);

  // Status
  static const Color error = Color(0xFFFF5252);
  static const Color success = Color(0xFF4CAF50);
  
  // Gradients
  static const LinearGradient heroGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Colors.transparent,
      Color(0xCC0A0E21),
      Color(0xFF0A0E21),
    ],
  );
}
