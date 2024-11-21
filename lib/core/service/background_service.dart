import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:signalr_core/signalr_core.dart';

Future initializeService() async {
  final service = FlutterBackgroundService();

  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      isForegroundMode: false,
      autoStart: true,
    ),
    iosConfiguration: IosConfiguration(
      onForeground: onStart,
      onBackground: onIosBackground,
    ),
  );

  await service.startService();
}

final HubConnection connection = HubConnectionBuilder()
    .withUrl(
      'http://nilelon.somee.com/NileonHub',
      HttpConnectionOptions(
        transport: HttpTransportType.longPolling,
        logging: (level, message) {},
      ),
    )
    .withAutomaticReconnect()
    .build();

Future initializeWebSocket() async {
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
  //USER NOTIFICATION
  connection.on('ReceiveMissedNotification', (message) async {
    log(message!.toString());
    showAwesomeNotification(
        message.first.toString(), message.first.toString());
  });
  connection.on('MissYou', (message) async {
    log(message!.toString());
    showAwesomeNotification(
        message.first.toString(), message.first.toString());
  });
  connection.on('ProductTopSeller', (message) async {
    final productIdr = message!.first;
    final body = message[1];
    log(message.toString());
    showAwesomeNotification(body, 'Top Seller');
  });
  //END USER NOTIFICATION

  //CUSTOMER NOTIFCATION
  connection.on('FillFeedback', (message) async {
    log(message!.toString());
    final url = message.first;
    final body = message[1];
    showAwesomeNotification(body, 'Feedback');
  });
  connection.on('StoreAddProduct', (message) async {
    final productId = message![1];
    final productPic = message[0];
    final productName = message[2];
    final body = message[3];
    log(message.toString());
    showAwesomeNotification(body, 'Store add product');
  });
  connection.on('StoreSaleProduct', (message) async {
    final discount = message!.first;
    final body = message[1];
    log(message.toString());
    showAwesomeNotification(body, 'Big Sale');
  });
  connection.on('ChangeOrderStatus', (message) async {
    final orderId = message!.first;
    final status = message[1];
    final body = message[2];
    log(message.toString());
    showAwesomeNotification(body, 'Order Update');
  });
  connection.on('NewStoreRegister', (message) async {
    final storeName = message!.first;
    final body = message[1];
    log(message.toString());
    showAwesomeNotification(body, 'New Store');
  });
  connection.on('AdminNewStoreRegister', (message) async {
    final storeEmail = message!.first;
    final body = message[1];
    log(message.toString());
    showAwesomeNotification(body, 'New Store');
  });
  //END CUSTOMER NOTIFCATION

  //STORE NOTIFCATION
  connection.on('ProductWillEmpty', (message) async {
    final id = message![0];
    final color = message[1];
    final size = message[2];
    final qun = message[3];
    final body = message[4];

    log(message.toString());
    showAwesomeNotification(body, 'Product Update');
  });
  connection.on('OrderCome', (message) async {
    final orderId = message!.first;
    final body = message[2];
    log(message.toString());
    showAwesomeNotification(body, 'New Order');
  });

  //END STORE NOTIFCATION

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

void onStart(ServiceInstance service) async {
  if (service is AndroidServiceInstance) {
    service.setAsForegroundService();
    initializeWebSocket();
  }
}

bool onIosBackground(ServiceInstance service) {
  WidgetsFlutterBinding.ensureInitialized();
  initializeWebSocket();
  return true;
}

Future<void> showAwesomeNotification(String message, String title) async {
  AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
      channelKey: 'basic_channel',
      title: title,
      // icon: Assets.assetsImagesLogo,
      body: message,
      notificationLayout: NotificationLayout.Default,
    ),
  );
}
