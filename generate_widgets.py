import os

base_path = '/home/azfdfkhz/Desktop/JejakSakuPhone/lib/features/widget'
os.makedirs(f'{base_path}/components', exist_ok=True)
os.makedirs(f'{base_path}/views', exist_ok=True)

files = {
    'components/companion_circle.dart': '''import 'package:flutter/material.dart';
import 'package:jejak_saku_phone/core/theme/theme.dart';
import 'package:jejak_saku_phone/domain/models/models.dart';

/// A circular widget showing the companion character.
class CompanionCircle extends StatelessWidget {
  final dynamic companionData; // Using dynamic temporarily to avoid unknown fields

  const CompanionCircle({
    super.key,
    required this.companionData,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.black12,
            shape: BoxShape.circle,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Icon(Icons.face, color: Colors.white),
              Positioned(
                bottom: 2,
                right: 2,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Online',
          style: TextStyle(fontSize: 10, color: Colors.black87),
        ),
      ],
    );
  }
}
''',
    'components/widget_divider.dart': '''import 'package:flutter/material.dart';

/// Vertical line separator
class WidgetDivider extends StatelessWidget {
  const WidgetDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      color: Colors.white.withOpacity(0.3),
    );
  }
}
''',
    'components/reminder_pill.dart': '''import 'package:flutter/material.dart';
import 'package:jejak_saku_phone/core/theme/theme.dart';
import 'package:jejak_saku_phone/domain/models/models.dart';

/// Rounded rectangle showing nearest reminder
class ReminderPill extends StatelessWidget {
  final dynamic reminder;
  final VoidCallback? onTap;

  const ReminderPill({
    super.key,
    this.reminder,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF6D8A9A), // AppColors.reminder
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            const Icon(Icons.notifications, color: Colors.white, size: 16),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                reminder != null ? 'Reminder Title' : 'Tidak ada reminder',
                style: const TextStyle(color: Colors.white, fontSize: 12),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.white, size: 16),
          ],
        ),
      ),
    );
  }
}
''',
    'components/date_pill.dart': '''import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Rounded rectangle showing current date/day
class DatePill extends StatelessWidget {
  final DateTime date;

  const DatePill({
    super.key,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF919FAC), // AppColors.date
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        DateFormat('dd/MM').format(date),
        style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
      ),
    );
  }
}
''',
    'components/documentation_button.dart': '''import 'package:flutter/material.dart';

/// Action button for documentation
class DocumentationButton extends StatelessWidget {
  final VoidCallback? onTap;

  const DocumentationButton({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFFAC3F42), // AppColors.documentation
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.camera_alt, color: Colors.white, size: 16),
              SizedBox(width: 4),
              Text(
                'Dokumentasi',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
''',
    'components/attendance_dropdown.dart': '''import 'package:flutter/material.dart';

/// Dropdown for attendance status
class AttendanceDropdown extends StatelessWidget {
  final dynamic status;
  final Function(dynamic)? onChanged;

  const AttendanceDropdown({
    super.key,
    this.status,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF6D8A9A), // AppColors.attendance
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Text(
            'Masuk', // Placeholder
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
          SizedBox(width: 4),
          Icon(Icons.arrow_drop_down, color: Colors.white, size: 16),
        ],
      ),
    );
  }
}
''',
    'components/chat_pill.dart': '''import 'package:flutter/material.dart';

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
          color: const Color(0xFFF6E7A8), // AppColors.chat
          borderRadius: BorderRadius.circular(24),
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
''',
    'components/components.dart': '''export 'companion_circle.dart';
export 'widget_divider.dart';
export 'reminder_pill.dart';
export 'date_pill.dart';
export 'documentation_button.dart';
export 'attendance_dropdown.dart';
export 'chat_pill.dart';
''',
    'views/widget_small.dart': '''import 'package:flutter/material.dart';
import '../components/components.dart';

/// Small widget layout (1x1)
class WidgetSmall extends StatelessWidget {
  const WidgetSmall({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          color: const Color(0xFFBECFD8),
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CompanionCircle(companionData: null),
            const SizedBox(height: 8),
            const Text(
              'Jejak Saku',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 4),
            Text(
              '3/5 Task',
              style: TextStyle(color: Colors.black54, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
''',
    'views/widget_medium.dart': '''import 'package:flutter/material.dart';
import '../components/components.dart';

/// Medium widget layout (2x1)
class WidgetMedium extends StatelessWidget {
  const WidgetMedium({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      height: 150,
      decoration: BoxDecoration(
        color: const Color(0xFFBECFD8),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.white.withOpacity(0.5), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          const CompanionCircle(companionData: null),
          const WidgetDivider(),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const ReminderPill(reminder: null),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DatePill(date: DateTime.now()),
                    const DocumentationButton(),
                    const AttendanceDropdown(),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          const ChatPill(),
        ],
      ),
    );
  }
}
''',
    'views/widget_large.dart': '''import 'package:flutter/material.dart';
import '../components/components.dart';

/// Large widget layout (2x2)
class WidgetLarge extends StatelessWidget {
  const WidgetLarge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      height: 320,
      decoration: BoxDecoration(
        color: const Color(0xFFBECFD8),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              const CompanionCircle(companionData: null),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Selamat pagi!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    SizedBox(height: 4),
                    Text('Tersinkronisasi', style: TextStyle(fontSize: 12, color: Colors.green)),
                  ],
                ),
              ),
              const ChatPill(),
            ],
          ),
          const Expanded(
            child: Center(
              child: Text('Next schedule: 10:00 AM\\nStandup Meeting'),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              DocumentationButton(),
              // Mocks for other actions
              AttendanceDropdown(),
              DatePill(date: null), 
            ],
          )
        ],
      ),
    );
  }
}
''',
    'views/widget_preview_screen.dart': '''import 'package:flutter/material.dart';
import 'widget_small.dart';
import 'widget_medium.dart';
import 'widget_large.dart';

/// Screen to preview all widget sizes
class WidgetPreviewScreen extends StatelessWidget {
  const WidgetPreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Widget Preview'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Text('Small (1x1)', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            WidgetSmall(),
            SizedBox(height: 32),
            Text('Medium (2x1)', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            WidgetMedium(),
            SizedBox(height: 32),
            Text('Large (2x2)', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            WidgetLarge(),
          ],
        ),
      ),
    );
  }
}
'''
}

for path, content in files.items():
    full_path = os.path.join(base_path, path)
    with open(full_path, 'w') as f:
        f.write(content)

print("Files generated successfully.")
