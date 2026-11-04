import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock)
  );

  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';

  Future<void> saveTokens ({required String accessToken, required String refreshToken}) async{
    await _secureStorage.write(key: _accessTokenKey, value: accessToken);
    if (refreshToken != null) {
      await _secureStorage.write(key: _refreshTokenKey, value: refreshToken);
    }
  }

  Future<String?> getAccessToken() async{
    return await _secureStorage.read(key: _accessTokenKey);
  }

  Future<String?> getRefreshToken() async{
    return await _secureStorage.read(key: _refreshTokenKey);
  }

  Future<void> clearTokens() async{
    await _secureStorage.deleteAll();
  }

}