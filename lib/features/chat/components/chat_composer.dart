import 'package:flutter/material.dart';

import '../../../core/theme/theme.dart';

/// Input composer for the floating chat.
///
/// Features:
/// - Text input with 'Ketik pesan...' hint
/// - '+' button for future attachments
/// - Send button (active color when text is present)
/// - Autofocus support
/// - Keyboard-aware safe area
class ChatComposer extends StatefulWidget {
  const ChatComposer({
    super.key,
    required this.onChanged,
    required this.onSubmitted,
    this.autofocus = false,
  });

  /// Called when input text changes.
  final ValueChanged<String> onChanged;

  /// Called when message is submitted.
  final ValueChanged<String> onSubmitted;

  /// Whether to autofocus the input.
  final bool autofocus;

  @override
  State<ChatComposer> createState() => _ChatComposerState();
}

class _ChatComposerState extends State<ChatComposer> {
  late final TextEditingController _controller;
  final FocusNode _focusNode = FocusNode();
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    final hasText = _controller.text.trim().isNotEmpty;
    if (hasText != _hasText) {
      setState(() => _hasText = hasText);
    }
    widget.onChanged(_controller.text);
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _handleSubmitted() {
    final text = _controller.text;
    if (text.trim().isNotEmpty) {
      widget.onSubmitted(text);
      _controller.clear();
      _focusNode.requestFocus();
    }
  }

  /// Clears the input field programmatically.
  void clear() {
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.sm,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Color(0xFFEEEEEE),
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            // Future attachment button
            IconButton(
              icon: const Icon(Icons.add_circle_outline),
              color: AppColors.textSecondary,
              iconSize: 24,
              onPressed: () {
                // Future: attachment handling
              },
            ),
            // Input field
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(AppRadius.chatInput),
                  border: Border.all(
                    color: Colors.grey.withValues(alpha: 0.2),
                  ),
                ),
                child: TextField(
                  controller: _controller,
                  focusNode: _focusNode,
                  autofocus: widget.autofocus,
                  onSubmitted: (_) => _handleSubmitted(),
                  decoration: InputDecoration(
                    hintText: 'Ketik pesan...',
                    hintStyle: AppTypography.body.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg,
                      vertical: 10,
                    ),
                    isDense: true,
                  ),
                  style: AppTypography.chatMessage,
                  textInputAction: TextInputAction.send,
                  maxLines: 4,
                  minLines: 1,
                ),
              ),
            ),
            const SizedBox(width: 4),
            // Send button
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: _hasText ? AppColors.reminder : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(
                  Icons.send_rounded,
                  size: 18,
                  color: _hasText ? Colors.white : AppColors.textSecondary,
                ),
                padding: EdgeInsets.zero,
                onPressed: _handleSubmitted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
