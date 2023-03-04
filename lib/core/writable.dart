abstract class Writable {
  dynamic key;

  OnConflictStrategy? onConflictStrategy = OnConflictStrategy.update;

  Map<String, dynamic> toJson();
}

enum OnConflictStrategy {
  remove,
  update,
  ignore,
}
