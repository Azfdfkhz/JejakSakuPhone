/// Represents the synchronization status of local data.
enum SyncStatus {
  synced,
  pending,
  syncing,
  failed,
  offline,
}

/// Extension for [SyncStatus] to provide UI-friendly properties.
extension SyncStatusX on SyncStatus {
  /// Returns the display name in Indonesian.
  String get displayName {
    switch (this) {
      case SyncStatus.synced:
        return 'Tersinkronisasi';
      case SyncStatus.pending:
        return 'Menunggu';
      case SyncStatus.syncing:
        return 'Menyinkronkan';
      case SyncStatus.failed:
        return 'Gagal';
      case SyncStatus.offline:
        return 'Luring';
    }
  }

  /// Returns a suggested icon name.
  String get iconName {
    switch (this) {
      case SyncStatus.synced:
        return 'check_circle';
      case SyncStatus.pending:
        return 'schedule';
      case SyncStatus.syncing:
        return 'sync';
      case SyncStatus.failed:
        return 'error';
      case SyncStatus.offline:
        return 'cloud_off';
    }
  }

  /// Returns a color reference name.
  String get colorName {
    switch (this) {
      case SyncStatus.synced:
        return 'success';
      case SyncStatus.pending:
        return 'warning';
      case SyncStatus.syncing:
        return 'info';
      case SyncStatus.failed:
        return 'error';
      case SyncStatus.offline:
        return 'disabled';
    }
  }
}
