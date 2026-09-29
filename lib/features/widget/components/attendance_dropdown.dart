import 'package:flutter/material.dart';

import '../../../core/constants/constants.dart';
import '../../../core/theme/theme.dart';
import '../../../domain/models/models.dart';

/// Dropdown for attendance status. Disabled until a handler is provided.
class AttendanceDropdown extends StatelessWidget {
  const AttendanceDropdown({super.key, this.status, this.onChanged});

  final AttendanceStatus? status;
  final ValueChanged<AttendanceStatus>? onChanged;

  static String label(AttendanceStatus s) => switch (s) {
        AttendanceStatus.masuk => AppStrings.attendanceMasuk,
        AttendanceStatus.izin => AppStrings.attendanceIzin,
        AttendanceStatus.sakit => AppStrings.attendanceSakit,
        AttendanceStatus.libur => AppStrings.attendanceLibur,
      };

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<AttendanceStatus>(
      enabled: onChanged != null,
      onSelected: onChanged,
      itemBuilder: (_) => [
        for (final s in AttendanceStatus.values)
          PopupMenuItem(value: s, child: Text(label(s))),
      ],
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.attendance,
          borderRadius: BorderRadius.circular(AppRadius.attendanceDropdown),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              status == null ? AppStrings.selectStatus : label(status!),
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
            const SizedBox(width: 4),
            const Icon(Icons.arrow_drop_down, color: Colors.white, size: 16),
          ],
        ),
      ),
    );
  }
}
