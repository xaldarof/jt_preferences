import 'dart:io';

abstract class DirectoryProvider {
  Future<String> getFilesDir();
}

class DirectoryProviderImpl extends DirectoryProvider {
  @override
  Future<String> getFilesDir() async {
    return Directory.current.path;
  }
}
