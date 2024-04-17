import 'dart:io';

import 'package:jt_preferences/provider.dart';

void main() async {
  print("Initializing...");
  JtPreferences.initialize(Directory.current.path);
  final preferences = JtPreferences.getInstance();
  print("Clearing cache...");
  await preferences.clear();
  final start = DateTime.now();
  print("Benchmark started...");
  for (int i = 0; i < 5000; i++) {
    await preferences.setString('key$i', 'value$i');
  }
  print("Benchmark end!");
  final end = DateTime.now();
  print("[Write] in milliseconds : ${end.difference(start).inMilliseconds}");
}
