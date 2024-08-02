import 'package:dio/dio.dart';
import 'package:nilelon/service/network/end_point.dart';

class ApiService {
  final Dio dio;

  ApiService({
    required this.dio,
  });

  // Future<Map<String, dynamic>> getWithToken({
  //   required String endPoint,
  //   required String token,
  //   Map<String, dynamic>? query,
  // }) async {
  //   dio.options.headers = {
  //     "Authorization": 'Bearer $token',
  //   };
  //   var response = await dio.get(
  //     '${EndPoint().baseUrl}$endPoint',
  //     queryParameters: query,
  //     options: Options(
  //       validateStatus: (status) {
  //         return status! == 200 || status == 201 || status == 400;
  //       },
  //     ),
  //   );
  //   return response.data;
  // }

  Future<dynamic> get({required String endPoint}) async {
    dio.interceptors.add(CustomLogInterceptor());

    var response = await dio.get(
      '${EndPoint.baseUrl}$endPoint',
      options: Options(
        validateStatus: (status) {
          return status! == 200 ||
              status == 201 ||
              status == 204 ||
              status == 400 ||
              status == 401 ||
              status == 404;
        },
      ),
    );
    return response;
  }

  // Future<Map<String, dynamic>> postWithToken({
  //   required String endPoint,
  //   required dynamic body,
  //   required String token,
  // }) async {
  //   dio.options.headers = {
  //     "Authorization": 'Bearer $token',
  //   };
  //   var response = await dio.post(
  //     '${EndPoint().baseUrl}$endPoint',
  //     data: body,
  //     options: Options(
  //       validateStatus: (status) {
  //         return status! == 200 || status == 201 || status == 400;
  //       },
  //     ),
  //   );
  //   return response.data;
  // }

  Future<Response> postAuth(
      {required String endPoint, dynamic body, dynamic query}) async {
    dio.interceptors.add(CustomLogInterceptor());

    final response = await dio.post(
      '${EndPoint.baseUrl}$endPoint',
      data: body,
      queryParameters: query,
      options: Options(
        validateStatus: (status) {
          return status! == 200 ||
              status == 201 ||
              status == 204 ||
              status == 400 ||
              status == 401 ||
              status == 404 ||
              status == 500;
        },
      ),
    );
    return response;
  }

  Future<dynamic> put({
    required endPoint,
    dynamic data,
  }) async {
    dio.interceptors.add(CustomLogInterceptor());

    var response = await dio.put(
      '${EndPoint.baseUrl}$endPoint',
      options: Options(
        validateStatus: (status) {
          return status! == 200 ||
              status == 201 ||
              status == 204 ||
              status == 400 ||
              status == 401 ||
              status == 404;
        },
      ),
      data: data,
    );
    return response;
  }

  Future<dynamic> delete({
    required endPoint,
    dynamic body,
  }) async {
    dio.interceptors.add(CustomLogInterceptor());

    var response = await dio.delete(
      '${EndPoint.baseUrl}$endPoint',
      data: body,
      options: Options(
        validateStatus: (status) {
          return status! == 200 ||
              status == 201 ||
              status == 204 ||
              status == 400 ||
              status == 401 ||
              status == 404;
        },
      ),
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
