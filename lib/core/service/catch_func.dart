import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:nilelon/core/service/failure_service.dart';

Future<Either<ServerFailure, T>> exe<T>(Future<T> Function() function) async {
  try {
    final result = await function();
    return Right(result);
  } catch (e) {
    if (e is DioException) {
      return left(ServerFailure.fromDioException(e));
    }
    return left(ServerFailure(e.toString()));
  }
}
