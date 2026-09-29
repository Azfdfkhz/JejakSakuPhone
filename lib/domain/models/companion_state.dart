/// Mood states for the companion.
enum CompanionMood {
  idle,
  happy,
  working,
  waiting,
  reminder,
  documentation,
  learning,
  sleeping,
  offline,
  syncing,
  success,
}

/// Extension for [CompanionMood] to provide UI placeholders.
extension CompanionMoodX on CompanionMood {
  /// Returns a placeholder emoji or icon representation.
  String get emoji {
    switch (this) {
      case CompanionMood.idle:
        return '😐';
      case CompanionMood.happy:
        return '😊';
      case CompanionMood.working:
        return '💻';
      case CompanionMood.waiting:
        return '⏳';
      case CompanionMood.reminder:
        return '🔔';
      case CompanionMood.documentation:
        return '📸';
      case CompanionMood.learning:
        return '📚';
      case CompanionMood.sleeping:
        return '💤';
      case CompanionMood.offline:
        return '📡';
      case CompanionMood.syncing:
        return '🔄';
      case CompanionMood.success:
        return '✨';
    }
  }

  /// Returns the display name of the mood.
  String get displayName {
    switch (this) {
      case CompanionMood.idle:
        return 'Idle';
      case CompanionMood.happy:
        return 'Happy';
      case CompanionMood.working:
        return 'Working';
      case CompanionMood.waiting:
        return 'Waiting';
      case CompanionMood.reminder:
        return 'Reminder';
      case CompanionMood.documentation:
        return 'Documentation';
      case CompanionMood.learning:
        return 'Learning';
      case CompanionMood.sleeping:
        return 'Sleeping';
      case CompanionMood.offline:
        return 'Offline';
      case CompanionMood.syncing:
        return 'Syncing';
      case CompanionMood.success:
        return 'Success';
    }
  }
}

/// Represents the state of the companion.
class CompanionData {
  /// The current mood of the companion.
  final CompanionMood mood;

  /// Primary status text (e.g., '3/5 Task', 'Good morning').
  final String? statusText;

  /// Secondary subtitle text.
  final String? subtitleText;

  /// The timestamp of the last update.
  final DateTime lastUpdated;

  /// Creates a [CompanionData] instance.
  const CompanionData({
    required this.mood,
    this.statusText,
    this.subtitleText,
    required this.lastUpdated,
  });

  /// Creates a copy of this [CompanionData] with modified fields.
  CompanionData copyWith({
    CompanionMood? mood,
    String? statusText,
    String? subtitleText,
    DateTime? lastUpdated,
  }) {
    return CompanionData(
      mood: mood ?? this.mood,
      statusText: statusText ?? this.statusText,
      subtitleText: subtitleText ?? this.subtitleText,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  /// Converts the model to a map.
  Map<String, dynamic> toMap() {
    return {
      'mood': mood.name,
      'statusText': statusText,
      'subtitleText': subtitleText,
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }

  /// Creates the model from a map.
  factory CompanionData.fromMap(Map<String, dynamic> map) {
    return CompanionData(
      mood: CompanionMood.values.firstWhere(
        (e) => e.name == map['mood'],
        orElse: () => CompanionMood.idle,
      ),
      statusText: map['statusText'],
      subtitleText: map['subtitleText'],
      lastUpdated: DateTime.parse(map['lastUpdated']),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CompanionData &&
        other.mood == mood &&
        other.statusText == statusText &&
        other.subtitleText == subtitleText &&
        other.lastUpdated == lastUpdated;
  }

  @override
  int get hashCode {
    return mood.hashCode ^
        statusText.hashCode ^
        subtitleText.hashCode ^
        lastUpdated.hashCode;
  }

  @override
  String toString() {
    return 'CompanionData(mood: $mood, statusText: $statusText, subtitleText: $subtitleText, lastUpdated: $lastUpdated)';
  }
}
