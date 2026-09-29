import 'package:flutter/material.dart';

import 'floating_chat_view.dart';

/// Wrapper route that hosts the [FloatingChatView] as an overlay.
///
/// Features:
/// - Semi-transparent background (simulates overlay)
/// - FloatingChatView positioned at bottom
/// - Tap outside to close
/// - Animated slide-up entry and slide-down exit
class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  /// Shows the chat screen as a modal overlay.
  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withValues(alpha: 0.3),
      builder: (context) => const ChatScreen(),
    );
  }

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final maxHeight = screenHeight * 0.85;

    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.4,
      maxChildSize: maxHeight / screenHeight,
      builder: (context, scrollController) {
        return FloatingChatView(
          onClose: () => Navigator.of(context).pop(),
        );
      },
    );
  }
}
