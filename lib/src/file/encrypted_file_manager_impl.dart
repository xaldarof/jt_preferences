import 'dart:io';

import 'package:encrypt/encrypt.dart';
import 'package:jt_preferences/src/encryption/encryption.dart';
import 'package:jt_preferences/src/file/file_manager.dart';

import '../adapter/data_mapper.dart';
import 'dir/directory_provider.dart';

class EncryptedFileManager extends FileManager {
  final DirectoryProvider _directoryProvider;
  final Encryption _encryptor;
  final Mapper _mapper;
  final String _rootPath;
  bool _saveTemporary = false;
  final Map<String, dynamic> _temp = {};

  @override
  Future<Map<String, dynamic>> read() async {
    if (_saveTemporary) {
      return _temp;
    } else {
      final file = File(await _directoryProvider.getFilesDir(_rootPath));
      final data = await file.readAsString();
      final decrypted = _encryptor.decrypt(Encrypted.from64(data));
      final map = _mapper.decode(decrypted);
      return map;
    }
  }

  @override
  Future<bool> write(Map<String, dynamic> data) async {
    if (_saveTemporary) {
      _temp.clear();
      _temp.addAll(data);
      return true;
    }
    await save(data);
    return true;
  }

  @override
  Future<bool> save(Map<String, dynamic> map) async {
    final path = await _directoryProvider.getFilesDir(_rootPath);
    final file = File(path);
    final encrypted = _encryptor.encrypt(_mapper.encode(map));
    await file.writeAsString(encrypted.base64, mode: FileMode.write);
    return true;
  }

  EncryptedFileManager({
    required DirectoryProvider directoryProvider,
    required Encryption encryptor,
    required Mapper mapper,
    required String rootPath,
  })  : _directoryProvider = directoryProvider,
        _encryptor = encryptor,
        _mapper = mapper,
        _rootPath = rootPath;

  @override
  void startTemporaryMode() {
    _saveTemporary = true;
  }

  @override
  void stopTemporaryMode() {
    _saveTemporary = false;
  }

  @override
  Future<bool> sync() async {
    return await save(_temp);
  }

  @override
  bool get isTemporaryModeEnabled => _saveTemporary;
}
