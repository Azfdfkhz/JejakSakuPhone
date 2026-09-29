import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../domain/models/models.dart';
import '../attendance/view_models/attendance_view_model.dart';
import '../attendance/views/attendance_sheet.dart';
import '../chat/views/chat_screen.dart';
import '../companion/companion_view_model.dart';
import '../documentation/view_models/documentation_view_model.dart';
import '../documentation/views/documentation_flow.dart';
import '../reminder/view_models/reminder_view_model.dart';
import '../reminder/views/add_reminder_dialog.dart';
import '../widget/views/widget_medium.dart';

/// Main screen: live widget preview, today's summary, reminders.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final companion = context.watch<CompanionViewModel>();
    final reminders = context.watch<ReminderViewModel>();
    final attendance = context.watch<AttendanceViewModel>();
    final docs = context.watch<DocumentationViewModel>();
    final open = reminders.open;
    final now = DateTime.now();

    return Scaffold(
      appBar: AppBar(title: const Text('Jejak Saku')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showAddReminderDialog(context),
        icon: const Icon(Icons.add_alert),
        label: const Text('Reminder'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: FittedBox(
              child: WidgetMedium(
                companionData: companion.data,
                reminder: reminders.nearestReminder,
                attendanceStatus: attendance.todayStatus,
                onDocumentationTap: () => startDocumentationCapture(context),
                onAttendanceChanged: attendance.selectStatus,
                onChatTap: () => ChatScreen.show(context),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: ListTile(
              leading: const Icon(Icons.today),
              title: Text(DateFormat('dd/MM/yyyy').format(now)),
              subtitle: Text(
                'Presensi: ${attendance.todayStatus?.displayName ?? "belum diisi"}'
                '  •  Dokumentasi: ${docs.todayCount}',
              ),
              onTap: () => showAttendanceSheet(context),
            ),
          ),
          const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text('Reminder',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ),
          if (open.isEmpty)
            const Padding(
              padding: EdgeInsets.all(8),
              child: Text('Belum ada reminder. Tekan tombol Reminder untuk menambah.'),
            ),
          for (final r in open)
            Card(
              child: ListTile(
                leading: Icon(
                  r.status == ReminderItemStatus.notified
                      ? Icons.warning_amber
                      : Icons.notifications_outlined,
                ),
                title: Text(r.title),
                subtitle: Text(
                  '${DateFormat('dd/MM HH:mm').format(r.scheduledAt)}'
                  '${r.status == ReminderItemStatus.notified ? "  •  terlewat" : ""}',
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      tooltip: 'Selesai',
                      icon: const Icon(Icons.check),
                      onPressed: () => reminders.completeReminder(r.id),
                    ),
                    IconButton(
                      tooltip: 'Abaikan',
                      icon: const Icon(Icons.close),
                      onPressed: () => reminders.dismissReminder(r.id),
                    ),
                  ],
                ),
              ),
            ),
          const SizedBox(height: 16),
          const Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Pasang widget: tekan lama home screen → Widget → Jejak Saku, '
                'lalu pilih ukuran 1x1, 2x1, atau 2x2.',
              ),
            ),
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}
