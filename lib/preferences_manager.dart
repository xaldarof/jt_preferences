import 'package:jt_preferences/core/preferences.dart';
import 'package:jt_preferences/core/read.dart';
import 'package:jt_preferences/core/write.dart';
import 'package:jt_preferences/file/file_manager.dart';

abstract class PreferencesManager extends Preferences
    implements Read<Map<String, dynamic>>, Write<Map<String, dynamic>> {}

class PreferencesManagerImpl extends PreferencesManager {
  final FileManager _manager;

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
    return await write(map);
  }

  @override
  Future<bool> setString(String key, String? value) async {
    final map = await read();
    map[key] = value;
    return await write(map);
  }

  @override
  Future<bool> write(Map<String, dynamic> data) async {
    return await _manager.write(data);
  }

  PreferencesManagerImpl({
    required FileManager manager,
  }) : _manager = manager;
}
