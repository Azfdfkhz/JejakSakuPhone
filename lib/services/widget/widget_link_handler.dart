import 'dart:async';

import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';
import 'package:provider/provider.dart';

import '../../features/attendance/views/attendance_sheet.dart';
import '../../features/chat/view_models/chat_view_model.dart';
import '../../features/chat/views/chat_screen.dart';
import '../../features/documentation/views/documentation_flow.dart';

/// Routes taps coming from the home-screen widget (jejaksaku://<target>).
class WidgetLinkHandler {
  WidgetLinkHandler(this.navigatorKey);

  final GlobalKey<NavigatorState> navigatorKey;
  StreamSubscription<Uri?>? _sub;

  Future<void> start() async {
    try {
      final initial = await HomeWidget.initiallyLaunchedFromHomeWidget();
      if (initial != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) => handle(initial));
      }
      _sub = HomeWidget.widgetClicked.listen(handle);
    } catch (_) {
      // Plugin unavailable (non-Android / tests).
    }
  }

  void dispose() => _sub?.cancel();

  void handle(Uri? uri) {
    final context = navigatorKey.currentContext;
    if (uri == null || context == null || uri.scheme != 'jejaksaku') return;

    switch (uri.host) {
      case 'chat':
        final chat = context.read<ChatViewModel>();
        final cmd = uri.queryParameters['cmd'];
        if (cmd != null) {
          final match = chat.allCommands.where((c) => c.name == cmd);
          if (match.isNotEmpty) chat.executeSlashCommand(match.first);
        }
        ChatScreen.show(context);
      case 'camera':
        startDocumentationCapture(context);
      case 'attendance':
        showAttendanceSheet(context);
      default:
        break; // 'reminder' / 'home': just bring the app forward.
    }
  }
}
