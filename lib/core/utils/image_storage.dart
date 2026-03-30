import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import '../constants/app_constants.dart';

/// Handles permanent storage of reference photos captured on device.
/// Images are copied from their temp path into the app documents directory.
abstract final class ImageStorage {
  static const _uuid = Uuid();

  /// Copies [sourcePath] into the app's persistent photos directory.
  /// Returns the new permanent path.
  static Future<String> copyToAppStorage(String sourcePath) async {
    final docsDir = await getApplicationDocumentsDirectory();
    final photosDir = Directory(
      p.join(docsDir.path, AppConstants.photosDirectoryName),
    );
    if (!photosDir.existsSync()) {
      await photosDir.create(recursive: true);
    }

    final ext = p.extension(sourcePath);
    final fileName = '${_uuid.v4()}$ext';
    final destPath = p.join(photosDir.path, fileName);

    await File(sourcePath).copy(destPath);
    return destPath;
  }

  /// Deletes a stored reference photo file if it exists.
  static Future<void> deleteIfExists(String? path) async {
    if (path == null) return;
    final file = File(path);
    if (file.existsSync()) {
      await file.delete();
    }
  }
}
