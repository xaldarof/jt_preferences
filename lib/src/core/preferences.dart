import 'package:jt_preferences/src/core/mode_manager.dart';

import 'writable.dart';

abstract class Preferences implements Set, Get, Clear, Listener, ModeManager {
  //
}

abstract class Set {
  Future<bool> setString(String key, String? value);

  Future<bool> setInt(String key, int? value);

  Future<bool> setDouble(String key, double? value);

  Future<bool> setBool(String key, bool? value);

  Future<bool> remove(String key);

  Future<bool> saveObject(Writable data);
}

abstract class Clear {
  Future<bool> clear();
}

abstract class Get {
  Future<String?> getString(String key);

  Future<int?> getInt(String key);

  Future<double?> getDouble(String key);

  Future<bool?> getBoolean(String key);

  Future<bool> contains(String key);

  Future<Map<String, dynamic>> getAll();

  Future<List<String>> getKeys();

  Future<T?> getObject<T>(
      String key, T Function(Map<String, dynamic> map) parse);
}

abstract class Listener<T> {
  Stream<String> listen({String? key});
}
