import 'dart:io';

import 'package:jt_preferences/provider.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() async {
  JtPreferences.initialize(Directory.current.path);
  final preferences = JtPreferences.getInstance();
  preferences.startTemporaryMode();
  await preferences.clear();

  group('description', () {
    test('description test', () async {
      await preferences.setString('key', 'value');
      final res = await preferences.getString('key');
      await preferences.sync();

      expect(res, 'value');
    });
  });
}
