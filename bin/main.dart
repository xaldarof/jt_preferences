import 'package:jt_preferences/jt_preferences.dart';

void main(List<String> args) async {
  final args = JtPreferences.getInstance();
  await args.setString('token', '123');
  await args.setInt('age', 18);
  await args.setDouble('weight', 18.5);
  await args.setBool('isFree', false);

  args.listen(key: 'token').listen((event) {
    print("key $event updated");
  });

  args.listen().listen((event) {
    print("key $event updated");
  });
}
