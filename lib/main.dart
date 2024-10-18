import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nilelon/core/data/hive_stroage.dart';
import 'package:nilelon/my_app.dart';
import 'package:nilelon/core/service/set_up_locator_service.dart';
import 'package:nilelon/core/service/simple_bloc_observer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:signalr_core/signalr_core.dart';

import 'core/service/notification_service.dart';

final connection = HubConnectionBuilder()
    .withUrl(
      'http://nilelon.somee.com/NileonHub',
      // HttpConnectionOptions(transport: HttpTransportType.longPolling)
      HttpConnectionOptions(
        transport: HttpTransportType
            .longPolling, //serverSentEvents, //(Only when I uncomment this line then I can make connection)
        logging: (level, message) {},
      ),
    )
    .withAutomaticReconnect()
    .build();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveStorage.init();
  final result = await Permission.notification.request();
  if (result.isGranted) {
    await NotificatoinService().initializeNotification();
  } else {
    final result = await Permission.notification.request();
    if (result.isGranted) {
      await NotificatoinService().initializeNotification();
    }
  }
  connection.serverTimeoutInMilliseconds = 60000;
  await connection.start()?.catchError((error) {}).whenComplete(() {
    HiveStorage.set(HiveKeys.connectionId, connection.connectionId);
  });
  connection.on('MissYou', (message) {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 10,
        channelKey: 'basic_channel',
        actionType: ActionType.Default,
        title: 'Miss you',
        body: message!.first.toString(),
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

  if (HiveStorage.get(HiveKeys.isArabic) == null) {
    HiveStorage.set(
      HiveKeys.isArabic,
      false,
    );
  }
  Bloc.observer = SimpleBlocObserver();
  setUpLocatorService();
  if (HiveStorage.get(HiveKeys.skipOnboarding) == null) {
    HiveStorage.set(HiveKeys.skipOnboarding, false);
  }
  runApp(DevicePreview(
    enabled: false,
    builder: (context) => const MyApp(),
  ));
}
