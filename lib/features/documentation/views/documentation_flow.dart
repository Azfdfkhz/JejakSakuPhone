import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../view_models/documentation_view_model.dart';

/// Widget → Camera → Preview → Save (local, pending sync).
Future<void> startDocumentationCapture(BuildContext context) async {
  final vm = context.read<DocumentationViewModel>();
  final messenger = ScaffoldMessenger.maybeOf(context);

  XFile? shot;
  try {
    shot = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 85,
    );
  } catch (_) {
    messenger?.showSnackBar(
      const SnackBar(content: Text('Kamera tidak dapat dibuka.')),
    );
    return;
  }
  if (shot == null || !context.mounted) return;

  final path = shot.path;
  final save = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('Simpan dokumentasi?'),
      content: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.file(File(path), height: 260, fit: BoxFit.cover),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx, false),
          child: const Text('Batal'),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(ctx, true),
          child: const Text('Simpan'),
        ),
      ],
    ),
  );
  if (save != true) return;

  try {
    await vm.saveCapture(path);
    messenger?.showSnackBar(
      const SnackBar(content: Text('Dokumentasi tersimpan (menunggu sinkron).')),
    );
  } catch (_) {
    messenger?.showSnackBar(
      const SnackBar(content: Text('Gagal menyimpan dokumentasi.')),
    );
  }
}
