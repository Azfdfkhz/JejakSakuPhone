import 'package:flutter/material.dart';

import '../../../core/constants/constants.dart';
import '../../../core/theme/theme.dart';
import '../../companion/companion_data.dart';
import '../components/components.dart';

/// Small widget layout (1x1).
class WidgetSmall extends StatelessWidget {
  const WidgetSmall({
    super.key,
    this.companionData,
    this.taskSummary,
    this.onTap,
  });

  final CompanionData? companionData;

  /// e.g. "3/5 Task". Null shows an honest empty state.
  final String? taskSummary;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          color: AppColors.widgetBackground,
          borderRadius: BorderRadius.circular(AppRadius.widgetContainer),
          border: Border.all(color: AppColors.borderSubtle),
          boxShadow: AppShadows.widgetShadow,
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CompanionCircle(companionData: companionData),
            const SizedBox(height: 8),
            const Text(AppConstants.appName,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            const SizedBox(height: 4),
            Text(
              taskSummary ?? AppStrings.noTask,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
