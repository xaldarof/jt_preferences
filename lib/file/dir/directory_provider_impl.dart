import 'dart:io';

import 'package:path_provider/path_provider.dart';

import 'directory_provider.dart';

class DirectoryProviderImpl extends DirectoryProvider {
  @override
  Future<String> getFilesDir() async {
    return (await getApplicationDocumentsDirectory()).path;
  }
}
