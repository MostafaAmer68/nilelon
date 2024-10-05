import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/features/refund/presentation/widgets/car_order_refund_widget.dart';
import 'package:nilelon/features/refund/presentation/widgets/wrong_item_widget.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/widgets/button/gradient_button_builder.dart';
import 'package:nilelon/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/core/widgets/divider/default_divider.dart';
import 'package:nilelon/core/widgets/drop_down_menu/drop_down_menu.dart';
import 'package:nilelon/core/widgets/scaffold_image.dart';
import 'package:nilelon/features/refund/presentation/cubit/refund_cubit.dart';

import '../../../../core/widgets/shimmer_indicator/build_shimmer.dart';
import '../../../order/presentation/cubit/order_cubit.dart';
import '../widgets/change_mind_widget.dart';

class ReturnItemPage extends StatefulWidget {
  const ReturnItemPage({super.key});

  @override
  State<ReturnItemPage> createState() => _ReturnItemPageState();
}

class _ReturnItemPageState extends State<ReturnItemPage> {
  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    var cubit = BlocProvider.of<RefundCubit>(context);
    List<String> items = [
      lang.ChangedMyMind,
      lang.wrongItem,
      lang.missingItem,
    ];

    return BlocListener<RefundCubit, RefundState>(
      listener: (context, state) {
        if (state is RefundLoading) {
          BotToast.showLoading();
        }
        if (state is RefundSuccess) {
          BotToast.closeAllLoading();
          BotToast.showText(text: S.of(context).reportSubmited);
        }
        if (state is RefundFailure) {
          BotToast.closeAllLoading();
          BotToast.showText(text: state.erroMsg);
        }
      },
      child: ScaffoldImage(
        appBar: customAppBar(
          title: lang.returnItem,
          context: context,
          hasIcon: false,
          hasLeading: true,
        ),
        body: Column(
          children: [
            const DefaultDivider(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 24.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lang.whichItem,
                    style: AppStylesManager.customTextStyleBl12,
                  ),
                  _buildItems(),
                  SizedBox(
                    height: 16.sp,
                  ),
                  //! card
                  Text(
                    lang.whydoyouwanttoreturnthisitem,
                    style: AppStylesManager.customTextStyleBl12,
                  ),
                  SizedBox(
                    height: 16.sp,
                  ),
                  dropDownMenu(
                    hint: lang.chooseAnswer,
                    selectedValue: cubit.selectedValue,
                    items: items,
                    context: context,
                    onChanged: (item) {
                      cubit.selectedValue = item!;
                      setState(() {});
                    },
                  ),

                  if (cubit.selectedValue == lang.ChangedMyMind)
                    const ChangeMindWidget(),
                  if (cubit.selectedValue == lang.wrongItem)
                    const WrongItemWidget(),
                  // if (cubit.selectedValue == lang.missingItem)
                  //   const MissingItemWidget(),

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
                  GradientButtonBuilder(
                    text: lang.returnItem,
                    ontap: () {
                      if (cubit.selectedValue == lang.ChangedMyMind) {
                        cubit.createRetChangeMindModel();
                      }
                      if (cubit.selectedValue == lang.wrongItem) {
                        cubit.createWrongItem();
                      }
                      if (cubit.selectedValue == lang.missingItem) {
                        cubit.createRetMissingItem();
                      }
                    },
                    width: screenWidth(context, 1),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding _buildItems() {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: SizedBox(
        height: 120,
        child: BlocBuilder<OrderCubit, OrderState>(
          builder: (context, state) {
            return state.whenOrNull(
              loading: () => buildShimmerIndicatorRow(),
              success: () => ListView.builder(
                scrollDirection: Axis.horizontal,
                clipBehavior: Clip.none,
                itemBuilder: (context, index) {
                  final product = OrderCubit.get(context)
                      .customerOrder
                      .orderProductVariants[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: OrderRefundDetailsCard(
                      product: product,
                    ),
                  );
                },
                itemCount: OrderCubit.get(context)
                    .customerOrder
                    .orderProductVariants
                    .length,
              ),
            )!;
          },
        ),
      ),
    );
  }
}
