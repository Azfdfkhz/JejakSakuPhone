import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../chat/views/chat_screen.dart';
import '../../companion/companion_view_model.dart';
import '../../reminder/view_models/reminder_view_model.dart';
import 'widget_large.dart';
import 'widget_medium.dart';
import 'widget_small.dart';

/// Screen to preview all widget sizes, wired to the real view models.
/// Documentation/attendance stay disabled until their flows exist.
class WidgetPreviewScreen extends StatelessWidget {
  const WidgetPreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final companion = context.watch<CompanionViewModel>();
    final reminders = context.watch<ReminderViewModel>();
    void openChat() => ChatScreen.show(context);

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(title: const Text('Widget Preview')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Text('Small (1x1)', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            WidgetSmall(companionData: companion.data, onTap: openChat),
            const SizedBox(height: 32),
            const Text('Medium (2x1)', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            WidgetMedium(
              companionData: companion.data,
              reminder: reminders.nearestReminder,
              onChatTap: openChat,
            ),
            const SizedBox(height: 32),
            const Text('Large (2x2)', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            WidgetLarge(
              companionData: companion.data,
              greeting: companion.getGreeting(),
              onChatTap: openChat,
            ),
          ],
        ),
      ),
    );
  }
}
