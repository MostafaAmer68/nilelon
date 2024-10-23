import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:signalr_core/signalr_core.dart';

import 'web_socket.dart';

class BackgroundService {
  final service = FlutterBackgroundService();

  final connection = HubConnectionBuilder()
      .withUrl(
        'http://nilelon.somee.com/NileonHub',
        HttpConnectionOptions(
          transport: HttpTransportType.longPolling,
          logging: (level, message) {},
        ),
      )
      .withAutomaticReconnect()
      .build();

  String notificationChannelId = 'basic_channel';

// this will be used for notification id, So you can update your custom notification with this id.
  String notificationId = '888';

  Future initializeBackgroundService() async {
    await initializeNotification().then((_) async {
      await service.configure(
        iosConfiguration: IosConfiguration(
          autoStart: true,
          onForeground: onStart,
          onBackground: onIosBackground,
        ),
        androidConfiguration: AndroidConfiguration(
          onStart: onStart,
          isForegroundMode: false,
          autoStartOnBoot: true,
          notificationChannelId: notificationChannelId,
          initialNotificationTitle: 'AWESOME SERVICE',
          initialNotificationContent: 'Initializing',
          foregroundServiceNotificationId: int.parse(notificationId),
          autoStart: true,
        ),
      );
    });

    service.startService();
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future initializeNotification() async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
      notificationChannelId,
      'MY FOREGROUND SERVICE',
      description: 'This channel is used for important notifications.',
      importance: Importance.low,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  @pragma('vm:entry-point')
  static onStart(ServiceInstance service) {
    // Only available for flutter 3.0.0 and later
    DartPluginRegistrant.ensureInitialized();

    BackgroundService().initializeWebSocket(service);
  }

  @pragma('vm:entry-point')
  static Future<bool> onIosBackground(ServiceInstance service) async {
    WidgetsFlutterBinding.ensureInitialized();
    DartPluginRegistrant.ensureInitialized();
    BackgroundService().initializeWebSocket(service);
    return true;
  }

  Future initializeWebSocket(service) async {
    connection.serverTimeoutInMilliseconds = 60000;
    await connection
        .start()
        ?.catchError(
          (error) {},
        )
        .whenComplete(
      () {
        // HiveStorage.set(HiveKeys.connectionId, connection.connectionId);
      },
    );
    flutterLocalNotificationsPlugin.show(
      888,
      'background service',
      'background service is enabled',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'basic_channel',
          'MY FOREGROUND SERVICE',
          icon: 'ic_bg_service_small',
          ongoing: true,
        ),
      ),
    );
    connection.on('MissYou', (message) async {
      flutterLocalNotificationsPlugin.show(
        888,
        'Miss you',
        message!.first.toString(),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'basic_channel',
            'MY FOREGROUND SERVICE',
            icon: 'ic_bg_service_small',
            ongoing: true,
          ),
        ),
      );
    });
    connection.onclose((error) {
      print('Connection closed: $error');
    });

    connection.onreconnecting((error) {
      print('Connection lost, attempting to reconnect: $error');
    });

    connection.onreconnected((connectionId) {
      print('Reconnected with connection ID: $connectionId');
    });
  }
}
