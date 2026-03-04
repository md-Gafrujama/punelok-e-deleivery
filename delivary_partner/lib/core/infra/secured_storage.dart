// lib/core/storage/secure_storage_service.dart
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static const _storage = FlutterSecureStorage(
    // ignore: deprecated_member_use
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  static const _accessTokenKey = 'accessToken';

  // Token
  static Future<void> saveToken(String token) =>
      _storage.write(key: _accessTokenKey, value: token);

  static Future<String?> getToken() =>
      _storage.read(key: _accessTokenKey);

  static Future<void> deleteToken() =>
      _storage.delete(key: _accessTokenKey);

  static Future<void> clearAll() => _storage.deleteAll();
}