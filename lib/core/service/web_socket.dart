import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nilelon/core/service/notification_service.dart';
import 'package:signalr_core/signalr_core.dart';

import '../../features/shared/splash/splash_view.dart';

class WebSocketNilelon {
  Future connect() async {
    connection = HubConnectionBuilder()
        .withUrl(
          'http://nilelon.somee.com/NileonHub',
          HttpConnectionOptions(
            transport: HttpTransportType.longPolling,
            accessTokenFactory: () async {
              final token =
                  await const FlutterSecureStorage().read(key: 'token');
              return token ?? '';
            },
          ),
        )
        .withAutomaticReconnect()
        .build();

    connection.serverTimeoutInMilliseconds = 60000;
    await connection.start()?.catchError(
      (error) {
        log(error.toString());
      },
    ).whenComplete(
      () {
        onConnect();
      },
    );
  }

  void disconnect() {
    connection.stop();
  }

  void onConnect() {
    connection.on('NewStoreRegister', (message) async {
      if (message == null) return;
      final body = message.first['message'];
      showAwesomeNotification(body, 'New Store', null);
    });
    //!USER NOTIFICATION
    connection.on('ReceiveMissedNotification', (message) async {
      log(message!.toString());
      showAwesomeNotification(
          message.first.toString(), message.first.toString(), null);
    });
    connection.on('MissYou', (message) async {
      if (message == null) return;
      log(message.toString());
      showAwesomeNotification(
          message.first.toString(), message.first.toString(), null);
    });
    connection.on('ProductTopSeller', (message) async {
      if (message == null) return;
      final productId = message[0]['productId'];
      final productName = message[0]['productName'];
      final body = message[0]['message'];
      log(message.toString());
      showAwesomeNotification(body, 'Top Seller', {
        'productId': productId,
        'productName': productName,
        'type': 'ProductTopSeller',
      });
    });
    //!END USER NOTIFICATION

    //~CUSTOMER NOTIFCATION
    connection.on('FillFeedback', (message) async {
      if (message == null) return;
      log(message.toString());
      final url = message.first['url'];
      final body = message[0]['message'];
      showAwesomeNotification(body, 'Feedback', {
        'url': url,
      });
    });
    connection.on('StoreAddProduct', (message) async {
      if (message == null) return;
      final productId = message.first['productId'];
      final storePic = message.first['storePic'];
      final productName = message.first['productName'];
      final storeName = message.first['storeName'];
      final body = message.first['message'];
      log(message.toString());
      showAwesomeNotification(body, 'Store add product', {
        'productId': productId,
        'productName': productName,
        'storePic': storePic,
        'storeName': storeName,
        'type': 'StoreAddProduct',
      });
    });
    connection.on('StoreSaleProduct', (message) async {
      if (message == null) return;
      final discount = message.first['discount'];
      final product = message.first['producdt'];
      final body = message.first['message'];
      log(message.toString());
      showAwesomeNotification(body, 'Big Sale', {
        'discount': discount,
        'product': product,
        'productSize': product['size'],
        'productId': product['productId'],
        'ProductColor': product['color'],
        'type': 'StoreSaleProduct',
      });
    });
    connection.on('ChangeOrderStatus', (message) async {
      if (message == null) return;
      final orderId = message.first['orderId'];
      final status = message.first['status'];
      final body = message.first['message'];
      log(message.toString());
      showAwesomeNotification(body, 'Order Update', {
        'orderId': orderId,
        'status': status,
        'type': 'order',
      });
    });

    // connection.on('AdminNewStoreRegister', (message) async {
    //   if (message == null) return;
    //   final storeEmail = message.first;
    //   final body = message.first;
    //   log(message.toString());
    //   showAwesomeNotification(body, 'New Store',{
    //     'storeEmail'
    //   });
    // });
    //~END CUSTOMER NOTIFCATION

    //^STORE NOTIFCATION
    connection.on('ProductWillEmpty', (message) async {
      if (message == null) return;
      final id = message.first['id'];
      final color = message.first['color'];
      final size = message.first['size'];
      final qun = message.first['quantity'];
      final body = message.first['message'];

      showAwesomeNotification(body, 'Product Rare', {
        'id': id,
        'color': color,
        'size': size,
        'qun': qun,
        'type': 'ProductWillEmpty',
      });
    });

    connection.on('OrderCome', (message) async {
      log('message');
      log(message!.first.toString());
      if (message == null) return;
      final orderId = message.first['orderId'];
      final body = message.first['message'];
      showAwesomeNotification(body, 'New Order', {
        'orderId': orderId,
        'type': 'order',
      });
    });

    //^END STORE NOTIFCATION

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
