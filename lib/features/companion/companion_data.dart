import 'companion_mood.dart';

/// Data object representing the companion's current state.
///
/// This is an immutable snapshot — create new instances via [copyWith]
/// when the companion state changes.
class CompanionData {
  const CompanionData({
    this.mood = CompanionMood.idle,
    this.statusText,
    this.subtitleText,
    DateTime? lastUpdated,
  }) : lastUpdated = lastUpdated ?? null;

  /// The companion's current mood/state.
  final CompanionMood mood;

  /// Primary status text displayed near the companion.
  ///
  /// Examples: '3/5 Task', 'Selamat pagi!', '2 reminders'.
  final String? statusText;

  /// Secondary subtitle text.
  ///
  /// Examples: 'Hari ini', 'PKL Day 42'.
  final String? subtitleText;

  /// When this state was last updated.
  final DateTime? lastUpdated;

  /// Creates a copy with the given fields replaced.
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

  /// Default idle companion.
  static const CompanionData idle = CompanionData();

  @override
  String toString() =>
      'CompanionData(mood: $mood, status: $statusText, subtitle: $subtitleText)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CompanionData &&
          runtimeType == other.runtimeType &&
          mood == other.mood &&
          statusText == other.statusText &&
          subtitleText == other.subtitleText;

  @override
  int get hashCode => Object.hash(mood, statusText, subtitleText);
}
