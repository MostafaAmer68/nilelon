import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nilelon/config/language_bloc/switch_language_bloc.dart';
import 'package:nilelon/core/data/hive_stroage.dart';
import 'package:nilelon/my_app.dart';
import 'package:nilelon/core/service/set_up_locator_service.dart';
import 'package:nilelon/core/service/simple_bloc_observer.dart';
import 'package:signalr_core/signalr_core.dart';

final connection = HubConnectionBuilder()
    .withUrl('http://nilelon.somee.com/NilelonHub',
        HttpConnectionOptions(transport: HttpTransportType.longPolling))
    .build();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveStorage.init();

  // connection.on('NewStoreRegister', (message) {
  //   print('New message: $message');
  // });
  // await connection.start();
  // print('Connection established');
  // await CacheService.init();
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
  runApp(BlocProvider(
    create: (context) => SwitchLanguageCubit(),
    child: const MyApp(), // Wrap your app
  ));
}
