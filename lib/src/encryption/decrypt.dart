import 'package:encrypt/encrypt.dart';

abstract class Decrypt {
  String decrypt(Encrypted encryptedData, {AESMode? mode});
}
