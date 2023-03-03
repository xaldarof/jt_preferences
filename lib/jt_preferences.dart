import 'package:jt_preferences/adapter/data_mapper.dart';
import 'package:jt_preferences/core/preferences.dart';
import 'package:jt_preferences/preferences_manager.dart';

import 'file/dir/directory_provider_impl.dart';
import 'file/file_manager_impl.dart';

class JtPreferences extends Preferences {
  JtPreferences._();

  static late final PreferencesManager _manager;
  static final JtPreferences _instance = JtPreferences._();
  static late String _path;

  static JtPreferences getInstance() {
    return _instance;
  }

  static initialize(String path) {
    final dirProvider = DirectoryProviderImpl();
    final mapper = DataMapper();
    final fileManager = FileManagerImpl(
        directoryProvider: dirProvider, mapper: mapper, rootPath: _path);
    _manager = PreferencesManagerImpl(manager: fileManager);
    _path = path;
  }

  @override
  Future<bool> setInt(String key, int? value) {
    return _manager.setInt(key, value);
  }

  @override
  Future<bool> setString(String key, String? value) {
    return _manager.setString(key, value);
  }

  @override
  Future<int?> getInt(String key) {
    return _manager.getInt(key);
  }

  @override
  Future<String?> getString(String key) {
    return _manager.getString(key);
  }

  @override
  Future<bool?> getBoolean(String key) {
    return _manager.getBoolean(key);
  }

  @override
  Future<double?> getDouble(String key) {
    return _manager.getDouble(key);
  }

  @override
  Future<bool> setBool(String key, bool? value) {
    return _manager.setBool(key, value);
  }

  @override
  Future<bool> setDouble(String key, double? value) {
    return _manager.setDouble(key, value);
  }

  @override
  Stream<dynamic> listen({String? key}) {
    return _manager.listen(key: key);
  }

  @override
  Future<bool> contains(String key) {
    return _manager.contains(key);
  }

  @override
  Future<bool> remove(String key) {
    return _manager.remove(key);
  }
}
