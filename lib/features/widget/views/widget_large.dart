import 'package:flutter/material.dart';

import '../../../core/constants/constants.dart';
import '../../../core/theme/theme.dart';
import '../../../domain/models/models.dart';
import '../../companion/companion_data.dart';
import '../components/components.dart';

/// Large widget layout (2x2). All data and actions are injected.
class WidgetLarge extends StatelessWidget {
  const WidgetLarge({
    super.key,
    this.companionData,
    this.greeting,
    this.syncStatus,
    this.nextSchedule,
    this.attendanceStatus,
    this.onDocumentationTap,
    this.onAttendanceChanged,
    this.onChatTap,
  });

  final CompanionData? companionData;

  /// Time-based greeting from the companion; null hides it.
  final String? greeting;

  /// Null hides the sync label instead of claiming "synced".
  final SyncStatus? syncStatus;

  /// e.g. "14:00 • Dokumentasi Project". Null shows an empty state.
  final String? nextSchedule;
  final AttendanceStatus? attendanceStatus;
  final VoidCallback? onDocumentationTap;
  final ValueChanged<AttendanceStatus>? onAttendanceChanged;
  final VoidCallback? onChatTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      height: 320,
      decoration: BoxDecoration(
        color: AppColors.widgetBackground,
        borderRadius: BorderRadius.circular(AppRadius.widgetContainer),
        border: Border.all(color: AppColors.borderSubtle),
        boxShadow: AppShadows.widgetShadow,
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              CompanionCircle(companionData: companionData),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(AppConstants.appName,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    if (greeting != null)
                      Text(greeting!, style: const TextStyle(fontSize: 12)),
                    if (syncStatus != null)
                      Text(syncStatus!.displayName,
                          style: const TextStyle(
                              fontSize: 12, color: AppColors.success)),
                  ],
                ),
              ),
              ChatPill(onTap: onChatTap),
            ],
          ),
          Expanded(
            child: Center(
              child: Text(
                nextSchedule == null
                    ? AppStrings.noSchedule
                    : 'Berikutnya\n$nextSchedule',
                textAlign: TextAlign.center,
              ),
            ),
          ),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              children: [
                DocumentationButton(onTap: onDocumentationTap),
                const SizedBox(width: 8),
                AttendanceDropdown(
                  status: attendanceStatus,
                  onChanged: onAttendanceChanged,
                ),
                const SizedBox(width: 8),
                DatePill(date: DateTime.now()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
