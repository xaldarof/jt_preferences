import 'decrypt.dart';
import 'encrypt.dart';

abstract class IEncryptor implements Encrypt, Decrypt {
  String get key;
}
