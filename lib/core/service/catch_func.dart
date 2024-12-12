import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:nilelon/core/service/failure_service.dart';

Future<Either<ServerFailure, T>> exe<T>(Future<T> Function() function) async {
  try {
    final result = await function();
    return Right(result);
  } on DioException catch (e) {
    if (e.response!.statusCode == 401) {
      return left(ServerFailure(e.response!.data));
    }

    return left(e.response!.data);
  } catch (e) {
    return left(ServerFailure(e.toString()));
  }
}
