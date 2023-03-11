abstract class Writable {
  String get key;

  OnConflictStrategy? onConflictStrategy = OnConflictStrategy.update;

  Map<String, dynamic> toJson();
}

enum OnConflictStrategy {
  remove,
  update,
  ignore,
}
