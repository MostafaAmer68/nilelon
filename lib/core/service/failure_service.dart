import 'package:dio/dio.dart';

abstract class FailureService {
  final String errorMsg;

  FailureService(this.errorMsg);
}

class ServerFailure extends FailureService {
  ServerFailure(super.errorMsg);

  factory ServerFailure.fromDioException(DioException dioException) {
    return ServerFailure(
        dioException.response!.data['errorMessages'].toString());
  }

  factory ServerFailure.fromResponse(int? statusCode, String response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(response);
    } else if (statusCode == 404) {
      return ServerFailure(response.isEmpty
          ? 'Your request not found, try again later'
          : response);
    } else if (statusCode == 500) {
      return ServerFailure('Internal server error, try again later!');
    } else {
      return ServerFailure('Opps there was an error, try again later!');
    }
  }
}
