import 'dart:io';

import 'package:jt_preferences/fake/fake_user.dart';
import 'package:jt_preferences/jt_preferences.dart';
import 'package:test/test.dart';

void main() {
  JtPreferences.initialize(Directory.current.path);
  //
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
      preferences.listen(key: 'KeySingleKeyListen').listen(
        expectAsync1(
          (event) {
            expect(event, 'KeySingleKeyListen');
          },
        ),
      );
    });

    test('test contains key', () async {
      await preferences.setString('Key', "KeyValue");
      expect((await preferences.contains('Key')), true);
    });

    test('test remove key', () async {
      await preferences.setString('KeyTestForRemove', "KeyValue");
      expect((await preferences.contains('KeyTestForRemove')), true);
      final res = await preferences.remove('KeyTestForRemove');
      expect(res, true);
      expect((await preferences.contains('KeyTestForRemove')), false);
    });

    test('test remove key if value is null', () async {
      await preferences.setString('KeyTest1', "KeyValue1");
      expect((await preferences.contains('KeyTest1')), true);
      await preferences.setString('KeyTest1', null);
      expect((await preferences.contains('KeyTest1')), false);
    });

    test('test clear all data', () async {
      await preferences.setString('KeyTest1', "KeyValue1");
      await preferences.clear();
      expect((await preferences.getAll()).isEmpty, true);
    });

    test('test get all', () async {
      await preferences.clear();
      await preferences.setString('KeyTest1', "KeyValue1");
      expect((await preferences.getAll()).values.isNotEmpty, true);
      expect((await preferences.getAll()).values.toList()[0], 'KeyValue1');
    });

    test('test save object', () async {
      await preferences.saveObject(User(name: "Tom", age: 19));

      final object =
          (await preferences.getObject('Tom', (map) => User.fromJson(map)));
      expect(object?.age, 19);
    });
  });
}
