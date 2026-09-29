import 'dart:async';
import 'dart:convert';

import 'package:home_widget/home_widget.dart';

import '../../domain/models/models.dart';
import '../../features/attendance/view_models/attendance_view_model.dart';
import '../../features/companion/companion_mood.dart';
import '../../features/companion/companion_view_model.dart';
import '../../features/documentation/view_models/documentation_view_model.dart';
import '../../features/reminder/view_models/reminder_view_model.dart';

/// Pushes real app data to the Android home-screen widgets.
///
/// Flutter view models → SharedPreferences (home_widget) → Kotlin providers.
/// Only display strings are shared; no tokens ever reach the widget layer.
class WidgetSyncService {
  WidgetSyncService({
    required this.companion,
    required this.reminders,
    required this.attendance,
    required this.documentation,
  });

  final CompanionViewModel companion;
  final ReminderViewModel reminders;
  final AttendanceViewModel attendance;
  final DocumentationViewModel documentation;

  static const _package = 'com.jejaksaku.jejak_saku_phone';
  static const _providers = [
    'JejakSakuSmallWidget',
    'JejakSakuMediumWidget',
    'JejakSakuLargeWidget',
  ];

  Timer? _debounce;
  Timer? _ticker;

  void start() {
    reminders.addListener(_schedule);
    attendance.addListener(_schedule);
    documentation.addListener(_schedule);
    // Re-evaluate approaching/overdue reminders while the app is alive.
    _ticker = Timer.periodic(
      const Duration(minutes: 1),
      (_) => reminders.checkApproaching(),
    );
    reminders.checkApproaching();
    _schedule();
  }

  void dispose() {
    reminders.removeListener(_schedule);
    attendance.removeListener(_schedule);
    documentation.removeListener(_schedule);
    _ticker?.cancel();
    _debounce?.cancel();
  }

  void _schedule() {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), push);
  }

  Future<void> push() async {
    final upcoming = reminders.upcoming.take(5).toList();
    final nearest = upcoming.firstOrNull;
    final approaching = nearest?.status == ReminderItemStatus.approaching;

    if (approaching) {
      companion.setMood(CompanionMood.reminder, statusText: nearest!.title);
    } else if (companion.data.mood == CompanionMood.reminder) {
      companion.onOnline();
    }
    final mood = approaching ? CompanionMood.reminder : companion.data.mood;

    final pending = attendance.pendingCount + documentation.pendingCount;
    final att = attendance.todayStatus;

    try {
      await HomeWidget.saveWidgetData<String>(
        'reminders_json',
        jsonEncode([
          for (final r in upcoming)
            {'title': r.title, 'at': r.scheduledAt.millisecondsSinceEpoch},
        ]),
      );
      await HomeWidget.saveWidgetData<String>(
        'attendance_label',
        att?.displayName ?? 'Pilih status',
      );
      await HomeWidget.saveWidgetData<String>(
        'companion_emoji',
        mood.placeholderEmoji,
      );
      await HomeWidget.saveWidgetData<String>(
        'greeting',
        companion.getGreeting(),
      );
      await HomeWidget.saveWidgetData<String>(
        'sync_label',
        pending > 0 ? '$pending menunggu sinkron' : 'Tersimpan lokal',
      );
      // No task feature yet: the widget shows its honest empty state.
      await HomeWidget.saveWidgetData<String>('task_summary', 'Belum ada task');

      for (final p in _providers) {
        await HomeWidget.updateWidget(qualifiedAndroidName: '$_package.$p');
      }
    } catch (_) {
      // Not on Android / plugin unavailable (e.g. unit tests): ignore.
    }
  }
}
