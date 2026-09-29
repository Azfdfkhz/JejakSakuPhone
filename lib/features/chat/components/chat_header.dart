import 'package:flutter/material.dart';

import '../../../core/theme/theme.dart';

/// Header bar for the floating chat interface.
///
/// Shows the app name, a companion mini avatar, and a close button.
class ChatHeader extends StatelessWidget {
  const ChatHeader({
    super.key,
    required this.onClose,
  });

  /// Called when the close button is tapped.
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFF0F0F0),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          // Companion mini avatar
          CircleAvatar(
            radius: 16,
            backgroundColor: AppColors.widgetBackground,
            child: Icon(
              Icons.smart_toy_outlined,
              size: 18,
              color: AppColors.reminder,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          // Title and subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Jejak Saku',
                  style: AppTypography.heading2,
                ),
                Text(
                  'Hari ini',
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          // Close button
          Material(
            color: Colors.transparent,
            shape: const CircleBorder(),
            clipBehavior: Clip.hardEdge,
            child: IconButton(
              icon: const Icon(Icons.close),
              iconSize: 22,
              color: AppColors.textSecondary,
              onPressed: onClose,
            ),
          ),
        ],
      ),
    );
  }
}
