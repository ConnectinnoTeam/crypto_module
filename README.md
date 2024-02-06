<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

## Crypto SDK 

Crypto SDK functionalities for decrypting content using various cryptographic algorithms. Currently only RSA algorithm is supported and other algorithms can be added in the future. 

For a deeper understanding of the RSA algorithm, you can refer to this insightful article: https://jryancanty.medium.com/understanding-cryptography-with-rsa-74721350331f 

## Overview

To utilize the Crypto SDK, you'll require the privateKey, publicKey, and the encrypted content. In most projects, the privateKey can be sourced from a ".env" file, while the publicKey can typically be retrieved from the project's remote configuration. The encrypted content is commonly obtained from the database.


## Usage

1. Initialize the RSA Algorithm by providing privateKeyContent and publicKeyContent. 

```dart
final rsaAlgo = RsaAlgo(
    privateKeyContent: privateKeyContent,
    publicKeyContent: publicKeyContent,
    path: '/path/to/keys', // Provide the path where keys will be stored
  );
```

2. Initialize the CryptoService instance by providing an instance of a class that implements the CryptAlgo abstract class.

```dart
final cryptoService = CryptoService.instance;
cryptoService.initAlgo(rsaAlgo);
```

3. Use the decrypt method of the CryptoService instance to decrypt encrypted content. 

```dart
final decryptedContent = await cryptoService.decrypt(encryptedContent);
```
4. Parse and utilize the decryptedContent string after decryption. Here is the sample usage: 

```dart
Map<String, dynamic> decryptedJson = json.decode(decryptedContent);

// Access decrypted content attributes
final key_a = decryptedJson['key_a'];
final key_b = decryptedJson['key_b'];
```

