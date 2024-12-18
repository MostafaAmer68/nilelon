import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nilelon/core/data/hive_stroage.dart';
import 'package:nilelon/core/tools.dart';
import 'package:nilelon/my_app.dart';
import 'package:nilelon/core/service/set_up_locator_service.dart';
import 'package:nilelon/core/service/simple_bloc_observer.dart';
import 'package:paymob_payment/paymob_payment.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_preview/device_preview.dart';
import 'core/service/background_service.dart';
import 'core/service/notification_service.dart';
import 'core/service/web_socket.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveStorage.init().then((v) async {
    PaymobPayment.instance.initialize(
      apiKey:
          'ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SmpiR0Z6Y3lJNklrMWxjbU5vWVc1MElpd2ljSEp2Wm1sc1pWOXdheUk2TVRBd056Z3hPU3dpYm1GdFpTSTZJbWx1YVhScFlXd2lmUS4zRmFUeWYybWM3WmFKYTJ3LXR5NFktMzJyVmViZHNqNVdfZVd4NHJvZGZJRnRHam9vWlRfRDVpV28xcFVGZndDVmhKQU1fQ3h6YzVDX1VBZnlLbDRNQQ==',
      integrationID: 4884340,
      iFrameID: 883051,
    );

    await requestPermissions();

    final result = await Permission.notification.request();
    if (result.isGranted) {
      await NotificatoinService().initializeNotification();
    } else {
      final result = await Permission.notification.request();
      if (result.isGranted) {
        await NotificatoinService().initializeNotification();
      }
    }

    final status = await Permission.storage.request();
    if (status.isDenied) {}

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
  });

  Connectivity().onConnectivityChanged.listen((v) async {
    if (v.first == ConnectivityResult.none) {
      service.invoke('stop');
      FlutterBackgroundService().invoke('stop');
      service.on('stop').listen((v) {
        log('background stopped');
        print(v);
      });
      log('test');
    } else {
      log('test 23');
      if (!(await FlutterBackgroundService().isRunning())) {
        service.startService();
      }
    }
  });
  if (!(await FlutterBackgroundService().isRunning())) {
    initializeService();
    WebSocketNilelon().connect();
  }
  runApp(DevicePreview(
    enabled: false,
    builder: (_) => const MyApp(),
  ));
}
