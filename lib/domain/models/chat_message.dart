import 'sync_status.dart';

/// The sender of a chat message.
enum MessageSender {
  user,
  assistant,
  system,
}

/// The type of a chat message.
enum MessageType {
  user,
  assistant,
  system,
  command,
  result,
}

/// Represents a chat message in the companion interface.
class ChatMessage {
  /// Unique identifier.
  final String id;

  /// Associated conversation ID.
  final String conversationId;

  /// The sender of the message.
  final MessageSender sender;

  /// The textual content.
  final String content;

  /// The message type.
  final MessageType type;

  /// When the message was created.
  final DateTime createdAt;

  /// Whether the message should persist across sessions.
  final bool isPersistent;

  /// Optional metadata for rich messages.
  final Map<String, dynamic>? metadata;

  /// Synchronization status.
  final SyncStatus syncStatus;

  /// Creates a [ChatMessage] instance.
  const ChatMessage({
    required this.id,
    required this.conversationId,
    required this.sender,
    required this.content,
    required this.type,
    required this.createdAt,
    required this.isPersistent,
    this.metadata,
    required this.syncStatus,
  });

  /// Creates a copy of this [ChatMessage] with modified fields.
  ChatMessage copyWith({
    String? id,
    String? conversationId,
    MessageSender? sender,
    String? content,
    MessageType? type,
    DateTime? createdAt,
    bool? isPersistent,
    Map<String, dynamic>? metadata,
    SyncStatus? syncStatus,
  }) {
    return ChatMessage(
      id: id ?? this.id,
      conversationId: conversationId ?? this.conversationId,
      sender: sender ?? this.sender,
      content: content ?? this.content,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
      isPersistent: isPersistent ?? this.isPersistent,
      metadata: metadata ?? this.metadata,
      syncStatus: syncStatus ?? this.syncStatus,
    );
  }

  /// Converts the model to a map.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'conversationId': conversationId,
      'sender': sender.name,
      'content': content,
      'type': type.name,
      'createdAt': createdAt.toIso8601String(),
      'isPersistent': isPersistent,
      'metadata': metadata,
      'syncStatus': syncStatus.name,
    };
  }

  /// Creates the model from a map.
  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      id: map['id'] ?? '',
      conversationId: map['conversationId'] ?? '',
      sender: MessageSender.values.firstWhere(
        (e) => e.name == map['sender'],
        orElse: () => MessageSender.system,
      ),
      content: map['content'] ?? '',
      type: MessageType.values.firstWhere(
        (e) => e.name == map['type'],
        orElse: () => MessageType.system,
      ),
      createdAt: DateTime.parse(map['createdAt']),
      isPersistent: map['isPersistent'] ?? false,
      metadata: map['metadata'],
      syncStatus: SyncStatus.values.firstWhere(
        (e) => e.name == map['syncStatus'],
        orElse: () => SyncStatus.pending,
      ),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ChatMessage &&
        other.id == id &&
        other.conversationId == conversationId &&
        other.sender == sender &&
        other.content == content &&
        other.type == type &&
        other.createdAt == createdAt &&
        other.isPersistent == isPersistent &&
        _mapEquals(other.metadata, metadata) &&
        other.syncStatus == syncStatus;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        conversationId.hashCode ^
        sender.hashCode ^
        content.hashCode ^
        type.hashCode ^
        createdAt.hashCode ^
        isPersistent.hashCode ^
        metadata.hashCode ^
        syncStatus.hashCode;
  }

  bool _mapEquals(Map<String, dynamic>? a, Map<String, dynamic>? b) {
    if (a == null && b == null) return true;
    if (a == null || b == null) return false;
    if (a.length != b.length) return false;
    for (final key in a.keys) {
      if (a[key] != b[key]) return false;
    }
    return true;
  }

  @override
  String toString() {
    return 'ChatMessage(id: $id, conversationId: $conversationId, sender: $sender, content: $content, type: $type, createdAt: $createdAt, isPersistent: $isPersistent, metadata: $metadata, syncStatus: $syncStatus)';
  }
}
