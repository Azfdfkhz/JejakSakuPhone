import '../../domain/models/models.dart';
import '../../features/reminder/view_models/reminder_view_model.dart';
import '../local/local_store.dart';

/// Generic list repository backed by [LocalStore].
class JsonListRepository<T> {
  JsonListRepository(
    this._store,
    this._key, {
    required this.toMap,
    required this.fromMap,
  });

  final LocalStore _store;
  final String _key;
  final Map<String, dynamic> Function(T) toMap;
  final T Function(Map<String, dynamic>) fromMap;

  List<T> loadAll() {
    final out = <T>[];
    for (final m in _store.readList(_key)) {
      try {
        out.add(fromMap(m));
      } catch (_) {
        // Skip corrupted rows instead of crashing the widget flow.
      }
    }
    return out;
  }

  Future<void> saveAll(List<T> items) =>
      _store.writeList(_key, items.map(toMap).toList());
}

/// All repositories of the app.
class AppRepositories {
  AppRepositories(LocalStore store)
      : reminders = JsonListRepository<ReminderItem>(
          store,
          'reminders_v1',
          toMap: (r) => r.toMap(),
          fromMap: ReminderItem.fromMap,
        ),
        attendance = JsonListRepository<Attendance>(
          store,
          'attendance_v1',
          toMap: (a) => a.toMap(),
          fromMap: Attendance.fromMap,
        ),
        documentation = JsonListRepository<Documentation>(
          store,
          'documentation_v1',
          toMap: (d) => d.toMap(),
          fromMap: Documentation.fromMap,
        ),
        chat = JsonListRepository<ChatMessage>(
          store,
          'chat_v1',
          toMap: (m) => m.toMap(),
          fromMap: ChatMessage.fromMap,
        );

  final JsonListRepository<ReminderItem> reminders;
  final JsonListRepository<Attendance> attendance;
  final JsonListRepository<Documentation> documentation;
  final JsonListRepository<ChatMessage> chat;
}
