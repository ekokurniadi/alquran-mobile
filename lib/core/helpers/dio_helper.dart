import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@injectable
class DioHelper {
  static Dio? dio;

  static void initialDio(String baseUrl) {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: 20000,
        receiveTimeout: 40000,
        contentType: 'application/json',
        responseType: ResponseType.json,
      ),
    );
  }

  static void setDioLogger(String baseUrl) {
    dio!.interceptors.add(
      InterceptorsWrapper(
        onResponse: (response, responseInterceptorHandler) {
          log('${response.statusCode}');
          return responseInterceptorHandler.next(response);
        },
        onRequest: (request, requestInterceptorHandler) {
          log('${request.method} - ${request.path}');
          return requestInterceptorHandler.next(request);
        },
        onError: (DioError error, errorInterceptor) {
          log(error.message);
          return errorInterceptor.next(error);
        },
      ),
    );
  }

  static setDioHeader(String? token) {
    dio!.options.headers = {HttpHeaders.authorizationHeader: 'Bearer $token'};
    log('token user: $token');
  }
}
