import 'package:fresh_dio/fresh_dio.dart';
import 'package:mytt_front/services/dio/secure_storage_service.dart';

class PersistantTokenStorage extends TokenStorage<OAuth2Token> {
  @override
  Future<void> delete() async {
    SecureStorageService.clearList([
      'accessToken',
      'refreshToken',
      'expiresIn',
      'scope',
      'tokenType',
    ]);
  }

  @override
  Future<OAuth2Token?> read() async {
    final String? accessToken =
        await SecureStorageService.readString('accessToken');
    if (accessToken == null) return null;
    final String? refreshToken =
        await SecureStorageService.readString('refreshToken');
    final int? expiresIn =
        int.tryParse(await SecureStorageService.readString('expiresIn') ?? '');
    final String? scope = await SecureStorageService.readString('scope');
    final String? tokenType =
        await SecureStorageService.readString('tokenType');
    return OAuth2Token(
        accessToken: accessToken,
        expiresIn: expiresIn,
        refreshToken: refreshToken,
        scope: scope,
        tokenType: tokenType);
  }

  @override
  Future<void> write(OAuth2Token token) async {
    print("saving token");
    SecureStorageService.writeMap({
      'accessToken': token.accessToken,
      'expiresIn': token.expiresIn == null ? null : token.expiresIn.toString(),
      'refreshToken': token.refreshToken,
      'scope': token.scope,
      'tokenType': token.tokenType
    });
  }
}
