import 'dart:convert';

import 'package:crypto_connect/algo/abstract/crypt_algo.dart';
import 'package:encrypt/encrypt_io.dart';
import 'dart:io';
import 'package:encrypt/encrypt.dart';
import 'package:pointycastle/asymmetric/api.dart';

class RsaAlgo extends CryptAlgo {
  final String privateKeyContent;
  final String publicKeyContent;
  final String path;
  final bool isBase64Encoded;
  RsaAlgo({
    required this.privateKeyContent,
    required this.publicKeyContent,
    required this.path,
    this.isBase64Encoded = false,
  });

  final List<String> _createdFiles = [];

  @override
  Future<String> decrypt(String encryptedContent) async {
    final privateKeyPath = await _createFile(
      privateKeyContent,
      isBase64Encoded,
    );
    final publicKeyPath = await _createFile(
      publicKeyContent,
      false,
    );
    final publicKey = await parseKeyFromFile<RSAPublicKey>(publicKeyPath);
    final privateKey = await parseKeyFromFile<RSAPrivateKey>(privateKeyPath);
    final encryptor =
        Encrypter(RSA(publicKey: publicKey, privateKey: privateKey));
    final decrypted = encryptor.decrypt64(encryptedContent);

    await _deleteFile(privateKeyPath);
    await _deleteFile(publicKeyPath);

    return decrypted;
  }

  @override
  Future<Encrypted> encrypt(String plaintext) async {
    final privateKeyPath = await _createFile(
      privateKeyContent,
      isBase64Encoded,
    );
    final publicKeyPath = await _createFile(
      publicKeyContent,
      false,
    );
    final publicKey = await parseKeyFromFile<RSAPublicKey>(publicKeyPath);
    final privateKey = await parseKeyFromFile<RSAPrivateKey>(privateKeyPath);
    final encryptor = Encrypter(RSA(publicKey: publicKey, privateKey: privateKey));
    final encryptedContent = encryptor.encrypt(plaintext);

    await _deleteFile(privateKeyPath);
    await _deleteFile(publicKeyPath);

    return encryptedContent;
  }

  Future<void> _deleteFile(String filePath) async {
    try {
      final file = File(filePath);
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      return;
    }
  }
  

  Future<String> _createFile(String content, bool isBase64Encoded) async {
    final now = DateTime.now();
    final filePath = "$path/$now.pem";
    await File(filePath).create(recursive: true);
    String? fileContent;
    if (isBase64Encoded) {
      Codec<String, String> stringToBase64 = utf8.fuse(base64);
      fileContent = stringToBase64.decode(content);
    } else {
      fileContent = content;
    }
    await File(filePath).writeAsString(fileContent);
    _createdFiles.add(filePath);
    return filePath;
  }
}
