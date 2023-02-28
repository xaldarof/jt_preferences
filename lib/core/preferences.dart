abstract class Preferences implements Set, Get {
  //
}

abstract class Set {
  Future<bool> setString(String key, String? value);

  Future<bool> setInt(String key, int? value);
}

abstract class Get {
  Future<String?> getString(String key);

  Future<int?> getInt(String key);
}
