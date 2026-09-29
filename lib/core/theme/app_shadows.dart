import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Defines the shadows used in the Jejak Saku application.
class AppShadows {
  const AppShadows._();

  static List<BoxShadow> get widgetShadow => const [
        BoxShadow(
          color: AppColors.shadowColor,
          blurRadius: 12.0,
          offset: Offset(0, 4),
        ),
      ];

  static List<BoxShadow> get reminderShadow => [
        BoxShadow(
          color: AppColors.shadowColor.withOpacity(0.05),
          blurRadius: 8.0,
          offset: const Offset(0, 2),
        ),
      ];

  static List<BoxShadow> get buttonShadow => [
        BoxShadow(
          color: AppColors.shadowColor.withOpacity(0.05),
          blurRadius: 4.0,
          offset: const Offset(0, 1),
        ),
      ];

  static List<BoxShadow> get chatShadow => [
        BoxShadow(
          color: AppColors.shadowColor.withOpacity(0.08),
          blurRadius: 16.0,
          offset: const Offset(0, 4),
        ),
      ];

  static List<BoxShadow> get none => const [];
}
