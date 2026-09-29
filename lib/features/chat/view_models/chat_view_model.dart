import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../../../core/constants/constants.dart';
import '../../../data/repositories/repositories.dart';
import '../../../domain/models/models.dart';
import '../../attendance/view_models/attendance_view_model.dart';
import '../../documentation/view_models/documentation_view_model.dart';
import '../../reminder/view_models/reminder_view_model.dart';

/// Manages chat state for the floating chat interface.
///
/// - Normal messages are persistent (survive chat close).
/// - Slash command UI is ephemeral (removed on chat close), but the data
///   a command produces must live in its own source, never in the chat UI.
/// - No fake replies: the assistant only speaks when a real source exists.
class ChatViewModel extends ChangeNotifier {
  ChatViewModel({
    ReminderViewModel? reminders,
    AttendanceViewModel? attendance,
    DocumentationViewModel? documentation,
    JsonListRepository<ChatMessage>? repository,
  })  : _reminders = reminders,
        _attendance = attendance,
        _documentation = documentation,
        _repo = repository {
    if (_repo != null) {
      _messages.addAll(_repo.loadAll().where((m) => m.isPersistent));
    }
  }

  final ReminderViewModel? _reminders;
  final AttendanceViewModel? _attendance;
  final DocumentationViewModel? _documentation;
  final JsonListRepository<ChatMessage>? _repo;
  static const _maxStored = 200;
  final List<ChatMessage> _messages = [];
  bool _isSlashMenuVisible = false;
  String _inputText = '';
  List<SlashCommand> _filteredCommands = [];
  final _uuid = const Uuid();
  static const _conversationId = 'default';

  static const List<SlashCommand> _allCommands = [
    SlashCommand(name: '/status', description: 'Lihat status tugas', icon: Icons.analytics_outlined),
    SlashCommand(name: '/jadwal', description: 'Tampilkan jadwal hari ini', icon: Icons.calendar_today),
    SlashCommand(name: '/dokumentasi', description: 'Mulai dokumentasi', icon: Icons.camera_alt_outlined),
    SlashCommand(name: '/reminder', description: 'Lihat reminder aktif', icon: Icons.notifications_outlined),
    SlashCommand(name: '/aktivitas', description: 'Lihat aktivitas terbaru', icon: Icons.history),
    SlashCommand(name: '/task', description: 'Lihat daftar task', icon: Icons.checklist),
    SlashCommand(name: '/belajar', description: 'Mulai sesi belajar', icon: Icons.menu_book_outlined),
    SlashCommand(name: '/catatan', description: 'Buat catatan baru', icon: Icons.note_add_outlined),
  ];

  List<ChatMessage> get persistentMessages =>
      _messages.where((m) => m.isPersistent).toList();

  List<ChatMessage> get allMessages => List.unmodifiable(_messages);

  bool get isSlashMenuVisible => _isSlashMenuVisible;
  List<SlashCommand> get filteredCommands => _filteredCommands;
  String get inputText => _inputText;
  List<SlashCommand> get allCommands => _allCommands;

  /// Opens the chat. History comes from the repository once the data layer
  /// exists; until then an empty chat is shown honestly (no seeded greeting).
  void openChat() {
    notifyListeners();
  }

  /// Closes the chat — clears ephemeral messages, keeps persistent ones.
  void closeChat() {
    _messages.removeWhere((m) => !m.isPersistent);
    _isSlashMenuVisible = false;
    _inputText = '';
    notifyListeners();
  }

  void onInputChanged(String text) {
    _inputText = text;
    if (text.startsWith('/')) {
      _isSlashMenuVisible = true;
      _filteredCommands = _allCommands
          .where((cmd) => cmd.name.toLowerCase().startsWith(text.toLowerCase()))
          .toList();
    } else {
      _isSlashMenuVisible = false;
      _filteredCommands = [];
    }
    notifyListeners();
  }

  /// Sends a normal persistent message. Marked pending until it is synced.
  void sendMessage(String content) {
    if (content.trim().isEmpty) return;

    _messages.add(ChatMessage(
      id: _uuid.v4(),
      conversationId: _conversationId,
      sender: MessageSender.user,
      content: content,
      type: MessageType.user,
      createdAt: DateTime.now(),
      isPersistent: true,
      syncStatus: SyncStatus.pending,
    ));

    _inputText = '';
    _persist();
    notifyListeners();
  }

  void _persist() {
    final p = persistentMessages;
    _repo?.saveAll(p.length > _maxStored ? p.sublist(p.length - _maxStored) : p);
  }

  /// Executes a slash command — creates ephemeral messages.
  void executeSlashCommand(SlashCommand command) {
    _isSlashMenuVisible = false;
    _inputText = '';

    // Ephemeral messages are never synced; `pending` is a neutral value.
    _messages.add(ChatMessage(
      id: _uuid.v4(),
      conversationId: _conversationId,
      sender: MessageSender.user,
      content: command.name,
      type: MessageType.command,
      createdAt: DateTime.now(),
      isPersistent: false,
      syncStatus: SyncStatus.pending,
    ));
    _messages.add(_createCommandResult(command));
    notifyListeners();
  }

  void clearEphemeralMessages() {
    _messages.removeWhere((m) => !m.isPersistent);
    notifyListeners();
  }

  /// Builds a command result from real sources only; otherwise an honest
  /// empty state.
  ChatMessage _createCommandResult(SlashCommand command) {
    String title;
    List<Map<String, String>> items;

    switch (command.name) {
      case '/reminder':
        title = '🔔 Reminder Aktif';
        final active = (_reminders?.reminders ?? const <ReminderItem>[])
            .where((r) =>
                r.status == ReminderItemStatus.scheduled ||
                r.status == ReminderItemStatus.approaching)
            .toList()
          ..sort((a, b) => a.scheduledAt.compareTo(b.scheduledAt));
        items = active
            .map((r) => {
                  'icon': '⏰',
                  'text':
                      '${DateFormat('HH:mm').format(r.scheduledAt)} • ${r.title}',
                })
            .toList();
      case '/status':
        title = '📋 Status Hari Ini';
        final att = _attendance?.todayStatus;
        items = [
          {
            'icon': '🕘',
            'text': att == null
                ? 'Presensi belum diisi'
                : 'Presensi: ${att.displayName}',
          },
          {
            'icon': '📷',
            'text': '${_documentation?.todayCount ?? 0} dokumentasi hari ini',
          },
          {
            'icon': '⏰',
            'text': '${_reminders?.activeReminderCount ?? 0} reminder aktif',
          },
        ];
      case '/jadwal':
        title = '📅 Jadwal Hari Ini';
        final now = DateTime.now();
        items = (_reminders?.upcoming ?? const <ReminderItem>[])
            .where((r) =>
                r.scheduledAt.year == now.year &&
                r.scheduledAt.month == now.month &&
                r.scheduledAt.day == now.day)
            .map((r) => {
                  'icon': '🕐',
                  'text':
                      '${DateFormat('HH:mm').format(r.scheduledAt)} • ${r.title}',
                })
            .toList();
      case '/task':
        title = '✓ Daftar Task';
        items = const [];
      default:
        title = 'ℹ️ ${command.description}';
        items = const [];
    }

    if (items.isEmpty) {
      items = [
        {'icon': '•', 'text': AppStrings.noData},
      ];
    }

    return ChatMessage(
      id: _uuid.v4(),
      conversationId: _conversationId,
      sender: MessageSender.assistant,
      content: title,
      type: MessageType.result,
      createdAt: DateTime.now(),
      isPersistent: false,
      metadata: {'items': items},
      syncStatus: SyncStatus.pending,
    );
  }
}
