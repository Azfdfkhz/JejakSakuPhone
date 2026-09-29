import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/models.dart';
import '../view_models/attendance_view_model.dart';

IconData _icon(AttendanceStatus s) => switch (s) {
      AttendanceStatus.masuk => Icons.login,
      AttendanceStatus.izin => Icons.event_busy,
      AttendanceStatus.sakit => Icons.local_hospital_outlined,
      AttendanceStatus.libur => Icons.beach_access_outlined,
    };

/// Widget → Attendance → Select Status → Save.
Future<void> showAttendanceSheet(BuildContext context) {
  final vm = context.read<AttendanceViewModel>();
  return showModalBottomSheet<void>(
    context: context,
    builder: (ctx) => SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text('Presensi hari ini',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ),
          for (final s in AttendanceStatus.values)
            ListTile(
              leading: Icon(_icon(s)),
              title: Text(s.displayName),
              trailing: vm.todayStatus == s ? const Icon(Icons.check) : null,
              onTap: () async {
                await vm.selectStatus(s);
                if (ctx.mounted) Navigator.pop(ctx);
              },
            ),
        ],
      ),
    ),
  );
}
