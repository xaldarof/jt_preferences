abstract class Preferences implements Set, Get, Listener {
  //
}

abstract class Set {
  Future<bool> setString(String key, String? value);

  Future<bool> setInt(String key, int? value);

  Future<bool> setDouble(String key, double? value);

  Future<bool> setBool(String key, bool? value);
}

abstract class Get {
  Future<String?> getString(String key);

  Future<int?> getInt(String key);

  Future<double?> getDouble(String key);

  Future<bool?> getBoolean(String key);
}

abstract class Listener<T> {
  Stream<dynamic> listen({String? key});
}
