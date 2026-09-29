import 'package:flutter/material.dart';
import '../../../core/theme/theme.dart';

/// Vertical pill-shaped button for chat
class ChatPill extends StatelessWidget {
  final VoidCallback? onTap;

  const ChatPill({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.chat,
          borderRadius: BorderRadius.circular(AppRadius.chatPill),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.chat_bubble, color: Colors.black87, size: 20),
            SizedBox(height: 8),
            Text(
              'Chat',
              style: TextStyle(color: Colors.black87, fontSize: 10, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
