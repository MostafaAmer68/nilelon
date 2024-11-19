import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nilelon/core/data/hive_stroage.dart';
import 'package:nilelon/core/service/background_service.dart';
import 'package:nilelon/my_app.dart';
import 'package:nilelon/core/service/set_up_locator_service.dart';
import 'package:nilelon/core/service/simple_bloc_observer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_preview/device_preview.dart';
import 'core/service/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveStorage.init();
  await initializeService();
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

  runApp(DevicePreview(
    enabled: true,
    builder: (_) => const MyApp(),
  ));
}
