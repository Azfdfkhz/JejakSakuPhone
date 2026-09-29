import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/theme.dart';
import '../../../domain/models/models.dart';
import 'command_result_card.dart';

/// Renders a single chat message bubble.
///
/// Adapts its appearance based on [MessageSender] and [MessageType]:
/// - User messages: right-aligned, cream/yellow background
/// - Assistant messages: left-aligned, white background with avatar
/// - System messages: centered, gray text
/// - Command messages: styled with icon
/// - Result messages: rendered as [CommandResultCard]
class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.message,
  });

  /// The chat message to render.
  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    if (message.sender == MessageSender.system) {
      return _buildSystemMessage();
    }

    if (message.type == MessageType.result) {
      return CommandResultCard(message: message);
    }

    final isUser = message.sender == MessageSender.user;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      child: Column(
        crossAxisAlignment:
            isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment:
                isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (!isUser) ...[
                CircleAvatar(
                  radius: 14,
                  backgroundColor: AppColors.widgetBackground,
                  child: Icon(
                    Icons.smart_toy_outlined,
                    size: 16,
                    color: AppColors.reminder,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
              ],
              Flexible(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.sm + 2,
                  ),
                  decoration: BoxDecoration(
                    color: isUser ? AppColors.chat : Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(AppRadius.chatBubble),
                      topRight: const Radius.circular(AppRadius.chatBubble),
                      bottomLeft: Radius.circular(
                          isUser ? AppRadius.chatBubble : 4.0),
                      bottomRight: Radius.circular(
                          isUser ? 4.0 : AppRadius.chatBubble),
                    ),
                    border: isUser
                        ? null
                        : Border.all(
                            color: Colors.grey.withValues(alpha: 0.15)),
                    boxShadow: AppShadows.buttonShadow,
                  ),
                  child: _buildMessageContent(isUser),
                ),
              ),
              if (isUser) const SizedBox(width: AppSpacing.md),
            ],
          ),
          const SizedBox(height: 2),
          Padding(
            padding: EdgeInsets.only(
              left: isUser ? 0 : 36.0,
              right: isUser ? AppSpacing.md : 0,
            ),
            child: Text(
              DateFormat('HH:mm').format(message.createdAt),
              style: AppTypography.caption,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageContent(bool isUser) {
    if (message.type == MessageType.command) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.terminal, size: 14, color: AppColors.textPrimary),
          const SizedBox(width: AppSpacing.xs),
          Text(
            message.content,
            style: AppTypography.body.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      );
    }

    return Text(
      message.content,
      style: AppTypography.chatMessage.copyWith(
        color: AppColors.textPrimary,
      ),
    );
  }

  Widget _buildSystemMessage() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
        child: Text(
          message.content,
          style: AppTypography.caption.copyWith(color: AppColors.textSecondary),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
