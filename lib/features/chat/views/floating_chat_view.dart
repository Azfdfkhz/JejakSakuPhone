import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/theme.dart';
import '../view_models/chat_view_model.dart';
import '../components/chat_header.dart';
import '../components/chat_bubble.dart';
import '../components/chat_composer.dart';
import '../components/slash_command_menu.dart';

/// The floating chat overlay interface.
///
/// This is not a full-screen page — it's a temporary conversational
/// workspace that appears over the current context. It supports:
/// - Persistent normal messages
/// - Ephemeral slash command messages
/// - Command autocomplete
/// - Animated entry/exit
class FloatingChatView extends StatefulWidget {
  const FloatingChatView({
    super.key,
    required this.onClose,
  });

  /// Called when the chat should be closed.
  final VoidCallback onClose;

  @override
  State<FloatingChatView> createState() => _FloatingChatViewState();
}

class _FloatingChatViewState extends State<FloatingChatView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Open chat loads persistent history
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ChatViewModel>().openChat();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _handleClose() {
    context.read<ChatViewModel>().closeChat();
    widget.onClose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20),
        ),
        boxShadow: AppShadows.chatShadow,
      ),
      child: Column(
        children: [
          // Drag handle
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 8),
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          // Header
          ChatHeader(onClose: _handleClose),
          // Messages
          Expanded(
            child: Consumer<ChatViewModel>(
              builder: (context, viewModel, _) {
                _scrollToBottom();
                return ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.only(
                    top: AppSpacing.sm,
                    bottom: AppSpacing.sm,
                  ),
                  itemCount: viewModel.allMessages.length,
                  itemBuilder: (context, index) {
                    return ChatBubble(
                      message: viewModel.allMessages[index],
                    );
                  },
                );
              },
            ),
          ),
          // Slash command menu
          Consumer<ChatViewModel>(
            builder: (context, viewModel, _) {
              if (!viewModel.isSlashMenuVisible) {
                return const SizedBox.shrink();
              }
              return SlashCommandMenu(
                commands: viewModel.filteredCommands,
                onCommandSelected: (command) {
                  viewModel.executeSlashCommand(command);
                },
              );
            },
          ),
          // Composer
          ChatComposer(
            autofocus: true,
            onChanged: (text) {
              context.read<ChatViewModel>().onInputChanged(text);
            },
            onSubmitted: (text) {
              final viewModel = context.read<ChatViewModel>();
              if (text.startsWith('/')) {
                // Try to find matching command
                final commands = viewModel.allCommands;
                final match = commands.where(
                  (c) => c.name.toLowerCase() == text.toLowerCase(),
                );
                if (match.isNotEmpty) {
                  viewModel.executeSlashCommand(match.first);
                } else {
                  viewModel.sendMessage(text);
                }
              } else {
                viewModel.sendMessage(text);
              }
            },
          ),
        ],
      ),
    );
  }
}
