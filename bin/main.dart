import 'package:jt_preferences/jt_preferences.dart';

void main(List<String> args) async {
  JtPreferences.initialize("path/path");
  final preferences = JtPreferences.getInstance();
  await preferences.setString('token', '123');
  await preferences.setInt('age', 18);
  await preferences.setDouble('weight', 18.5);
  await preferences.setBool('isFree', false);

  preferences.listen(key: 'token').listen((event) {
    print("key $event updated");
  });

  preferences.listen().listen((event) {
    print("key $event updated");
  });
}
