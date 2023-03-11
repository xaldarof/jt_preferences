import '../core/writable.dart';

class User extends Writable {
  final String name;
  final int age;

  @override
  factory User.fromJson(Map<String, dynamic> map) {
    return User(
      name: map['name'],
      age: map['age'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "age": age,
    };
  }

  User({
    required this.name,
    required this.age,
  });

  @override
  dynamic get key => name;
}
