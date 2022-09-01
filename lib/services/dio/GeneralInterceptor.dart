import 'package:dio/dio.dart';
import 'package:fresh_dio/fresh_dio.dart';
import 'GeneralDioException.dart';

class GeneralInterceptor extends Interceptor {
  @override
  Future<dynamic> onError(error, handler) async {
    // if (error.type == DioErrorType.other &&
    //     error.error is RevokeTokenException) {
    //   NavigationService.instance.goToAuthScreen();
    //   handler.reject(error);
    //}
    if (error.message.contains("404")) {
      handler.reject(GeneralDioException(error,
          code: 404, message: error.response?.data.toString() ?? ''));
    } else if (error.message.contains("403")) {
      handler.reject(GeneralDioException(error, code: 403));
    } else if (error.message.contains("420")) {
      handler.reject(GeneralDioException(error,
          code: 420,
          message: /*error.response?.data*/ "placeholder" /* ?? ''*/)); //TODO
    } else {
      handler.next(error);
    }
  }
}
