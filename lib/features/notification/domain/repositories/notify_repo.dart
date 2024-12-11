import 'package:dartz/dartz.dart';
import 'package:nilelon/core/service/failure_service.dart';
import 'package:nilelon/features/notification/data/models/notification_data.dart';

abstract class NotifyRepo {
  Future<Either<ServerFailure, List<NotificationData>>> getAllNotification();
  Future<Either<ServerFailure, void>> markNotifyAsRead(String id);
}
