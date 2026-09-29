import 'package:flutter/material.dart';

import 'companion_data.dart';
import 'companion_mood.dart';

/// Manages the companion's state and reacts to application events.
///
/// The companion state is contextual — it changes based on:
/// - Current time (greeting)
/// - Task completion (happy)
/// - Reminder proximity (reminder)
/// - Sync status (syncing/success)
/// - Network status (offline)
/// - Documentation events (documentation)
class CompanionViewModel extends ChangeNotifier {
  CompanionData _data = const CompanionData(
    mood: CompanionMood.idle,
    statusText: 'Jejak Saku',
  );

  /// The current companion state.
  CompanionData get data => _data;

  /// Updates the companion mood with optional status text.
  void setMood(CompanionMood mood, {String? statusText, String? subtitleText}) {
    _data = _data.copyWith(
      mood: mood,
      statusText: statusText ?? _data.statusText,
      subtitleText: subtitleText,
      lastUpdated: DateTime.now(),
    );
    notifyListeners();
  }

  /// Updates status text without changing mood.
  void setStatusText(String text) {
    _data = _data.copyWith(
      statusText: text,
      lastUpdated: DateTime.now(),
    );
    notifyListeners();
  }

  /// Sets companion to reflect task progress.
  void updateTaskProgress(int completed, int total) {
    final text = '$completed/$total Task';
    if (completed == total && total > 0) {
      setMood(CompanionMood.happy, statusText: text);
    } else {
      setMood(CompanionMood.idle, statusText: text);
    }
  }

  /// Sets companion to reminder alert state.
  void onReminderApproaching(String reminderTitle) {
    setMood(
      CompanionMood.reminder,
      statusText: reminderTitle,
    );
  }

  /// Sets companion to documentation state.
  void onDocumentationStart() {
    setMood(CompanionMood.documentation, statusText: 'Dokumentasi...');
  }

  /// Sets companion to success after documentation.
  void onDocumentationSuccess() {
    setMood(CompanionMood.success, statusText: 'Tersimpan!');
    // Reset to idle after a delay
    Future.delayed(const Duration(seconds: 3), () {
      if (_data.mood == CompanionMood.success) {
        setMood(CompanionMood.idle, statusText: 'Jejak Saku');
      }
    });
  }

  /// Sets companion to syncing state.
  void onSyncStart() {
    setMood(CompanionMood.syncing, statusText: 'Syncing...');
  }

  /// Sets companion to success after sync.
  void onSyncComplete() {
    setMood(CompanionMood.success, statusText: 'Synced');
    Future.delayed(const Duration(seconds: 2), () {
      if (_data.mood == CompanionMood.success) {
        setMood(CompanionMood.idle, statusText: 'Jejak Saku');
      }
    });
  }

  /// Sets companion to offline state.
  void onOffline() {
    setMood(CompanionMood.offline, statusText: 'Offline');
  }

  /// Sets companion to online/idle state.
  void onOnline() {
    setMood(CompanionMood.idle, statusText: 'Jejak Saku');
  }

  /// Returns a contextual greeting based on current time.
  String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 10) return 'Selamat pagi!';
    if (hour < 15) return 'Selamat siang!';
    if (hour < 18) return 'Selamat sore!';
    return 'Selamat malam!';
  }

  /// Updates companion with time-based greeting.
  void refreshGreeting() {
    _data = _data.copyWith(
      subtitleText: getGreeting(),
      lastUpdated: DateTime.now(),
    );
    notifyListeners();
  }
}
