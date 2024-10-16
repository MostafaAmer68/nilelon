import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:nilelon/generated/l10n.dart';
import '../../../../core/resources/appstyles_manager.dart';
import '../cubit/add_product/add_product_cubit.dart';
import 'color_circle.dart';

class ProductColorsSelection extends StatefulWidget {
  const ProductColorsSelection({
    super.key,
    required this.onTap,
  });
  final Function(int index) onTap;
  @override
  State<ProductColorsSelection> createState() => _ProductColorsSelectionState();
}

class _ProductColorsSelectionState extends State<ProductColorsSelection> {
  late final AddProductCubit cubit;
  @override
  void initState() {
    cubit = AddProductCubit.get(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(S.of(context).productColors,
              style: AppStylesManager.customTextStyleBl5),
          SizedBox(height: 12.h),
          SizedBox(
            height: 40.h,
            child: ListView.builder(
              itemCount: cubit.colors.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => colorCircle(
                () => widget.onTap(index),
                cubit.colors[index],
                cubit.selectedIndex,
                index,
                cubit.isVarientAdded.values.toList()[index],
              ),
            ),
          ),
          SizedBox(height: 40.h),
        ],
      ),
    );
  }
}
