import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/features/refund/presentation/cubit/refund_cubit.dart';
import 'package:nilelon/generated/l10n.dart';

import '../../../../core/resources/appstyles_manager.dart';

class MissingItemWidget extends StatefulWidget {
  const MissingItemWidget({super.key});

  @override
  State<MissingItemWidget> createState() => _MissingItemWidgetState();
}

class _MissingItemWidgetState extends State<MissingItemWidget> {
  late final RefundCubit cubit;
  @override
  void initState() {
    cubit = RefundCubit.get(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var lang = S.of(context);
    return Column(
      children: [
        SizedBox(
          height: 8.sp,
        ),
        Text(
          lang.checkReturn,
          style: AppStylesManager.customTextStyleBl12,
        ),
        SizedBox(
          height: 8.sp,
        ),
      ],
    );
  }
}
