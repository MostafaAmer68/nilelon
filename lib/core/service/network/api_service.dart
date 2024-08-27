import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';

class ApiService {
  final Dio dio;

  ApiService({
    required this.dio,
  }) {
    dio.interceptors.add(CustomLogInterceptor());
    dio.options.copyWith(
      validateStatus: (status) {
        return getStatus(status!);
      },
    );
  }

  Future<Response> get({required String endPoint, query}) async {
    var response = await dio.get(
      endPoint,
      queryParameters: query,
    );
    return response;
  }

  Future<Response> post(
      {required String endPoint, dynamic body, dynamic query}) async {
    final response = await dio.post(
      endPoint,
      data: body,
      queryParameters: query,
    );
    print(response.data);
    return response;
  }

  bool getStatus(int status) {
    return status == HttpStatus.ok ||
        status == HttpStatus.created ||
        status == HttpStatus.noContent ||
        status == HttpStatus.badRequest ||
        status == HttpStatus.unauthorized ||
        status == HttpStatus.notFound ||
        status == HttpStatus.internalServerError;
  }

  Future<Response> put({
    required endPoint,
    dynamic data,
  }) async {
    var response = await dio.put(
      endPoint,
      data: data,
    );
    return response;
  }

  Future<Response> delete({
    required endPoint,
    dynamic body,
    dynamic query,
  }) async {
    var response = await dio.delete(
      endPoint,
      data: body,
      queryParameters: query,
    );
    return response;
  }
}

class CustomLogInterceptor extends LogInterceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Log request URL and headers
    print('--> ${options.method} ${options.uri}');
    options.headers.forEach((key, value) {
      print('$key: $value');
    });

    // Log request body if it's present
    if (options.data != null) {
      print('Request body: ${options.data}');
    }
    super.onRequest(options, handler);
  }
}
