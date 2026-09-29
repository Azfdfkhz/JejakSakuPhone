import 'package:flutter/material.dart';

import '../../../core/constants/constants.dart';
import '../../../core/theme/theme.dart';
import '../../reminder/view_models/reminder_view_model.dart';

/// Rounded rectangle showing the nearest reminder (or an honest empty state).
class ReminderPill extends StatelessWidget {
  const ReminderPill({super.key, this.reminder, this.onTap});

  final ReminderItem? reminder;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final r = reminder;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.reminder,
          borderRadius: BorderRadius.circular(AppRadius.reminderPill),
          border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
          boxShadow: AppShadows.reminderShadow,
        ),
        child: Row(
          children: [
            const Icon(Icons.notifications, color: Colors.white, size: 16),
            const SizedBox(width: 8),
            Expanded(
              child: r == null
                  ? const Text(
                      AppStrings.noReminder,
                      style: TextStyle(color: Colors.white, fontSize: 12),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Reminder',
                            style: TextStyle(color: Colors.white, fontSize: 11)),
                        Text(
                          r.title,
                          style: const TextStyle(color: Colors.white, fontSize: 12),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
            ),
            const Icon(Icons.chevron_right, color: Colors.white, size: 16),
          ],
        ),
      ),
    );
  }
}
