import 'dart:io';

import 'package:jt_preferences/src/encryption/encryption.dart';
import 'package:jt_preferences/src/file/dir/directory_provider.dart';

class EncryptedDirectoryProviderImpl extends DirectoryProvider {
  final Encryption _encryptor;

  @override
  Future<String> getFilesDir(String rootPath) async {
    final path =
        "$rootPath${Platform.pathSeparator}jt_pref${Platform.pathSeparator}jtpreferences_enc.txt";
    await createFile(path);
    return path;
  }

  @override
  Future<void> createFile(String path) async {
    if (!(await File(path).exists())) {
      final file = await File(path).create(recursive: true);
      file.writeAsString(_encryptor.encrypt("{}").base64);
    }
  }

  EncryptedDirectoryProviderImpl({
    required Encryption encryptor,
  }) : _encryptor = encryptor;
}
