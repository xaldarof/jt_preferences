import 'package:jt_preferences/jt_preferences.dart';
import 'package:test/test.dart';

void main() {
  final preferences = JtPreferences.getInstance();
  group('test setters', () {
    test('set string test', () async {
      await preferences.setString('KeyStringTest', 'ValueStringTest');
      expect(await preferences.getString('KeyStringTest'), 'ValueStringTest');
    });

    test('set int test', () async {
      await preferences.setInt('KeyIntTest', 8);
      expect(await preferences.getInt('KeyIntTest'), 8);
    });
  });
}
