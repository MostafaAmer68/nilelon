import 'dart:developer';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:nilelon/core/service/failure_service.dart';

/// @introduction This is introduction
///
/// @description This is description\n this sentences will show next row

class ApiService {
  final Dio dio;

  ApiService({
    required this.dio,
  }) {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // Before the request is sent
        log("Request [${options.method}] => PATH: ${options.baseUrl}${options.path}");
        log("Request [${options.method}] => Data: ${(options.data)}");
        log("Request [${options.method}] => Query: ${options.queryParameters}");
        // You can add headers or modify the request here
        // options.headers["Authorization"] = "Bearer YOUR_TOKEN";

        return handler.next(options); // Continue
      },
      onResponse: (response, handler) {
        // When the response is received
        log("Response [${response.statusCode}] => DATA: ${response.data}");
        return handler.next(response); // Continue
      },
      onError: (DioException e, handler) {
        // When an error occurs
        log("Error [${e.response?.statusCode}] => MESSAGE: ${e.response?.data}");
        // You can handle token refresh or other error handling here
        return handler.next(e); // Continue
      },
    ));
    dio.options.copyWith(
      validateStatus: (status) {
        return getStatus(status!);
      },
    );
  }

  Stream<bool> isConnected() {
    return Connectivity()
        .onConnectivityChanged
        .map((e) => e.first == ConnectivityResult.none);
  }

  Future<Response> get({required String endPoint, body, query}) async {
    if ((await Connectivity().checkConnectivity()).first ==
        ConnectivityResult.none) {
      throw 'no internet';
    }
    var response = await dio.get(
      endPoint,
      data: body,
      queryParameters: query,
    );
    return response;
  }

  Future<Response> post(
      {required String endPoint, dynamic body, dynamic query}) async {
    if ((await Connectivity().checkConnectivity()).first ==
        ConnectivityResult.none) {
      throw 'no internet';
    }
    final response = await dio.post(
      endPoint,
      data: body,
      queryParameters: query,
    );
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

  Future<Response> put({required endPoint, dynamic body, dynamic query}) async {
    if ((await Connectivity().checkConnectivity()).first ==
        ConnectivityResult.none) {
      throw 'no internet';
    }

    var response = await dio.put(endPoint, data: body, queryParameters: query);
    return response;
  }

  Future<Response> delete({
    required endPoint,
    dynamic body,
    dynamic query,
  }) async {
    if ((await Connectivity().checkConnectivity()).first ==
        ConnectivityResult.none) {
      throw 'no internet';
    }
    var response = await dio.delete(
      endPoint,
      data: body,
      queryParameters: query,
    );
    return response;
  }
}
