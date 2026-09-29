import 'package:flutter/material.dart';

/// All possible moods/states for the Jejak Saku companion.
///
/// Each mood maps to a visual representation and optional
/// contextual information displayed on the widget.
enum CompanionMood {
  /// Default resting state.
  idle,

  /// Task completed or positive event.
  happy,

  /// Actively processing or syncing work.
  working,

  /// Waiting for user input.
  waiting,

  /// A reminder is approaching.
  reminder,

  /// Documentation capture in progress.
  documentation,

  /// User is in a learning session.
  learning,

  /// Device is sleeping / inactive.
  sleeping,

  /// No internet connection.
  offline,

  /// Data is being synchronized.
  syncing,

  /// Action completed successfully.
  success,
}

/// Extension providing display helpers for [CompanionMood].
extension CompanionMoodX on CompanionMood {
  /// Placeholder emoji for this mood (will be replaced by robot assets).
  String get placeholderEmoji => switch (this) {
        CompanionMood.idle => '🙂',
        CompanionMood.happy => '😊',
        CompanionMood.working => '💪',
        CompanionMood.waiting => '⏳',
        CompanionMood.reminder => '🔔',
        CompanionMood.documentation => '📷',
        CompanionMood.learning => '📚',
        CompanionMood.sleeping => '😴',
        CompanionMood.offline => '📡',
        CompanionMood.syncing => '🔄',
        CompanionMood.success => '✅',
      };

  /// Placeholder icon for this mood.
  IconData get placeholderIcon => switch (this) {
        CompanionMood.idle => Icons.sentiment_satisfied_alt,
        CompanionMood.happy => Icons.sentiment_very_satisfied,
        CompanionMood.working => Icons.engineering,
        CompanionMood.waiting => Icons.hourglass_empty,
        CompanionMood.reminder => Icons.notifications_active,
        CompanionMood.documentation => Icons.camera_alt,
        CompanionMood.learning => Icons.menu_book,
        CompanionMood.sleeping => Icons.bedtime,
        CompanionMood.offline => Icons.cloud_off,
        CompanionMood.syncing => Icons.sync,
        CompanionMood.success => Icons.check_circle,
      };

  /// Human-readable display name.
  String get displayName => switch (this) {
        CompanionMood.idle => 'Idle',
        CompanionMood.happy => 'Happy',
        CompanionMood.working => 'Working',
        CompanionMood.waiting => 'Waiting',
        CompanionMood.reminder => 'Reminder',
        CompanionMood.documentation => 'Documentation',
        CompanionMood.learning => 'Learning',
        CompanionMood.sleeping => 'Sleeping',
        CompanionMood.offline => 'Offline',
        CompanionMood.syncing => 'Syncing',
        CompanionMood.success => 'Success',
      };
}
