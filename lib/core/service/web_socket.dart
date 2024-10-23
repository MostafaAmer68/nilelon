import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:signalr_core/signalr_core.dart';

class WebSocketNilelon {
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
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    connection.on('MissYou', (message) async {
      // bring to foreground
      if (service is AndroidServiceInstance) {
        // if (await service.isForegroundService()) {
        flutterLocalNotificationsPlugin.show(
          888,
          'Miss you',
          message!.first.toString(),
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'basic_channel',
              'MY FOREGROUND SERVICE',
              icon: null,
              ongoing: true,
            ),
          ),
        );
        // }
      }
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
