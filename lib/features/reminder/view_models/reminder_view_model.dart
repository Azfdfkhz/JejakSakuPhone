import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../../data/repositories/repositories.dart';

/// Reminder lifecycle:
/// Created → Scheduled → Visible in Widget → Approaching → Overdue → Completed/Dismissed
class ReminderViewModel extends ChangeNotifier {
  ReminderViewModel({JsonListRepository<ReminderItem>? repository})
      : _repo = repository {
    if (_repo != null) _reminders = _repo.loadAll();
  }

  final JsonListRepository<ReminderItem>? _repo;
  List<ReminderItem> _reminders = [];

  List<ReminderItem> get reminders => List.unmodifiable(_reminders);

  static bool _isUpcoming(ReminderItem r) =>
      r.status == ReminderItemStatus.scheduled ||
      r.status == ReminderItemStatus.approaching;

  /// Upcoming reminders, earliest first.
  List<ReminderItem> get upcoming =>
      _reminders.where(_isUpcoming).toList()
        ..sort((a, b) => a.scheduledAt.compareTo(b.scheduledAt));

  /// Reminders still needing an action (upcoming or overdue), earliest first.
  List<ReminderItem> get open => _reminders
      .where((r) => _isUpcoming(r) || r.status == ReminderItemStatus.notified)
      .toList()
    ..sort((a, b) => a.scheduledAt.compareTo(b.scheduledAt));

  /// The nearest upcoming reminder (shown on widget).
  ReminderItem? get nearestReminder => upcoming.firstOrNull;

  bool get hasReminders => _reminders.isNotEmpty;

  int get activeReminderCount => upcoming.length;

  void addReminder({
    required String title,
    required DateTime scheduledAt,
    String? description,
  }) {
    _reminders.add(ReminderItem(
      id: const Uuid().v4(),
      title: title,
      description: description,
      scheduledAt: scheduledAt,
      status: ReminderItemStatus.scheduled,
      createdAt: DateTime.now(),
    ));
    _commit();
  }

  void completeReminder(String id) => _setStatus(id, ReminderItemStatus.completed);

  void dismissReminder(String id) => _setStatus(id, ReminderItemStatus.dismissed);

  void _setStatus(String id, ReminderItemStatus status) {
    final i = _reminders.indexWhere((r) => r.id == id);
    if (i < 0) return;
    _reminders[i] = _reminders[i].copyWith(status: status);
    _commit();
  }

  /// Moves reminders to approaching (≤15 min) or overdue (time passed).
  void checkApproaching([DateTime? now]) {
    final t = now ?? DateTime.now();
    var changed = false;
    for (var i = 0; i < _reminders.length; i++) {
      final r = _reminders[i];
      if (!_isUpcoming(r)) continue;
      final diff = r.scheduledAt.difference(t);
      if (diff <= Duration.zero) {
        _reminders[i] = r.copyWith(status: ReminderItemStatus.notified);
        changed = true;
      } else if (diff.inMinutes <= 15 &&
          r.status == ReminderItemStatus.scheduled) {
        _reminders[i] = r.copyWith(status: ReminderItemStatus.approaching);
        changed = true;
      }
    }
    if (changed) _commit();
  }

  void _commit() {
    _repo?.saveAll(_reminders);
    notifyListeners();
  }
}

/// A reminder item for the ViewModel layer.
class ReminderItem {
  const ReminderItem({
    required this.id,
    required this.title,
    this.description,
    required this.scheduledAt,
    required this.status,
    required this.createdAt,
  });

  final String id;
  final String title;
  final String? description;
  final DateTime scheduledAt;
  final ReminderItemStatus status;
  final DateTime createdAt;

  ReminderItem copyWith({
    String? title,
    String? description,
    DateTime? scheduledAt,
    ReminderItemStatus? status,
  }) {
    return ReminderItem(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      scheduledAt: scheduledAt ?? this.scheduledAt,
      status: status ?? this.status,
      createdAt: createdAt,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'description': description,
        'scheduledAt': scheduledAt.toIso8601String(),
        'status': status.name,
        'createdAt': createdAt.toIso8601String(),
      };

  factory ReminderItem.fromMap(Map<String, dynamic> map) => ReminderItem(
        id: map['id'] as String,
        title: map['title'] as String,
        description: map['description'] as String?,
        scheduledAt: DateTime.parse(map['scheduledAt'] as String),
        status: ReminderItemStatus.values.firstWhere(
          (e) => e.name == map['status'],
          orElse: () => ReminderItemStatus.scheduled,
        ),
        createdAt: DateTime.parse(map['createdAt'] as String),
      );
}

enum ReminderItemStatus {
  scheduled,
  approaching,
  notified,
  completed,
  dismissed,
}
