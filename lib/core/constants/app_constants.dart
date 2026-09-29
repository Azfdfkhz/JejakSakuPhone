/// Core application constants.
class AppConstants {
  const AppConstants._();

  static const String appName = 'Jejak Saku';
  static const List<String> widgetSizes = ['small', 'medium', 'large'];
  static const int maxRemindersShown = 1;
  static const Duration dateRotationInterval = Duration(seconds: 5);
  static const int chatMaxVisibleMessages = 50;
  static const Duration syncRetryDelay = Duration(seconds: 30);
  static const int syncMaxRetries = 3;
}
