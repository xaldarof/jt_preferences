import 'package:encrypt/encrypt.dart';

abstract class Decrypt {
  String decrypt(String key, Encrypted encryptedData, {AESMode? mode});
}
