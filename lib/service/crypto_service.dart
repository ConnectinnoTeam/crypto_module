import 'package:crypto_connect/algo/abstract/crypt_algo.dart';
import 'package:encrypt/encrypt.dart';

class CryptoService<T extends CryptAlgo> {
  CryptoService._();

  static CryptoService instance = CryptoService._();

  T? _algo;

  void initAlgo(T algo) {
    this._algo = algo;
  }

  Future<String> decrypt(String encryptedContent) async {
    if (_algo == null) {
      throw Exception("Algo not initialized");
    }
    return _algo!.decrypt(encryptedContent);
  }

  Future<Encrypted> encrypt(String plainText) async {
    if (_algo == null) {
      throw Exception("Algo not initialized");
    }
    return _algo!.encrypt(plainText);
  }
}
