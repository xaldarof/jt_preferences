import 'package:encrypt/encrypt.dart';

abstract class Encrypt {
  Encrypted encrypt(String plainText, {AESMode? mode});
}
