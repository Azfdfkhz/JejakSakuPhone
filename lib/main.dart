import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/theme/theme.dart';
import 'data/local/local_store.dart';
import 'data/repositories/repositories.dart';
import 'features/attendance/view_models/attendance_view_model.dart';
import 'features/chat/view_models/chat_view_model.dart';
import 'features/companion/companion_view_model.dart';
import 'features/documentation/view_models/documentation_view_model.dart';
import 'features/home/home_screen.dart';
import 'features/reminder/view_models/reminder_view_model.dart';
import 'services/widget/widget_link_handler.dart';
import 'services/widget/widget_sync_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  runApp(JejakSakuApp(repositories: AppRepositories(LocalStore(prefs))));
}

/// Root application widget for Jejak Saku.
class JejakSakuApp extends StatefulWidget {
  const JejakSakuApp({super.key, required this.repositories});

  final AppRepositories repositories;

  @override
  State<JejakSakuApp> createState() => _JejakSakuAppState();
}

class _JejakSakuAppState extends State<JejakSakuApp> with WidgetsBindingObserver {
  final _navigatorKey = GlobalKey<NavigatorState>();

  late final CompanionViewModel _companion;
  late final ReminderViewModel _reminders;
  late final AttendanceViewModel _attendance;
  late final DocumentationViewModel _documentation;
  late final ChatViewModel _chat;
  late final WidgetSyncService _sync;
  late final WidgetLinkHandler _links;

  @override
  void initState() {
    super.initState();
    final r = widget.repositories;
    _companion = CompanionViewModel();
    _reminders = ReminderViewModel(repository: r.reminders);
    _attendance = AttendanceViewModel(repository: r.attendance);
    _documentation = DocumentationViewModel(repository: r.documentation);
    _chat = ChatViewModel(
      reminders: _reminders,
      attendance: _attendance,
      documentation: _documentation,
      repository: r.chat,
    );
    _sync = WidgetSyncService(
      companion: _companion,
      reminders: _reminders,
      attendance: _attendance,
      documentation: _documentation,
    )..start();
    _links = WidgetLinkHandler(_navigatorKey)..start();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _reminders.checkApproaching();
      _sync.push();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _sync.dispose();
    _links.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: _companion),
        ChangeNotifierProvider.value(value: _reminders),
        ChangeNotifierProvider.value(value: _attendance),
        ChangeNotifierProvider.value(value: _documentation),
        ChangeNotifierProvider.value(value: _chat),
      ],
      child: MaterialApp(
        title: 'Jejak Saku',
        navigatorKey: _navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        home: const HomeScreen(),
      ),
    );
  }
}
