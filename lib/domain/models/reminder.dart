import 'sync_status.dart';

/// Status of a reminder.
enum ReminderStatus {
  scheduled,
  approaching,
  notified,
  completed,
  dismissed,
}

/// Priority of a reminder.
enum ReminderPriority {
  low,
  medium,
  high,
}

/// Represents a scheduled reminder.
class Reminder {
  /// Unique identifier for the reminder.
  final String id;

  /// The title of the reminder.
  final String title;

  /// Optional description.
  final String? description;

  /// When the reminder is scheduled.
  final DateTime scheduledAt;

  /// The current status of the reminder.
  final ReminderStatus status;

  /// The priority of the reminder.
  final ReminderPriority priority;

  /// Optional associated task ID.
  final String? taskId;

  /// Optional associated activity ID.
  final String? activityId;

  /// When the reminder was created.
  final DateTime createdAt;

  /// When the reminder was last updated.
  final DateTime updatedAt;

  /// Synchronization status.
  final SyncStatus syncStatus;

  /// Creates a [Reminder] instance.
  const Reminder({
    required this.id,
    required this.title,
    this.description,
    required this.scheduledAt,
    required this.status,
    required this.priority,
    this.taskId,
    this.activityId,
    required this.createdAt,
    required this.updatedAt,
    required this.syncStatus,
  });

  /// Creates a copy of this [Reminder] with modified fields.
  Reminder copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? scheduledAt,
    ReminderStatus? status,
    ReminderPriority? priority,
    String? taskId,
    String? activityId,
    DateTime? createdAt,
    DateTime? updatedAt,
    SyncStatus? syncStatus,
  }) {
    return Reminder(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      scheduledAt: scheduledAt ?? this.scheduledAt,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      taskId: taskId ?? this.taskId,
      activityId: activityId ?? this.activityId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncStatus: syncStatus ?? this.syncStatus,
    );
  }

  /// Converts the model to a map.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'scheduledAt': scheduledAt.toIso8601String(),
      'status': status.name,
      'priority': priority.name,
      'taskId': taskId,
      'activityId': activityId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'syncStatus': syncStatus.name,
    };
  }

  /// Creates the model from a map.
  factory Reminder.fromMap(Map<String, dynamic> map) {
    return Reminder(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'],
      scheduledAt: DateTime.parse(map['scheduledAt']),
      status: ReminderStatus.values.firstWhere(
        (e) => e.name == map['status'],
        orElse: () => ReminderStatus.scheduled,
      ),
      priority: ReminderPriority.values.firstWhere(
        (e) => e.name == map['priority'],
        orElse: () => ReminderPriority.low,
      ),
      taskId: map['taskId'],
      activityId: map['activityId'],
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
      syncStatus: SyncStatus.values.firstWhere(
        (e) => e.name == map['syncStatus'],
        orElse: () => SyncStatus.pending,
      ),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Reminder &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.scheduledAt == scheduledAt &&
        other.status == status &&
        other.priority == priority &&
        other.taskId == taskId &&
        other.activityId == activityId &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.syncStatus == syncStatus;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        scheduledAt.hashCode ^
        status.hashCode ^
        priority.hashCode ^
        taskId.hashCode ^
        activityId.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        syncStatus.hashCode;
  }

  @override
  String toString() {
    return 'Reminder(id: $id, title: $title, description: $description, scheduledAt: $scheduledAt, status: $status, priority: $priority, taskId: $taskId, activityId: $activityId, createdAt: $createdAt, updatedAt: $updatedAt, syncStatus: $syncStatus)';
  }
}
