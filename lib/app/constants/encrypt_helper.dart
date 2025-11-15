import 'package:encrypt/encrypt.dart' as encrypt;

class EncryptionHelper {
  final encrypt.Key key;
  final encrypt.IV iv;
  final encrypt.Encrypter encrypter;

  EncryptionHelper(String keyString, String ivString)
      : key = encrypt.Key.fromUtf8(keyString),
        iv = encrypt.IV.fromUtf8(ivString),
        encrypter = encrypt.Encrypter(encrypt.AES(encrypt.Key.fromUtf8(keyString)));

  String encryptMessage(String message) {
    final encrypted = encrypter.encrypt(message, iv: iv);
    return encrypted.base64;
  }

  String decryptMessage(String encryptedMessage) {
    final decrypted = encrypter.decrypt64(encryptedMessage, iv: iv);
    return decrypted;
  }
}
