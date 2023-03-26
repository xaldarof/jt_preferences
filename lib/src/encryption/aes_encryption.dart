import 'package:encrypt/encrypt.dart';

import 'encryption.dart';

abstract class AesEncryption implements Encryption {}

class AesEncryptionImpl implements AesEncryption {
  final String _encryptionKey;

  @override
  String decrypt(Encrypted encryptedData, {AESMode? mode}) {
    assert(_encryptionKey.length >= 16);
    final cipherKey = Key.fromUtf8(_encryptionKey.substring(0, 16));
    final encryptService = Encrypter(AES(cipherKey, mode: mode ?? AESMode.cbc));
    final initVector = IV.fromUtf8(_encryptionKey.substring(0, 16));

    return encryptService.decrypt(encryptedData, iv: initVector);
  }

  @override
  Encrypted encrypt(String plainText, {AESMode? mode}) {
    assert(_encryptionKey.length >= 16);
    final cipherKey = Key.fromUtf8(_encryptionKey.substring(0, 16));
    final encryptService = Encrypter(AES(cipherKey, mode: mode ?? AESMode.cbc));
    final initVector = IV.fromUtf8(_encryptionKey.substring(0, 16));

    Encrypted encryptedData = encryptService.encrypt(plainText, iv: initVector);
    return encryptedData;
  }

  @override
  String get key => _encryptionKey;

  AesEncryptionImpl({
    required String encryptionKey,
  }) : _encryptionKey = encryptionKey;
}
