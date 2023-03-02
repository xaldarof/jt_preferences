import 'dart:io';

import 'directory_provider.dart';

class DirectoryProviderImpl extends DirectoryProvider {
  @override
  Future<String> getFilesDir(String rootPath) async {
    final path =
        "$rootPath${Platform.pathSeparator}jt_pref${Platform.pathSeparator}jtpreferences.json";
    await createFile(path);
    return path;
  }

  @override
  Future<void> createFile(String path) async {
    if (!(await File(path).exists())) {
      final file = await File(path).create(recursive: true);
      file.writeAsString("{}");
    }
  }
}
