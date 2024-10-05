// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/core/widgets/divider/default_divider.dart';
import 'package:nilelon/core/widgets/scaffold_image.dart';
import 'package:nilelon/features/order/data/models/order_customer_model.dart';
import 'package:nilelon/features/refund/presentation/cubit/refund_cubit.dart';
import 'package:nilelon/features/refund/presentation/widgets/car_order_refund_widget.dart';
import 'package:nilelon/features/refund/presentation/widgets/wrong_item_widget.dart';
import 'package:nilelon/generated/l10n.dart';

import '../../../../core/widgets/shimmer_indicator/build_shimmer.dart';
import '../../../order/presentation/cubit/order_cubit.dart';
import '../widgets/change_mind_widget.dart';

class ReturnHistoryDetailsPage extends StatefulWidget {
  const ReturnHistoryDetailsPage({
    super.key,
    required this.refundId,
    required this.returnType,
  });
  final String refundId;
  final String returnType;
  @override
  State<ReturnHistoryDetailsPage> createState() =>
      _ReturnHistoryDetailsPageState();
}

class _ReturnHistoryDetailsPageState extends State<ReturnHistoryDetailsPage> {
  late final RefundCubit cubit;
  @override
  void initState() {
    cubit = RefundCubit.get(context);
    cubit.getReturnDetails(widget.refundId, widget.returnType);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    var cubit = BlocProvider.of<RefundCubit>(context);
    // List<String> items = [
    //   lang.ChangedMyMind,
    //   lang.wrongItem,
    //   lang.missingItem,
    // ];

    return ScaffoldImage(
      appBar: customAppBar(
        title: lang.returnItem,
        context: context,
        hasIcon: false,
        hasLeading: true,
      ),
      body: BlocBuilder<RefundCubit, RefundState>(
        builder: (context, state) {
          if (state is RefundLoading) {
            return const CircularProgressIndicator();
          }
          if (state is RefundSuccess) {
            cubit.selectedColor = cubit.returnDetails.color;
            cubit.selectedSize = cubit.returnDetails.size;
            return Column(
              children: [
                const DefaultDivider(),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.sp, vertical: 24.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        lang.returnItem,
                        style: AppStylesManager.customTextStyleBl12,
                      ),
                      OrderRefundDetailsCard(
                        product: OrderProductVariant(
                          orderId: '',
                          productId: '',
                          productName: cubit.returnDetails.productName,
                          productRate: 0,
                          size: cubit.returnDetails.size,
                          color: cubit.returnDetails.color,
                          quantity: 0,
                          price: cubit.returnDetails.price,
                          storeName: '',
                          storeId: '',
                          urls: [],
                        ),
                      ),
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
                      Container(
                        height: 70,
                        padding: const EdgeInsets.all(20),
                        width: screenWidth(context, 0.9),
                        decoration: BoxDecoration(
                          color: ColorManager.primaryW,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(widget.returnType),
                      ),

                      if (widget.returnType == 'ChangeMind')
                        const ChangeMindWidget(),
                      if (widget.returnType == 'WrongItem')
                        const WrongItemWidget(),
                      // if (cubit.selectedValue == lang.missingItem)
                      //   const MissingItemWidget(),
                    ],
                  ),
                ),
              ],
            );
          }
          return const Icon(Icons.error);
        },
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
