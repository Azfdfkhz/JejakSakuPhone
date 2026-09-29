import 'sync_status.dart';

/// Status of a task.
enum TaskStatus {
  pending,
  inProgress,
  completed,
  cancelled,
}

/// Represents a task or to-do item.
class Task {
  /// Unique identifier.
  final String id;

  /// Title of the task.
  final String title;

  /// Optional description.
  final String? description;

  /// Current status of the task.
  final TaskStatus status;

  /// Optional due date.
  final DateTime? dueDate;

  /// When the task was completed.
  final DateTime? completedAt;

  /// When the record was created.
  final DateTime createdAt;

  /// When the record was last updated.
  final DateTime updatedAt;

  /// Synchronization status.
  final SyncStatus syncStatus;

  /// Creates a [Task] instance.
  const Task({
    required this.id,
    required this.title,
    this.description,
    required this.status,
    this.dueDate,
    this.completedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.syncStatus,
  });

  /// Creates a copy of this [Task] with modified fields.
  Task copyWith({
    String? id,
    String? title,
    String? description,
    TaskStatus? status,
    DateTime? dueDate,
    DateTime? completedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    SyncStatus? syncStatus,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      dueDate: dueDate ?? this.dueDate,
      completedAt: completedAt ?? this.completedAt,
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
      'status': status.name,
      'dueDate': dueDate?.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'syncStatus': syncStatus.name,
    };
  }

  /// Creates the model from a map.
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'],
      status: TaskStatus.values.firstWhere(
        (e) => e.name == map['status'],
        orElse: () => TaskStatus.pending,
      ),
      dueDate: map['dueDate'] != null ? DateTime.parse(map['dueDate']) : null,
      completedAt: map['completedAt'] != null
          ? DateTime.parse(map['completedAt'])
          : null,
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
    return other is Task &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.status == status &&
        other.dueDate == dueDate &&
        other.completedAt == completedAt &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.syncStatus == syncStatus;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        status.hashCode ^
        dueDate.hashCode ^
        completedAt.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        syncStatus.hashCode;
  }

  @override
  String toString() {
    return 'Task(id: $id, title: $title, description: $description, status: $status, dueDate: $dueDate, completedAt: $completedAt, createdAt: $createdAt, updatedAt: $updatedAt, syncStatus: $syncStatus)';
  }
}
