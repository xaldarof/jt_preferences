Here is an example:

```
void main(List<String> args) async {
  JtPreferences.initialize("path/path");

  final preferences = JtPreferences.getInstance();

  //listen only one key
  preferences.listen(key: 'averageName').listen((event) {
    print("key $event updated");
  });

  //listen all changes
  preferences.listen().listen((event) {
    print("key $event updated");
  });

  await preferences.setString('token', '123');
  await preferences.setInt('age', 18);
  await preferences.setDouble('weight', 18.5);
  await preferences.setBool('isFree', false);

  await preferences.contains('isFree'); //true
  await preferences.remove('isFree');
  await preferences.contains('isFree'); //false

  //Save writable object
  await preferences.saveObject(User(name: 'averageName', age: 12));

  //get writable object
  final object =
      await preferences.getObject('averageName', (map) => User.fromJson(map));
  print(object?.name);
  print(object?.age);
}
```

Here is example Writable object:

```dart
class User extends Writable {
  final String name;
  final int age;

  @override
  factory User.fromJson(Map<String, dynamic> map) {
    return User(name: map['name'], age: map['age']);
  }

  @override
  OnConflictStrategy? get onConflictStrategy => OnConflictStrategy.update;

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
  get key => name;
}
```

[Open pub.dev](https://pub.dev/packages/jt_preferences)
