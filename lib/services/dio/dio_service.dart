import 'package:dio/dio.dart';
import 'package:fresh_dio/fresh_dio.dart';
import 'package:mytt_front/services/auth_service.dart';
import 'package:mytt_front/services/dio/GeneralInterceptor.dart';
import 'package:mytt_front/services/dio/PersistantTokenStorage.dart';

class DioService {
  static Dio _dio = Dio();

  static const url = 'http://192.168.56.1:3000/';

  static final _fresh = Fresh.oAuth2(
    tokenStorage: PersistantTokenStorage(),
    refreshToken: (token, client) async {
      print('refreshing token...');
      try {
        var response = await AuthService.getAcessToken(token?.refreshToken);
        print("refresh response");
        print(response);
        String? newAccessToken = response['accessToken'];
        if (newAccessToken == null) throw RevokeTokenException();
        return OAuth2Token(
          accessToken: newAccessToken,
          refreshToken: token?.refreshToken,
        );
      } catch (e) {
        print(e);
        throw RevokeTokenException();
      }
    },
  );

  static Future refreshToken() async {
    try {
      var token = await _fresh.token;
      var response = await AuthService.getAcessToken(token?.refreshToken);
      print("refresh response");
      print(response);
      String? newAccessToken = response['accessToken'];
      if (newAccessToken == null) throw RevokeTokenException();

      await _fresh.setToken(OAuth2Token(
        accessToken: newAccessToken,
        refreshToken: token?.refreshToken,
      ));
      return;
    } catch (e) {
      print(e);
      throw RevokeTokenException();
    }
  }

  static Future<bool> hasToken() async {
    var token = await _fresh.token;
    return token != null;
  }

  DioService._();

  static Future initService() async {
    _dio = new Dio();
    _fresh.setToken(await PersistantTokenStorage().read());
    _dio.interceptors.add(_fresh);
    _dio.interceptors.add(GeneralInterceptor());
    _dio.interceptors.add(DefaultInterceptor());
  }

  static void setToken({
    required String accessToken,
    required String? refreshToken,
  }) {
    print("accessToken=$accessToken");
    print("refreshToken=$refreshToken");
    _fresh.setToken(
        OAuth2Token(accessToken: accessToken, refreshToken: refreshToken));
  }

  static Dio get dio {
    return _dio;
  }

  static void clearToken() {
    _fresh.clearToken();
  }
}

class DefaultInterceptor extends Interceptor {
  @override
  Future<dynamic> onError(error, handler) async {
    handler.reject(error);
  }
}