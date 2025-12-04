import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryPurple,
        primary: AppColors.primaryPurple,
        secondary: AppColors.primaryPurpleDark,
      ),
      scaffoldBackgroundColor: AppColors.primaryPurple,
      fontFamily: 'Roboto',
    );
  }
}
