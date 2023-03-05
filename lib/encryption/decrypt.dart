import 'package:encrypt/encrypt.dart';
import 'package:jt_preferences/encryption/encryption.dart';

abstract class Decrypt {
  String decrypt(String key, Encrypted encryptedData, {AESMode? mode});
}
