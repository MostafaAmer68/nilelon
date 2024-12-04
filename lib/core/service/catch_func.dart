import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:nilelon/core/service/failure_service.dart';

Future<Either<ServerFailure, T>> exe<T>(Future<T> Function() function) async {
  try {
    final result = await function();
    return Right(result);
  } on DioException catch (e) {
    return left(ServerFailure.fromResponse(
        e.response!.data['statusCode'], e.response!.data['errorMessages'][0]));
  } catch (e) {
    return left(ServerFailure(e.toString()));
  }
}
