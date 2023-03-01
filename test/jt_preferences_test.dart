import 'package:jt_preferences/jt_preferences.dart';
import 'package:test/test.dart';

void main() {
  final preferences = JtPreferences.getInstance();
  group('test save values', () {
    test('set string test', () async {
      await preferences.setString('KeyStringTest', 'ValueStringTest');
      expect(await preferences.getString('KeyStringTest'), 'ValueStringTest');
    });

    test('set int test', () async {
      await preferences.setInt('KeyIntTest', 8);
      expect(await preferences.getInt('KeyIntTest'), 8);
    });

    test('set double test', () async {
      await preferences.setDouble('KeyDoubleTest', 3.14);
      expect(await preferences.getDouble('KeyDoubleTest'), 3.14);
    });

    test('set bool test', () async {
      await preferences.setBool('KeyBooleanTest', true);
      expect(await preferences.getBoolean('KeyBooleanTest'), true);
    });

    test('test listen key', () async {
      await preferences.setString('KeySingleKeyListen', "Hi");
      preferences.listenKey('KeySingleKeyListen').listen(
        expectAsync1(
              (event) {
            expect(event, 'KeySingleKeyListen');
          },
        ),
      );
    });
  });
}
