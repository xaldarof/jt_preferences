import 'dart:io';

import 'package:jt_preferences/src/jt_preferences.dart';
import 'package:jt_preferences/src/fake/fake_user.dart';

import 'package:test/test.dart';

void main() async {
  JtPreferences.initialize(Directory.current.path);
  final preferences = JtPreferences.getInstance();
  await preferences.clear();
  group('test save values', () {
    test('set string test', () async {
      await preferences.setString('KeyStringTest', 'ValueStringTest');
      expect(preferences.getString('KeyStringTest'), 'ValueStringTest');
    });

    test('set int test', () async {
      await preferences.setInt('KeyIntTest', 8);
      expect(preferences.getInt('KeyIntTest'), 8);
    });

    test('set double test', () async {
      await preferences.setDouble('KeyDoubleTest', 3.14);
      expect(preferences.getDouble('KeyDoubleTest'), 3.14);
    });

    test('set bool test', () async {
      await preferences.setBool('KeyBooleanTest', true);
      expect(preferences.getBoolean('KeyBooleanTest'), true);
    });

    test('test listen key', () async {
      preferences.stream(key: 'KeySingleKeyListen').listen(
        expectAsync1(
          (event) {
            expect(event, 'KeySingleKeyListen');
          },
        ),
      );
      await Future.delayed(Duration.zero);
      await preferences.setString('KeySingleKeyListen', "Hi");
    });

    test('test contains key', () async {
      await preferences.setString('Key', "KeyValue");
      expect((preferences.contains('Key')), true);
    });

    test('test remove key', () async {
      await preferences.setString('KeyTestForRemove', "KeyValue");
      expect((preferences.contains('KeyTestForRemove')), true);
      final res = await preferences.remove('KeyTestForRemove');
      expect(res, true);
      expect((preferences.contains('KeyTestForRemove')), false);
    });

    test('test remove key if value is null', () async {
      await preferences.setString('KeyTest1', "KeyValue1");
      expect((preferences.contains('KeyTest1')), true);
      await preferences.setString('KeyTest1', null);
      expect((preferences.contains('KeyTest1')), false);
    });

    test('test clear all data', () async {
      await preferences.setString('KeyTest1', "KeyValue1");
      await preferences.clear();
      expect((preferences.getAll()).isEmpty, true);
    });

    test('test get all', () async {
      await preferences.clear();
      await preferences.setString('KeyTest1', "KeyValue1");
      expect((preferences.getAll()).values.isNotEmpty, true);
      expect((preferences.getAll()).values.toList()[0], 'KeyValue1');
    });

    test('test save object', () async {
      await preferences.saveObject(User(name: "Tom", age: 19));

      final object = (preferences.getObject('19', (map) => User.fromJson(map)));
      expect(object?.age, 19);
    });

    test('test get keys', () async {
      expect((preferences.getKeys()).isNotEmpty, true);
      await preferences.clear();
      expect((preferences.getKeys()).isEmpty, true);
    });
  });
}
