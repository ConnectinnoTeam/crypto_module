import 'package:encrypt/encrypt.dart';

abstract class CryptAlgo {
  const CryptAlgo();

  Future<String> decrypt(String encryptedContent);

  Future<Encrypted> encrypt(String plainText);
}
