import 'package:dartz/dartz.dart';
import 'package:nilelon/core/service/catch_func.dart';
import 'package:nilelon/core/service/failure_service.dart';
import 'package:nilelon/features/notification/data/datasources/notification_remote.dart';
import 'package:nilelon/features/notification/data/models/notification_data.dart';
import 'package:nilelon/features/notification/domain/repositories/notify_repo.dart';

class NotifyRepoImpl implements NotifyRepo {
  final NotificationRemote _remote;

  NotifyRepoImpl(this._remote);

  @override
  Future<Either<ServerFailure, List<NotificationData>>>
      getAllNotification() async {
    return exe(() => _remote.getAllNotification());
  }

  @override
  Future<Either<ServerFailure, void>> markNotifyAsRead(String id) {
    return exe(() => _remote.markNotifyAsRead(id));
  }
}
