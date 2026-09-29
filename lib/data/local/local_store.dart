import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

/// Tiny offline-first JSON store on top of SharedPreferences.
///
/// Stand-in until Drift is generated (needs build_runner); repositories talk
/// to this class only, so swapping the engine will not touch view models.
class LocalStore {
  LocalStore(this._prefs);

  final SharedPreferences _prefs;

  List<Map<String, dynamic>> readList(String key) {
    final raw = _prefs.getString(key);
    if (raw == null) return [];
    try {
      return (jsonDecode(raw) as List).cast<Map<String, dynamic>>();
    } catch (_) {
      return [];
    }
  }

  Future<void> writeList(String key, List<Map<String, dynamic>> items) =>
      _prefs.setString(key, jsonEncode(items));
}
