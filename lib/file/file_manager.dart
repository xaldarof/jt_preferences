import 'dart:io';

import 'package:jt_preferences/adapter/data_mapper.dart';
import 'package:jt_preferences/file/directory_provider.dart';
import 'package:jt_preferences/core/read.dart';
import 'package:jt_preferences/core/write.dart';

abstract class FileManager
    implements Read<Map<String, dynamic>>, Write<Map<String, dynamic>> {
  String makeFile(String dir);
}

class FileManagerImpl extends FileManager {
  final DirectoryProvider _directoryProvider;
  final Mapper _mapper;

  @override
  Future<Map<String, dynamic>> read() async {
    final file = File(makeFile(await _directoryProvider.getFilesDir()));
    final json = await file.readAsString();
    final map = _mapper.decode(json);
    return map;
  }

  @override
  Future<bool> write(Map<String, dynamic> data) async {
    final path = makeFile((await _directoryProvider.getFilesDir()));
    print(path);
    final file = File(path);
    await file.writeAsString(_mapper.encode(data), mode: FileMode.write);
    return true;
  }

  FileManagerImpl({
    required DirectoryProvider directoryProvider,
    required Mapper mapper,
  })  : _directoryProvider = directoryProvider,
        _mapper = mapper;

  @override
  String makeFile(String dir) {
    return "$dir/preferences.json";
  }
}
