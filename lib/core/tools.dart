import 'dart:io';

import 'package:android_intent_plus/android_intent.dart';
import 'package:disable_battery_optimization/disable_battery_optimization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:nilelon/core/data/hive_stroage.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/service/background_service.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

import '../features/auth/domain/model/user_model.dart';
import 'widgets/button/button_builder.dart';

SliverGridDelegateWithFixedCrossAxisCount gridDelegate(context) {
  // double screenWidth = MediaQuery.of(context).size.width;
  // int crossAxisCount = (screenWidth / 150).floor();
  return SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 1.sw > 600 ? 3 : 2,
    crossAxisSpacing: 1.sw > 600 ? 14 : 16.0,
    mainAxisExtent: 1.sw > 769 ? 280.w : 240.w,
    mainAxisSpacing: 1.sw > 600 ? 16 : 12,
  );
}

SliverGridDelegateWithFixedCrossAxisCount gridDelegateOffer(context) {
  // double screenWidth = MediaQuery.of(context).size.width;
  // int crossAxisCount = (screenWidth / 150).floor();
  return SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 1.sw > 769 ? 3 : 2,
    crossAxisSpacing: 16.0,
    mainAxisExtent: HiveStorage.get(HiveKeys.isStore)
        ? 1.sw > 769
            ? 270.w
            : 220.w
        : 1.sw > 769
            ? 295.w
            : 245.w,
    mainAxisSpacing: 12.0,
  );
}

SliverGridDelegateWithFixedCrossAxisCount gridDelegateSearch(context) {
  // double screenWidth = MediaQuery.of(context).size.width;
  // int crossAxisCount = (screenWidth / 150).floor();
  return SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 1.sw > 769 ? 3 : 2,
    crossAxisSpacing: 16,
    mainAxisExtent: 1.sw > 769 ? 200 : 190,
    mainAxisSpacing: 12,
  );
}

formatDate(date) => DateFormat('dd-MM-yyyy hh:mm a')
    .format(DateFormat('yyyy-MM-ddTHH:mm:ss').parse(date));

S lang(context) => S.of(context);

calcSale(num original, num rate) {
  return original - (original * rate);
}

T localData<T>(String key) => HiveStorage.get<T>(key);

T currentUsr<T>() =>
    HiveStorage.get<UserModel>(HiveKeys.userModel).getUserData<T>();

enum productTypes {
  newIn,
  random,
  following,
  offer,
}

Future<void> requestPermissions() async {
  var status = await Permission.location.status;
  if (!status.isGranted) {
    await Permission.location.request();
  }

  if (Platform.isAndroid) {
    var backgroundStatus = await Permission.locationAlways.status;
    if (!backgroundStatus.isGranted) {
      await Permission.locationAlways.request();
    }
  }
}

void _openBatterySaverSettings() {
  if (Platform.isAndroid) {
    final intent = AndroidIntent(
      action: 'android.settings.BATTERY_SAVER_SETTINGS',
    );
    intent.launch().catchError(
      (e) {
        print('Could not open Battery Saver settings: $e');
      },
    );
  } else if (Platform.isIOS) {
    // iOS does not have a Battery Saver mode, but you can direct users to relevant settings if needed
    // For example, you can open the app's settings
    _openAppSettings();
  } else {
    // Handle other platforms or show a message
    print('Unsupported platform');
  }
}

// Optional: Function to open app settings on iOS or as a fallback
void _openAppSettings() async {
  const url = 'app-settings:';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    print('Could not open app settings.');
  }
}

checkIfBatterServerEnabled(context) async {
  bool isBatteryOptimizationDisabled =
      await DisableBatteryOptimization.isBatteryOptimizationDisabled ?? true;

  if (!isBatteryOptimizationDisabled) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'the battery saver is enabled please disbable battery sever to turn on notification, \n after disable this battery optimization or sever restart the app',
                style: AppStylesManager.customTextStyleL4,
              ),
              ButtonBuilder(
                text: 'Disable battery sever',
                ontap: () {
                  _openBatterySaverSettings();
                  DisableBatteryOptimization
                      .showDisableBatteryOptimizationSettings();
                },
              ),
            ],
          ),
        );
      },
    );
  } else {
    initializeWebSocket();
    initializeService();
  }
}
