import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../../data/repositories/repositories.dart';
import '../../../domain/models/models.dart';

/// Attendance flow: Widget → Select Status → Local storage (pending sync).
/// One record per day; choosing again the same day replaces the status.
class AttendanceViewModel extends ChangeNotifier {
  AttendanceViewModel({JsonListRepository<Attendance>? repository})
      : _repo = repository {
    if (_repo != null) _records = _repo.loadAll();
  }

  final JsonListRepository<Attendance>? _repo;
  List<Attendance> _records = [];

  bool _isSaving = false;
  bool get isSaving => _isSaving;

  String? _error;
  String? get error => _error;

  static bool _sameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  Attendance? get today {
    final now = DateTime.now();
    for (final r in _records) {
      if (_sameDay(r.date, now)) return r;
    }
    return null;
  }

  AttendanceStatus? get todayStatus => today?.status;

  int get pendingCount =>
      _records.where((r) => r.syncStatus != SyncStatus.synced).length;

  Future<void> selectStatus(AttendanceStatus status) async {
    _isSaving = true;
    _error = null;
    notifyListeners();
    try {
      final now = DateTime.now();
      final i = _records.indexWhere((r) => _sameDay(r.date, now));
      final record = Attendance(
        id: i >= 0 ? _records[i].id : const Uuid().v4(),
        date: now,
        status: status,
        createdAt: i >= 0 ? _records[i].createdAt : now,
        updatedAt: now,
        syncStatus: SyncStatus.pending,
      );
      if (i >= 0) {
        _records[i] = record;
      } else {
        _records.add(record);
      }
      await _repo?.saveAll(_records);
    } catch (e) {
      _error = 'Gagal menyimpan status: $e';
    }
    _isSaving = false;
    notifyListeners();
  }
}
