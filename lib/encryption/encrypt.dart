import 'package:jt_preferences/encryption/encryption.dart';

abstract class Encrypt extends Encryption {
  Future<String> encrypt(String data);
}
