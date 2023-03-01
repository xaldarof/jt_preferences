import 'dart:async';

import 'package:jt_preferences/core/preferences.dart';
import 'package:jt_preferences/core/read.dart';
import 'package:jt_preferences/core/write.dart';
import 'package:jt_preferences/file/file_manager.dart';

class WriteData {
  final Map<String, dynamic> map;
  final String updatedKey;

  const WriteData({
    required this.map,
    required this.updatedKey,
  });
}

abstract class PreferencesManager extends Preferences
    implements Read<Map<String, dynamic>>, Write<WriteData> {}

class PreferencesManagerImpl extends PreferencesManager {
  final FileManager _manager;
  final StreamController _keyListener = StreamController();

  @override
  Future<int?> getInt(String key) async {
    final map = await read();
    return map[key] as int?;
  }

  @override
  Future<String?> getString(String key) async {
    final map = await read();
    return map[key] as String?;
  }

  @override
  Future<Map<String, dynamic>> read() {
    return _manager.read();
  }

  @override
  Future<bool> setInt(String key, int? value) async {
    final map = await read();
    map[key] = value;
    return await write(WriteData(map: map, updatedKey: key));
  }

  @override
  Future<bool> setString(String key, String? value) async {
    final map = await read();
    map[key] = value;
    return await write(WriteData(map: map, updatedKey: key));
  }

  @override
  Future<bool> write(WriteData data) async {
    await _manager.write(data.map);
    _keyListener.add(data.updatedKey);
    return true;
  }

  PreferencesManagerImpl({
    required FileManager manager,
  }) : _manager = manager;

  @override
  Future<bool?> getBoolean(String key) async {
    final map = await read();
    return map[key] as bool?;
  }

  @override
  Future<double?> getDouble(String key) async {
    final map = await read();
    return map[key] as double?;
  }

  @override
  Future<bool> setBool(String key, bool? value) async {
    final map = await read();
    map[key] = value;
    return await write(WriteData(map: map, updatedKey: key));
  }

  @override
  Future<bool> setDouble(String key, double? value) async {
    final map = await read();
    map[key] = value;
    return await write(WriteData(map: map, updatedKey: key));
  }

  @override
  Stream<String> listenKey(String key) async* {
    await for (final event in _keyListener.stream) {
      if (event == key) {
        yield key;
      }
    }
  }
}
