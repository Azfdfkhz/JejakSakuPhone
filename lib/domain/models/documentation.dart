import 'sync_status.dart';

/// Represents a documentation (image or file).
class Documentation {
  /// Unique identifier.
  final String id;

  /// Associated project ID.
  final String? projectId;

  /// Associated task ID.
  final String? taskId;

  /// Associated activity ID.
  final String? activityId;

  /// Name of the file.
  final String fileName;

  /// Google Drive file ID if synced.
  final String? driveFileId;

  /// Direct URL to the file if available.
  final String? driveUrl;

  /// MIME type of the file.
  final String fileType;

  /// File size in bytes.
  final int fileSize;

  /// Optional description.
  final String? description;

  /// Local path to the file.
  final String localPath;

  /// When the documentation was captured/created.
  final DateTime capturedAt;

  /// When the record was created.
  final DateTime createdAt;

  /// When the record was last updated.
  final DateTime updatedAt;

  /// Synchronization status.
  final SyncStatus syncStatus;

  /// Creates a [Documentation] instance.
  const Documentation({
    required this.id,
    this.projectId,
    this.taskId,
    this.activityId,
    required this.fileName,
    this.driveFileId,
    this.driveUrl,
    required this.fileType,
    required this.fileSize,
    this.description,
    required this.localPath,
    required this.capturedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.syncStatus,
  });

  /// Creates a copy of this [Documentation] with modified fields.
  Documentation copyWith({
    String? id,
    String? projectId,
    String? taskId,
    String? activityId,
    String? fileName,
    String? driveFileId,
    String? driveUrl,
    String? fileType,
    int? fileSize,
    String? description,
    String? localPath,
    DateTime? capturedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    SyncStatus? syncStatus,
  }) {
    return Documentation(
      id: id ?? this.id,
      projectId: projectId ?? this.projectId,
      taskId: taskId ?? this.taskId,
      activityId: activityId ?? this.activityId,
      fileName: fileName ?? this.fileName,
      driveFileId: driveFileId ?? this.driveFileId,
      driveUrl: driveUrl ?? this.driveUrl,
      fileType: fileType ?? this.fileType,
      fileSize: fileSize ?? this.fileSize,
      description: description ?? this.description,
      localPath: localPath ?? this.localPath,
      capturedAt: capturedAt ?? this.capturedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncStatus: syncStatus ?? this.syncStatus,
    );
  }

  /// Converts the model to a map.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'projectId': projectId,
      'taskId': taskId,
      'activityId': activityId,
      'fileName': fileName,
      'driveFileId': driveFileId,
      'driveUrl': driveUrl,
      'fileType': fileType,
      'fileSize': fileSize,
      'description': description,
      'localPath': localPath,
      'capturedAt': capturedAt.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'syncStatus': syncStatus.name,
    };
  }

  /// Creates the model from a map.
  factory Documentation.fromMap(Map<String, dynamic> map) {
    return Documentation(
      id: map['id'] ?? '',
      projectId: map['projectId'],
      taskId: map['taskId'],
      activityId: map['activityId'],
      fileName: map['fileName'] ?? '',
      driveFileId: map['driveFileId'],
      driveUrl: map['driveUrl'],
      fileType: map['fileType'] ?? '',
      fileSize: map['fileSize'] ?? 0,
      description: map['description'],
      localPath: map['localPath'] ?? '',
      capturedAt: DateTime.parse(map['capturedAt']),
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
    return other is Documentation &&
        other.id == id &&
        other.projectId == projectId &&
        other.taskId == taskId &&
        other.activityId == activityId &&
        other.fileName == fileName &&
        other.driveFileId == driveFileId &&
        other.driveUrl == driveUrl &&
        other.fileType == fileType &&
        other.fileSize == fileSize &&
        other.description == description &&
        other.localPath == localPath &&
        other.capturedAt == capturedAt &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.syncStatus == syncStatus;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        projectId.hashCode ^
        taskId.hashCode ^
        activityId.hashCode ^
        fileName.hashCode ^
        driveFileId.hashCode ^
        driveUrl.hashCode ^
        fileType.hashCode ^
        fileSize.hashCode ^
        description.hashCode ^
        localPath.hashCode ^
        capturedAt.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        syncStatus.hashCode;
  }

  @override
  String toString() {
    return 'Documentation(id: $id, projectId: $projectId, taskId: $taskId, activityId: $activityId, fileName: $fileName, driveFileId: $driveFileId, driveUrl: $driveUrl, fileType: $fileType, fileSize: $fileSize, description: $description, localPath: $localPath, capturedAt: $capturedAt, createdAt: $createdAt, updatedAt: $updatedAt, syncStatus: $syncStatus)';
  }
}
