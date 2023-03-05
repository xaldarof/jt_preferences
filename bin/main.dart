import 'package:jt_preferences/fake/fake_user.dart';
import 'package:jt_preferences/jt_preferences.dart';

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
  final object = await preferences.getObject('averageName', (map) => User.fromJson(map));
  print(object?.name);
  print(object?.age);
}
