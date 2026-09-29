import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jejak_saku_phone/data/local/local_store.dart';
import 'package:jejak_saku_phone/data/repositories/repositories.dart';
import 'package:jejak_saku_phone/domain/models/models.dart';
import 'package:jejak_saku_phone/features/attendance/view_models/attendance_view_model.dart';
import 'package:jejak_saku_phone/features/chat/view_models/chat_view_model.dart';
import 'package:jejak_saku_phone/features/reminder/view_models/reminder_view_model.dart';
import 'package:jejak_saku_phone/features/widget/components/reminder_pill.dart';

void main() {
  group('ChatViewModel', () {
    test('opens empty: no seeded greeting or fake reply', () async {
      final vm = ChatViewModel();
      vm.openChat();
      expect(vm.allMessages, isEmpty);

      vm.sendMessage('Hari ini saya memperbaiki navbar.');
      await Future<void>.delayed(const Duration(milliseconds: 700));
      expect(vm.allMessages.length, 1);
      expect(vm.allMessages.single.syncStatus, SyncStatus.pending);
    });

    test('normal messages persist, slash command UI is ephemeral', () {
      final vm = ChatViewModel();
      vm.sendMessage('catatan biasa');
      vm.executeSlashCommand(vm.allCommands.firstWhere((c) => c.name == '/status'));
      expect(vm.allMessages.length, 3);

      vm.closeChat();
      expect(vm.allMessages.length, 1);
      expect(vm.persistentMessages.single.content, 'catatan biasa');
    });

    test('/reminder shows real reminders, or an empty state', () {
      final reminders = ReminderViewModel();
      final vm = ChatViewModel(reminders: reminders);
      final cmd = vm.allCommands.firstWhere((c) => c.name == '/reminder');

      vm.executeSlashCommand(cmd);
      var items = vm.allMessages.last.metadata!['items'] as List;
      expect((items.single as Map)['text'], 'Belum ada data.');

      reminders.addReminder(
        title: 'Dokumentasi Project',
        scheduledAt: DateTime.now().add(const Duration(hours: 1)),
      );
      vm.executeSlashCommand(cmd);
      items = vm.allMessages.last.metadata!['items'] as List;
      expect((items.single as Map)['text'], contains('Dokumentasi Project'));
    });
  });

  group('ReminderViewModel', () {
    test('nearestReminder returns the earliest scheduled one', () {
      final vm = ReminderViewModel();
      expect(vm.nearestReminder, isNull);
      final now = DateTime.now();
      vm.addReminder(title: 'B', scheduledAt: now.add(const Duration(hours: 2)));
      vm.addReminder(title: 'A', scheduledAt: now.add(const Duration(hours: 1)));
      expect(vm.nearestReminder!.title, 'A');
    });
  });

  group('Persistence (offline-first)', () {
    Future<AppRepositories> freshRepos() async {
      SharedPreferences.setMockInitialValues({});
      return AppRepositories(LocalStore(await SharedPreferences.getInstance()));
    }

    test('reminders survive a restart', () async {
      final repos = await freshRepos();
      ReminderViewModel(repository: repos.reminders).addReminder(
        title: 'Dokumentasi Project',
        scheduledAt: DateTime.now().add(const Duration(hours: 2)),
      );
      final reloaded = ReminderViewModel(repository: repos.reminders);
      expect(reloaded.nearestReminder?.title, 'Dokumentasi Project');
    });

    test('overdue reminders leave the widget', () async {
      final vm = ReminderViewModel();
      vm.addReminder(
        title: 'Lewat',
        scheduledAt: DateTime.now().add(const Duration(minutes: 5)),
      );
      vm.checkApproaching(DateTime.now().add(const Duration(minutes: 10)));
      expect(vm.nearestReminder, isNull);
      expect(vm.open.single.status, ReminderItemStatus.notified);
    });

    test('attendance: one record per day, persisted as pending', () async {
      final repos = await freshRepos();
      final vm = AttendanceViewModel(repository: repos.attendance);
      await vm.selectStatus(AttendanceStatus.masuk);
      await vm.selectStatus(AttendanceStatus.izin);
      final reloaded = AttendanceViewModel(repository: repos.attendance);
      expect(reloaded.todayStatus, AttendanceStatus.izin);
      expect(repos.attendance.loadAll().length, 1);
      expect(reloaded.pendingCount, 1);
    });

    test('normal chat messages persist across restart', () async {
      final repos = await freshRepos();
      ChatViewModel(repository: repos.chat).sendMessage('catatan hari ini');
      final reloaded = ChatViewModel(repository: repos.chat);
      expect(reloaded.persistentMessages.single.content, 'catatan hari ini');
    });
  });

  testWidgets('ReminderPill shows honest empty state', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: ReminderPill())),
    );
    expect(find.text('Tidak ada reminder'), findsOneWidget);
  });
}
