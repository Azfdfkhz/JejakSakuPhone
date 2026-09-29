import 'package:flutter/material.dart';

import '../../../core/theme/theme.dart';
import '../../../domain/models/models.dart';

/// Autocomplete popup menu for slash commands.
///
/// Appears above the chat composer when the user types '/'.
/// Filters commands in realtime as the user types more characters.
class SlashCommandMenu extends StatelessWidget {
  const SlashCommandMenu({
    super.key,
    required this.commands,
    required this.onCommandSelected,
  });

  /// Filtered commands to display.
  final List<SlashCommand> commands;

  /// Called when a command is selected.
  final ValueChanged<SlashCommand> onCommandSelected;

  @override
  Widget build(BuildContext context) {
    if (commands.isEmpty) return const SizedBox.shrink();

    return Container(
      constraints: const BoxConstraints(maxHeight: 280),
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadius.card),
        boxShadow: AppShadows.chatShadow,
        border: Border.all(
          color: Colors.grey.withValues(alpha: 0.1),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.card),
        child: ListView.separated(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
          itemCount: commands.length,
          separatorBuilder: (_, __) => const Divider(height: 1, indent: 48),
          itemBuilder: (context, index) {
            final command = commands[index];
            return _CommandItem(
              command: command,
              onTap: () => onCommandSelected(command),
            );
          },
        ),
      ),
    );
  }
}

class _CommandItem extends StatelessWidget {
  const _CommandItem({
    required this.command,
    required this.onTap,
  });

  final SlashCommand command;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm + 2,
        ),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppColors.widgetBackground.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                command.icon,
                size: 16,
                color: AppColors.reminder,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    command.name,
                    style: AppTypography.body.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    command.description,
                    style: AppTypography.caption.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
