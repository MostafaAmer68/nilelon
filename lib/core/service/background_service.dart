import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nilelon/core/service/web_socket.dart';
import 'package:signalr_core/signalr_core.dart';

import '../../features/shared/splash/splash_view.dart';

final service = FlutterBackgroundService();
Future initializeService() async {
  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      isForegroundMode: false,
      initialNotificationTitle: 'Nilelon',
      initialNotificationContent: 'Nilelon Notification',
      autoStart: true,
    ),
    iosConfiguration: IosConfiguration(
      onForeground: onStart,
      onBackground: onIosBackground,
    ),
  );

  await service.startService();
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  Connectivity().onConnectivityChanged.listen((v) {
    if (v.first == ConnectivityResult.none) {
      service.invoke('stop');
    } else {
      service.invoke('start');
    }
  });
  WebSocketNilelon().connect();
  if (service is AndroidServiceInstance) {
    // service.setAsForegroundService();
    WebSocketNilelon().connect();
  }
}

@pragma('vm:entry-point')
bool onIosBackground(ServiceInstance service) {
  Connectivity().onConnectivityChanged.listen((v) {
    if (v.first == ConnectivityResult.none) {
      service.invoke('stop');
      log('test');
    } else {
      log('test 1');
      service.invoke('start');
    }
  });
  WidgetsFlutterBinding.ensureInitialized();
  WebSocketNilelon().connect();
  return true;
}
