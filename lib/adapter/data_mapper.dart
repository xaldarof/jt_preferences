import 'dart:convert';

import 'package:jt_preferences/adapter/decoder.dart';
import 'package:jt_preferences/adapter/encoder.dart';

abstract class Mapper implements Encoder, Decoder {}

class DataMapper extends Mapper {
  @override
  Map<String, dynamic> decode(String json) {
    return jsonDecode(json);
  }

  @override
  String encode(Map<String, dynamic> map) {
    return jsonEncode(map);
  }
}
