import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../view_models/reminder_view_model.dart';

Future<void> showAddReminderDialog(BuildContext context) async {
  final vm = context.read<ReminderViewModel>();
  final controller = TextEditingController();
  DateTime? when;

  await showDialog<void>(
    context: context,
    builder: (ctx) => StatefulBuilder(
      builder: (ctx, setState) {
        final valid = controller.text.trim().isNotEmpty &&
            when != null &&
            when!.isAfter(DateTime.now());
        return AlertDialog(
          title: const Text('Reminder baru'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: controller,
                onChanged: (_) => setState(() {}),
                decoration: const InputDecoration(labelText: 'Judul'),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                icon: const Icon(Icons.schedule),
                label: Text(when == null
                    ? 'Pilih waktu'
                    : DateFormat('dd/MM HH:mm').format(when!)),
                onPressed: () async {
                  final now = DateTime.now();
                  final d = await showDatePicker(
                    context: ctx,
                    initialDate: now,
                    firstDate: DateTime(now.year, now.month, now.day),
                    lastDate: now.add(const Duration(days: 365)),
                  );
                  if (d == null || !ctx.mounted) return;
                  final t = await showTimePicker(
                    context: ctx,
                    initialTime:
                        TimeOfDay.fromDateTime(now.add(const Duration(hours: 1))),
                  );
                  if (t == null) return;
                  setState(() =>
                      when = DateTime(d.year, d.month, d.day, t.hour, t.minute));
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Batal'),
            ),
            FilledButton(
              onPressed: valid
                  ? () {
                      vm.addReminder(
                        title: controller.text.trim(),
                        scheduledAt: when!,
                      );
                      Navigator.pop(ctx);
                    }
                  : null,
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    ),
  );
  controller.dispose();
}
