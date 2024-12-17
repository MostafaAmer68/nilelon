import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nilelon/features/notification/data/models/notification_data.dart';
import 'package:nilelon/features/notification/data/repositories/notifiy_repo_impl.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  static NotificationCubit get(context) => BlocProvider.of(context);
  final NotifyRepoImpl _impl;
  NotificationCubit(this._impl) : super(NotificationInitial());

  List<NotificationData> notificatios = [];

  Future<void> getAllNotification() async {
    emit(NotificationLoading());
    try {
      final result = await _impl.getAllNotification();

      result.fold(
        (err) {
          emit(Notificationfailure(err.errorMsg));
        },
        (res) {
          notificatios = res;
          emit(NotificationSuccess());
        },
      );
    } catch (e) {
      emit(Notificationfailure(e.toString()));
    }
  }

  Future<void> markNotifyAsRead(String id) async {
    emit(NotificationLoading());
    // if (id.isEmpty) {
    //   for (var item in notificatios) {
    //     if (!item.isRead) {
    //       final result = await _impl.markNotifyAsRead(item.id);

    //       result.fold(
    //         (err) {
    //           emit(Notificationfailure(err.errorMsg));
    //         },
    //         (res) {
    //           if (item == notificatios.last) {
    //             getAllNotification();
    //           }
    //         },
    //       );
    //     }
    //   }
    // }
    final result = await _impl.markNotifyAsRead(id);

    result.fold(
      (err) {
        emit(Notificationfailure(err.errorMsg));
      },
      (res) {
        getAllNotification();
      },
    );
    try {} catch (e) {
      emit(Notificationfailure(e.toString()));
    }
  }
}
