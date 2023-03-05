import 'package:encrypt/encrypt.dart';

abstract class Encrypt {
  Encrypted encrypt(String key, String plainText, {AESMode? mode});
}
