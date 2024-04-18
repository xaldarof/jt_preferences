import 'package:jt_preferences/src/jt_preferences.dart';
import 'package:jt_preferences/src/fake/fake_user.dart';

void main(List<String> args) async {
  JtPreferences.initialize("path/path");

  final preferences = JtPreferences.getInstance();

  //listen only one key
  preferences.stream(key: 'averageName').listen((event) {
    print("key $event updated");
  });

  //listen all changes
  preferences.stream().listen((event) {
    print("key $event updated");
  });

  await preferences.setString('token', '123');
  await preferences.setInt('age', 18);
  await preferences.setDouble('weight', 18.5);
  await preferences.setBool('isFree', false);

  preferences.contains('isFree'); //true
  await preferences.remove('isFree');
  preferences.contains('isFree'); //false

  //Save writable object
  await preferences.saveObject(User(name: 'averageName', age: 12));

  //get writable object
  final object = preferences.getObject('averageName', (map) => User.fromJson(map));
  print(object?.name);
  print(object?.age);

  preferences.setString('key', 'value');
  preferences.setString('key1', 'value1');
}
