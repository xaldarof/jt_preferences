import 'dart:async';
import 'package:jt_preferences/src/core/preferences.dart';
import 'package:jt_preferences/src/core/read.dart';
import 'package:jt_preferences/src/core/writable.dart';
import 'package:jt_preferences/src/core/write.dart';
import 'package:jt_preferences/src/file/file_manager.dart';
import 'package:jt_preferences/src/models/write_data.dart';

abstract class PreferencesManager extends Preferences
    implements Read<Map<String, dynamic>>, Write<WriteData> {
  Future<bool> writeByCheckConflicts(Writable object);
}

class PreferencesManagerImpl extends PreferencesManager {
  final FileManager _manager;
  final StreamController<String> _keyListener =
      StreamController<String>.broadcast();

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
    if (data.map[data.updatedKey] == null) {
      data.map.remove(data.updatedKey);
    }
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
  Stream<String> stream({String? key}) async* {
    await for (final event in _keyListener.stream) {
      if (key != null) {
        if (event == key) {
          yield key;
        }
      } else {
        yield event;
      }
    }
  }

  @override
  Future<bool> contains(String key) async {
    return (await read()).containsKey(key);
  }

  @override
  Future<bool> remove(String key) async {
    final map = await read();
    map.remove(key);
    return await write(WriteData(map: map, updatedKey: key));
  }

  @override
  Future<bool> clear() async {
    final map = await read();
    map.clear();
    return write(WriteData(map: map, updatedKey: 'null'));
  }

  @override
  Future<Map<String, dynamic>> getAll() async {
    return read();
  }

  @override
  Future<bool> saveObject(Writable data) async {
    return writeByCheckConflicts(data);
  }

  @override
  Future<bool> writeByCheckConflicts(Writable object) async {
    final map = await read();
    if (map.containsKey(object.key)) {
      if (object.onConflictStrategy == OnConflictStrategy.remove) {
        map.remove(object.key);
        return write(WriteData(map: map, updatedKey: object.key));
      }
      if (object.onConflictStrategy == OnConflictStrategy.update) {
        map[object.key] = object.toJson();
        return write(WriteData(map: map, updatedKey: object.key));
      }
      if (object.onConflictStrategy == OnConflictStrategy.ignore) {
        return true;
      }
    } else {
      map[object.key] = object.toJson();
      return write(WriteData(map: map, updatedKey: object.key));
    }
    return false;
  }

  @override
  Future<T?> getObject<T>(
      String key, T Function(Map<String, dynamic> map) parse) async {
    final map = await read();
    if (map.containsKey(key)) {
      return parse((map[key] as Map<String, dynamic>));
    } else {
      return null;
    }
  }

  @override
  Future<List<String>> getKeys() async {
    return (await read()).keys.toList();
  }
}
