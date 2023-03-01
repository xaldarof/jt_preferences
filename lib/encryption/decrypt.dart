import 'package:jt_preferences/encryption/encryption.dart';

abstract class Decrypt extends Encryption {
  Future<String> decrypt(String data);
}
