import 'dart:io';

import 'package:nilelon/core/data/hive_stroage.dart';
import 'package:nilelon/core/service/network/api_service.dart';
import 'package:nilelon/core/service/network/end_point.dart';
import 'package:nilelon/features/auth/domain/model/user_model.dart';

import '../models/notification_data.dart';

class NotificationRemote {
  final ApiService _apiService;

  NotificationRemote(this._apiService);

  Future<List<NotificationData>> getAllNotification() async {
    final response = await _apiService.get(
      endPoint: EndPoint.getAllNotification,
      query: {
        'userId': HiveStorage.get<UserModel>(HiveKeys.userModel).id,
      },
    );
    if (response.statusCode == HttpStatus.ok) {
      return List<NotificationData>.from(
          response.data.map((e) => NotificationData.fromMap(e)));
    }
    throw Exception(response.data['errorMessages']);
  }

  Future<void> markNotifyAsRead(String id) async {
    final response = await _apiService.get(
      endPoint: EndPoint.markNotifyAsRead,
      query: {
        'id': id,
      },
    );
    if (response.statusCode == HttpStatus.ok) {}
    throw Exception(response.data['errorMessages']);
  }
}
