import 'package:flutter/material.dart';

import '../../../core/theme/theme.dart';
import '../../../domain/models/models.dart';

/// Compact result card for slash command output.
///
/// Renders structured data from command metadata as a clean card
/// with icon + text items. Marked as ephemeral (removed on chat close).
class CommandResultCard extends StatelessWidget {
  const CommandResultCard({
    super.key,
    required this.message,
  });

  /// The result message containing structured data.
  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: AppSpacing.md + 28, // Align with assistant messages
        right: AppSpacing.xxl,
        top: AppSpacing.xs,
        bottom: AppSpacing.xs,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(AppRadius.card),
          border: Border.all(
            color: Colors.grey.withValues(alpha: 0.12),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.md,
                AppSpacing.md,
                AppSpacing.md,
                AppSpacing.sm,
              ),
              child: Text(
                message.content,
                style: AppTypography.heading3.copyWith(
                  fontSize: 13,
                ),
              ),
            ),
            // Items
            if (message.metadata != null &&
                message.metadata!['items'] is List) ...[
              const Divider(height: 1),
              ...((message.metadata!['items'] as List)
                  .cast<Map<String, dynamic>>()
                  .map((item) => _ResultItem(
                        icon: item['icon'] as String? ?? '•',
                        text: item['text'] as String? ?? '',
                      ))),
            ],
            const SizedBox(height: AppSpacing.xs),
          ],
        ),
      ),
    );
  }
}

class _ResultItem extends StatelessWidget {
  const _ResultItem({
    required this.icon,
    required this.text,
  });

  final String icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs + 2,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 20,
            child: Text(
              icon,
              style: const TextStyle(fontSize: 12),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              text,
              style: AppTypography.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}
