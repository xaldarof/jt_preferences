import 'decrypt.dart';
import 'encrypt.dart';

abstract class Encryption implements Encrypt, Decrypt {
  String get key;
}
