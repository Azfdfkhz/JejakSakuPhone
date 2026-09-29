import 'sync_status.dart';

/// Status of an attendance record.
enum AttendanceStatus {
  masuk,
  izin,
  sakit,
  libur,
}

/// Extension for [AttendanceStatus] to provide display names.
extension AttendanceStatusX on AttendanceStatus {
  /// Returns the display name in Indonesian.
  String get displayName {
    switch (this) {
      case AttendanceStatus.masuk:
        return 'Masuk';
      case AttendanceStatus.izin:
        return 'Izin';
      case AttendanceStatus.sakit:
        return 'Sakit';
      case AttendanceStatus.libur:
        return 'Libur';
    }
  }
}

/// Represents an attendance record.
class Attendance {
  /// Unique identifier for the attendance.
  final String id;

  /// The date of the attendance.
  final DateTime date;

  /// The status of the attendance.
  final AttendanceStatus status;

  /// Optional note for the attendance.
  final String? note;

  /// When the attendance was created.
  final DateTime createdAt;

  /// When the attendance was last updated.
  final DateTime updatedAt;

  /// Synchronization status of the attendance.
  final SyncStatus syncStatus;

  /// Creates an [Attendance] instance.
  const Attendance({
    required this.id,
    required this.date,
    required this.status,
    this.note,
    required this.createdAt,
    required this.updatedAt,
    required this.syncStatus,
  });

  /// Creates a copy of this [Attendance] with modified fields.
  Attendance copyWith({
    String? id,
    DateTime? date,
    AttendanceStatus? status,
    String? note,
    DateTime? createdAt,
    DateTime? updatedAt,
    SyncStatus? syncStatus,
  }) {
    return Attendance(
      id: id ?? this.id,
      date: date ?? this.date,
      status: status ?? this.status,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncStatus: syncStatus ?? this.syncStatus,
    );
  }

  /// Converts the model to a map.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'status': status.name,
      'note': note,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'syncStatus': syncStatus.name,
    };
  }

  /// Creates the model from a map.
  factory Attendance.fromMap(Map<String, dynamic> map) {
    return Attendance(
      id: map['id'] ?? '',
      date: DateTime.parse(map['date']),
      status: AttendanceStatus.values.firstWhere(
        (e) => e.name == map['status'],
        orElse: () => AttendanceStatus.masuk,
      ),
      note: map['note'],
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
    return other is Attendance &&
        other.id == id &&
        other.date == date &&
        other.status == status &&
        other.note == note &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.syncStatus == syncStatus;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        date.hashCode ^
        status.hashCode ^
        note.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        syncStatus.hashCode;
  }

  @override
  String toString() {
    return 'Attendance(id: $id, date: $date, status: $status, note: $note, createdAt: $createdAt, updatedAt: $updatedAt, syncStatus: $syncStatus)';
  }
}
