import 'package:flutter/material.dart';

class AppColors {
  // Primary brand colors
  static const Color primaryPurple = Color(0xFF7C3AED);
  static const Color primaryPurpleDark = Color(0xFF6D28D9);

  // Background gradient colors
  static const Color gradientStart = Color(0xFF7C3AED);
  static const Color gradientEnd = Color(0xFF8B5CF6);

  // Text colors
  static const Color textWhite = Color(0xFFFFFFFF);
  static const Color textBlack = Color(0xFF000000);
  static const Color textGrey = Color(0xFF9CA3AF);
  static const Color textDark = Color(0xFF1F2937);

  // UI colors
  static const Color cardBackground = Color(0xFFF9FAFB);
  static const Color inputBorder = Color(0xFFE5E7EB);
  static const Color buttonDark = Color(0xFF1F2937);

  // Background gradient
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [gradientStart, gradientEnd],
  );
}
