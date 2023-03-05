import 'dart:io';

import 'package:jt_preferences/adapter/data_mapper.dart';
import 'package:jt_preferences/file/dir/directory_provider.dart';

import 'file_manager.dart';

class FileManagerImpl extends FileManager {
  final DirectoryProvider _directoryProvider;
  final Mapper _mapper;
  final String _rootPath;

  @override
  Future<Map<String, dynamic>> read() async {
    final file = File(await _directoryProvider.getFilesDir(_rootPath));
    final json = await file.readAsString();
    final map = _mapper.decode(json);
    return map;
  }

  @override
  Future<bool> write(Map<String, dynamic> data) async {
    final path = await _directoryProvider.getFilesDir(_rootPath);
    final file = File(path);
    await file.writeAsString(_mapper.encode(data), mode: FileMode.write);
    return true;
  }

  FileManagerImpl({
    required DirectoryProvider directoryProvider,
    required Mapper mapper,
    required String rootPath,
  })  : _directoryProvider = directoryProvider,
        _mapper = mapper,
        _rootPath = rootPath;
}
