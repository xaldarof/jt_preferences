import 'package:jt_preferences/jt_preferences.dart';

void main(List<String> args) async {
  final args = JtPreferences.getInstance();
  await args.setString('username', 'jack');
  await args.setInt('age', 18);
}
