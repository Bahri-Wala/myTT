import 'package:dio/dio.dart';

class GeneralDioException extends DioError {
  GeneralDioException(DioError dioError, {required this.code, this.message: ''})
      : super(
            requestOptions: dioError.requestOptions,
            response: dioError.response,
            type: dioError.type,
            error: dioError.error);
  final int code;
  final String message;
}
