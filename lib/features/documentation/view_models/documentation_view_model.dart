import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import '../../../data/repositories/repositories.dart';
import '../../../domain/models/models.dart';

/// Documentation: camera capture → local file + metadata (pending sync).
/// Drive upload / Supabase metadata come later through the sync queue;
/// no fake Drive IDs or URLs are ever written.
class DocumentationViewModel extends ChangeNotifier {
  DocumentationViewModel({
    JsonListRepository<Documentation>? repository,
    Future<Directory> Function()? baseDirectory,
  })  : _repo = repository,
        _baseDirectory = baseDirectory ?? getApplicationDocumentsDirectory {
    if (_repo != null) {
      _items = _repo.loadAll()
        ..sort((a, b) => b.capturedAt.compareTo(a.capturedAt));
    }
  }

  final JsonListRepository<Documentation>? _repo;
  final Future<Directory> Function() _baseDirectory;
  List<Documentation> _items = [];

  List<Documentation> get items => List.unmodifiable(_items);

  int get todayCount {
    final n = DateTime.now();
    return _items
        .where((d) =>
            d.capturedAt.year == n.year &&
            d.capturedAt.month == n.month &&
            d.capturedAt.day == n.day)
        .length;
  }

  int get pendingCount =>
      _items.where((d) => d.syncStatus != SyncStatus.synced).length;

  /// Copies the captured photo into app storage and records its metadata.
  Future<Documentation> saveCapture(String sourcePath,
      {String? description}) async {
    final base = await _baseDirectory();
    final dir = Directory(p.join(base.path, 'jejak_saku_docs'));
    await dir.create(recursive: true);

    final now = DateTime.now();
    final fileName = 'JS_${DateFormat('yyyyMMdd_HHmmss').format(now)}.jpg';
    final dest = await File(sourcePath).copy(p.join(dir.path, fileName));

    final doc = Documentation(
      id: const Uuid().v4(),
      fileName: fileName,
      fileType: 'image/jpeg',
      fileSize: await dest.length(),
      description: description,
      localPath: dest.path,
      capturedAt: now,
      createdAt: now,
      updatedAt: now,
      syncStatus: SyncStatus.pending,
    );
    _items.insert(0, doc);
    await _repo?.saveAll(_items);
    notifyListeners();
    return doc;
  }
}
