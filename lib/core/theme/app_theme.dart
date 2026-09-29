import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_typography.dart';
import 'app_radius.dart';

/// Creates the ThemeData for the Jejak Saku application.
class AppTheme {
  const AppTheme._();

  /// Returns the light theme data.
  static ThemeData get light => ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: const ColorScheme.light(
          primary: AppColors.textPrimary,
          secondary: AppColors.textSecondary,
          surface: AppColors.surfaceWhite,
          error: AppColors.error,
        ),
        textTheme: TextTheme(
          displayLarge: AppTypography.heading1,
          displayMedium: AppTypography.heading2,
          displaySmall: AppTypography.heading3,
          bodyLarge: AppTypography.body,
          bodyMedium: AppTypography.bodySmall,
          bodySmall: AppTypography.caption,
        ),
        cardTheme: const CardThemeData(
          color: AppColors.surfaceWhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(AppRadius.card)),
          ),
        ),
      );
}
