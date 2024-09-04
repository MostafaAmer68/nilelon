import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nilelon/config/language_bloc/switch_language_bloc.dart';
import 'package:nilelon/core/data/hive_stroage.dart';
import 'package:nilelon/my_app.dart';
import 'package:nilelon/core/service/set_up_locator_service.dart';
import 'package:nilelon/core/service/simple_bloc_observer.dart';
import 'package:signalr_core/signalr_core.dart';

final connection = HubConnectionBuilder()
    .withUrl(
      'http://nilelon.somee.com/NileonHub',
      // HttpConnectionOptions(transport: HttpTransportType.longPolling)
      HttpConnectionOptions(
        transport: HttpTransportType
            .longPolling, //serverSentEvents, //(Only when I uncomment this line then I can make connection)
        logging: (level, message) => print('test: $message'),
      ),
    )
    .withAutomaticReconnect()
    .build();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveStorage.init();
  connection.serverTimeoutInMilliseconds = 60000;
  await connection.start()?.catchError((error) {
    print('Connection failed to start: $error');
  }).whenComplete(() {
    HiveStorage.set(HiveKeys.connectionId, connection.connectionId);
  });
  connection.on('MissYou', (message) {
    print('New message: $message');
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

// Starting the connection

  // await connection.start();
  print('Connection established');
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
