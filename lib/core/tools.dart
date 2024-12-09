import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:nilelon/core/data/hive_stroage.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/generated/l10n.dart';

import '../features/auth/domain/model/user_model.dart';

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
    crossAxisCount: 1.sw > 600 ? 3 : 2,
    crossAxisSpacing: 16.0,
    mainAxisExtent: HiveStorage.get(HiveKeys.isStore)
        ? screenHeight(context, 1) > 769
            ? 270.w
            : 220.w
        : screenHeight(context, 1) > 769
            ? 295.w
            : 245.w,
    mainAxisSpacing: 12.0,
  );
}

SliverGridDelegateWithFixedCrossAxisCount gridDelegateSearch(context) {
  // double screenWidth = MediaQuery.of(context).size.width;
  // int crossAxisCount = (screenWidth / 150).floor();
  return SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 1.sw > 600 ? 3 : 2,
    crossAxisSpacing: 16,
    mainAxisExtent: screenHeight(context, 1) > 769 ? 200 : 190,
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
