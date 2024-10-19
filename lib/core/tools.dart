import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/core/data/hive_stroage.dart';
import 'package:nilelon/generated/l10n.dart';

SliverGridDelegateWithFixedCrossAxisCount get gridDelegate =>
    SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 1.sw > 600 ? 3 : 2,
      crossAxisSpacing: 1.sw > 600 ? 14 : 16.0,
      mainAxisExtent: 320,
      mainAxisSpacing: 1.sw > 600 ? 16 : 12,
    );

S lang(context) => S.of(context);

calcSale(num original, num rate) {
  return original - (original * rate);
}

T localData<T>(String key) => HiveStorage.get<T>(key);
