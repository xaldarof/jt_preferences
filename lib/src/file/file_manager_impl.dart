import 'dart:io';

import '../adapter/data_mapper.dart';
import 'dir/directory_provider.dart';
import 'file_manager.dart';

class FileManagerImpl extends FileManager {
  final DirectoryProvider _directoryProvider;
  final Mapper _mapper;
  final String _rootPath;
  Map<String, dynamic> _temp = {};

  @override
  Future<Map<String, dynamic>> read() async {
      final file = File(await _directoryProvider.getFilesDir(_rootPath));
      final json = await file.readAsString();
      final map = _mapper.decode(json);
      return map;
  }

  @override
  Future<bool> write(Map<String, dynamic> data) async {
      await save(data);
      return true;
  }

  FileManagerImpl({
    required DirectoryProvider directoryProvider,
    required Mapper mapper,
    required String rootPath,
  })  : _directoryProvider = directoryProvider,
        _mapper = mapper,
        _rootPath = rootPath;



  @override
  Future<bool> sync() async {
    final cache = await read();
    cache.addAll(_temp);
    final res = await save(cache);
    if (res) {
      _temp.clear();
    }
    return true;
  }

  @override
  Future<bool> save(Map<String, dynamic> map) async {
    final path = await _directoryProvider.getFilesDir(_rootPath);
    final file = File(path);
    await file.writeAsString(_mapper.encode(map), mode: FileMode.write);
    return true;
  }

}
