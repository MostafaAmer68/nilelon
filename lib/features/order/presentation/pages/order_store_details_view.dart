import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/core/constants/assets.dart';
import 'package:nilelon/core/widgets/shimmer_indicator/build_shimmer.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/widgets/button/gradient_button_builder.dart';
import 'package:nilelon/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/features/order/presentation/cubit/order_cubit.dart';
import 'package:nilelon/features/order/presentation/pages/order_product_details_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:svg_flutter/svg.dart';

import '../../../../core/widgets/scaffold_image.dart';

class OrderStoreDetailsView extends StatefulWidget {
  const OrderStoreDetailsView({
    super.key,
    required this.id,
    required this.index,
  });
  final String id;
  final int index;
  @override
  State<OrderStoreDetailsView> createState() => _OrderStoreDetailsViewState();
}

class _OrderStoreDetailsViewState extends State<OrderStoreDetailsView> {
  late final OrderCubit cubit;
  @override
  void initState() {
    cubit = OrderCubit.get(context);
    cubit.getStoreOrderDetailsById(widget.id);
    super.initState();
  }

  bool isLast = false;
  final controller = PageController();
  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);

    return ScaffoldImage(
      appBar: customAppBar(
          title: lang.orderDetails, hasIcon: false, context: context),
      body: BlocConsumer<OrderCubit, OrderState>(
        listener: (context, state) {
          state.mapOrNull(success: (_) {
            setState(() {});
          });
        },
        builder: (context, state) {
          return state.whenOrNull(
            loading: () {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: buildShimmerIndicatorSmall(
                        height: screenHeight(context, 0.3),
                        width: screenWidth(context, 0.9)),
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildShimmerIndicatorSmall(
                                  height: 40, width: 200),
                              SizedBox(
                                height: 8.h,
                              ),
                              Row(
                                children: [
                                  buildShimmerIndicatorSmall(
                                      height: 40, width: 100),
                                  buildShimmerIndicatorSmall(
                                      height: 40, width: 100),
                                ],
                              )
                            ],
                          ),
                          const Spacer(),
                          buildShimmerIndicatorSmall(height: 40, width: 100),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          buildShimmerIndicatorSmall(height: 40, width: 100),
                          buildShimmerIndicatorSmall(height: 40, width: 100),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Align(
                          alignment: Alignment.topLeft,
                          child: buildShimmerIndicatorSmall(
                              height: 40, width: 100))
                    ],
                  ),
                  Expanded(
                      child: buildShimmerIndicatorSmall(height: 40, width: 50)),
                  const SizedBox(height: 15),
                ],
              );
            },
            success: () => Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    physics: const BouncingScrollPhysics(),
                    controller: controller,
                    onPageChanged: (i) {
                      if (i ==
                              cubit.customerOrder.orderProductVariants.length -
                                  1 &&
                          !isLast) {
                        setState(() => isLast = true);
                      } else if (isLast) {
                        setState(() => isLast = false);
                      }
                    },
                    itemBuilder: (context, index) {
                      final product =
                          cubit.storeOrder.orderProductVariants[index];
                      return OrderProductDetailsWidget(
                        product: product,
                      );
                    },
                    itemCount: cubit.storeOrder.orderProductVariants.length,
                  ),
                ),
                SmoothPageIndicator(
                  controller: controller,
                  effect: WormEffect(
                    dotColor: ColorManager.primaryG.withOpacity(0.8),
                    activeDotColor: ColorManager.primaryO.withOpacity(0.9),
                    dotHeight: 10,
                    dotWidth: 10,
                    spacing: 5.0,
                    type: WormType.underground,
                  ),
                  count: cubit.storeOrder.orderProductVariants.length,
                ),
                const SizedBox(height: 15),
              ],
            ),
          )!;
        },
      ),
      persistentFooterButtons: [
        if (cubit.storeOrder.status == 'Shipped' ||
            cubit.storeOrder.status == 'Delivered')
          Positioned(
              top: 1.sw > 600
                  ? screenHeight(context, 0.85)
                  : screenHeight(context, 0.81),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: cubit.storeOrder.status != 'Shipped'
                          ? Image.asset(Assets.assetsImagesArrived2)
                          : SvgPicture.asset(
                              Assets.assetsImagesInProgress,
                            ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      cubit.storeOrder.status == 'Shipped'
                          ? lang.shipped
                          : lang.delivered,
                      style: AppStylesManager.customTextStyleG15,
                    )
                  ],
                ),
              ))
        else
          BlocBuilder<OrderCubit, OrderState>(
            builder: (context, state) {
              return state.whenOrNull(
                loading: () => const CircularProgressIndicator(),
                success: () => GradientButtonBuilder(
                  ontap: () {
                    cubit.changeOrderStatus(
                      widget.id,
                      'Shipped',
                    );
                    // cubit.getStoreOrderDetailsById(widget.id);
                  },
                  width: screenWidth(context, 0.9),
                  text: lang.readyToBeShipped,
                ),
              )!;
            },
          )
      ],
    );
  }
}
