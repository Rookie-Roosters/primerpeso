import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StoredTokens {
  const StoredTokens({required this.accessToken, required this.refreshToken});

  final String accessToken;
  final String refreshToken;
}

class SecureTokenStorage {
  SecureTokenStorage() : _storage = const FlutterSecureStorage();

  final FlutterSecureStorage _storage;

  static const _accessTokenKey = 'primerpeso.access_token';
  static const _refreshTokenKey = 'primerpeso.refresh_token';

  String? _memoryAccessToken;
  String? _memoryRefreshToken;

  Future<StoredTokens?> read() async {
    try {
      final accessToken = await _storage.read(key: _accessTokenKey);
      final refreshToken = await _storage.read(key: _refreshTokenKey);
      if (accessToken == null || refreshToken == null) return null;
      return StoredTokens(accessToken: accessToken, refreshToken: refreshToken);
    } on MissingPluginException {
      if (_memoryAccessToken == null || _memoryRefreshToken == null) {
        return null;
      }
      return StoredTokens(
        accessToken: _memoryAccessToken!,
        refreshToken: _memoryRefreshToken!,
      );
    }
  }

  Future<void> write({
    required String accessToken,
    required String refreshToken,
  }) async {
    try {
      await _storage.write(key: _accessTokenKey, value: accessToken);
      await _storage.write(key: _refreshTokenKey, value: refreshToken);
    } on MissingPluginException {
      _memoryAccessToken = accessToken;
      _memoryRefreshToken = refreshToken;
    }
  }

  Future<void> clear() async {
    try {
      await _storage.delete(key: _accessTokenKey);
      await _storage.delete(key: _refreshTokenKey);
    } on MissingPluginException {
      _memoryAccessToken = null;
      _memoryRefreshToken = null;
    }
  }
}
