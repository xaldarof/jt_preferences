import 'package:encrypt/encrypt.dart';

import 'encryption.dart';

abstract class AesEncryption implements Encryption {}

class AesEncryptionImpl implements AesEncryption {
  @override
  String decrypt(String key, Encrypted encryptedData, {AESMode? mode}) {
    assert(key.length >= 16);
    final cipherKey = Key.fromUtf8(key.substring(0, 16));
    final encryptService = Encrypter(AES(cipherKey, mode: mode ?? AESMode.cbc));
    final initVector = IV.fromUtf8(key.substring(0, 16));

    return encryptService.decrypt(encryptedData, iv: initVector);
  }

  @override
  Encrypted encrypt(String key, String plainText, {AESMode? mode}) {
    assert(key.length >= 16);
    final cipherKey = Key.fromUtf8(key.substring(0, 16));
    final encryptService = Encrypter(AES(cipherKey, mode: mode ?? AESMode.cbc));
    final initVector = IV.fromUtf8(key.substring(0, 16));

    Encrypted encryptedData = encryptService.encrypt(plainText, iv: initVector);
    return encryptedData;
  }
}
