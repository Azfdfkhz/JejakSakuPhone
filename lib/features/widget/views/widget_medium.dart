import 'package:flutter/material.dart';

import '../../../core/theme/theme.dart';
import '../../../domain/models/models.dart';
import '../../companion/companion_data.dart';
import '../../reminder/view_models/reminder_view_model.dart';
import '../components/components.dart';

/// Medium widget layout (2x1). All data and actions are injected.
class WidgetMedium extends StatelessWidget {
  const WidgetMedium({
    super.key,
    this.companionData,
    this.reminder,
    this.attendanceStatus,
    this.onReminderTap,
    this.onDocumentationTap,
    this.onAttendanceChanged,
    this.onChatTap,
  });

  final CompanionData? companionData;
  final ReminderItem? reminder;
  final AttendanceStatus? attendanceStatus;
  final VoidCallback? onReminderTap;
  final VoidCallback? onDocumentationTap;
  final ValueChanged<AttendanceStatus>? onAttendanceChanged;
  final VoidCallback? onChatTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      height: 150,
      decoration: BoxDecoration(
        color: AppColors.widgetBackground,
        borderRadius: BorderRadius.circular(AppRadius.widgetContainer),
        border: Border.all(color: AppColors.borderSubtle),
        boxShadow: AppShadows.widgetShadow,
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          CompanionCircle(companionData: companionData),
          const WidgetDivider(),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ReminderPill(reminder: reminder, onTap: onReminderTap),
                const SizedBox(height: 8),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    children: [
                      DatePill(date: DateTime.now()),
                      const SizedBox(width: 6),
                      DocumentationButton(onTap: onDocumentationTap),
                      const SizedBox(width: 6),
                      AttendanceDropdown(
                        status: attendanceStatus,
                        onChanged: onAttendanceChanged,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          ChatPill(onTap: onChatTap),
        ],
      ),
    );
  }
}
