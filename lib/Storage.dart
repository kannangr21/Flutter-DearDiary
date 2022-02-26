import 'dart:io';
import 'dart:async';

import 'package:path_provider/path_provider.dart';

class UidStorage {
  // late String uuid;
  // UidStorage(this.uuid);

  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/uid.txt');
  }

  static Future<File> writeUid(String uid) async {
    final file = await _localFile;
    return file.writeAsString(uid);
  }
}
