# JtPreferences

[![pub package](https://img.shields.io/pub/v/shared_preferences.svg)](https://pub.dev/packages/jt_preferences)

Supported data types are `int`, `double`, `bool`, `String` and `Writable object`.



## Usage
To use this plugin, add `jt_preferences` as a [dependency in your pubspec.yaml file](https://flutter.dev/docs/development/platform-integration/platform-channels).

### Examples
Here are small examples that show you how to use the package.


### Initialize
```dart
void main(List<String> args) 
  JtPreferences.initialize("path/path");
}
```

#### Write data
```dart
// Obtain shared preferences.
final preferences = await JtPreferences.getInstance();

// Save an integer value to 'counter' key.
await preferences.setInt('counter', 10);
// Save an boolean value to 'repeat' key.
await preferences.setBool('repeat', true);
// Save an double value to 'decimal' key.
await preferences.setDouble('decimal', 1.5);
// Save an String value to 'action' key.
await preferences.setString('action', 'Start');

//Save writable object
await preferences.saveObject(User(name: 'averageName', age: 12));

```
### Example User Writable object
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
  String key => name;
}

```



#### Read data
```dart
// Try reading data from the 'counter' key. If it doesn't exist, returns null.
final int? counter = preferences.getInt('counter');
// Try reading data from the 'repeat' key. If it doesn't exist, returns null.
final bool? repeat = preferences.getBool('repeat');
// Try reading data from the 'decimal' key. If it doesn't exist, returns null.
final double? decimal = preferences.getDouble('decimal');
// Try reading data from the 'action' key. If it doesn't exist, returns null.
final String? action = preferences.getString('action');

final object = await preferences.getObject('averageName', (map) => User.fromJson(map));
print(object?.name);
print(object?.age);

```

### Listen changes
```dart
//listen all changes
preferences.listen().listen((event) {
  print("key $event updated");
});

//listen only specific key
preferences.listen(key: 'counter').listen((event) {
   print("key $event updated");
});

```

#### Remove an entry
```dart
// Remove data for the 'counter' key.
final success = await preferences.remove('counter');
```
