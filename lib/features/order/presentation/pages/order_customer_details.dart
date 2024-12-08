import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nilelon/core/constants/assets.dart';
import 'package:nilelon/features/order/data/models/order_customer_model.dart';
import 'package:nilelon/features/refund/presentation/cubit/refund_cubit.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/core/widgets/divider/default_divider.dart';
import 'package:nilelon/core/widgets/footer/order_details_footer.dart';
import 'package:nilelon/core/widgets/shimmer_indicator/build_shimmer.dart';
import 'package:nilelon/features/order/presentation/widgets/order_product_item.dart';
import 'package:nilelon/features/refund/presentation/pages/refund_page.dart';
import 'package:svg_flutter/svg.dart';

import '../../../../core/widgets/scaffold_image.dart';
import '../cubit/order_cubit.dart';

class OrderDetailsView extends StatefulWidget {
  const OrderDetailsView({super.key, required this.id});
  // final int index;
  final String id;

  @override
  State<OrderDetailsView> createState() => _OrderDetailsViewState();
}

class _OrderDetailsViewState extends State<OrderDetailsView> {
  late final OrderCubit cubit;
  @override
  void initState() {
    cubit = OrderCubit.get(context);
    cubit.getCustomerOrderDetailsById(widget.id);
    RefundCubit.get(context).getRefunds();
    super.initState();
  }

  num price = 0;
  @override
  Widget build(BuildContext context) {
    price = 0;
    for (var item in cubit.customerOrder.orderProductVariants) {
      price += item.price;
    }
    Map<String, dynamic> orderState = {
      'Ordered': {
        'title': 'Ordered',
        'icon': Assets.assetsImagesBagTimer,
        'color': ColorManager.primaryL
      },
      'Shipped': {
        'title': 'Shipped',
        'icon': Assets.assetsImagesBagTimer2,
        'color': ColorManager.primaryO
      },
      'Delivered': {
        'title': 'Delivered',
        'icon': Assets.assetsImagesBagTimer3,
        'color': ColorManager.primaryGR
      }
    };
    final lang = S.of(context);
    return BlocBuilder<OrderCubit, OrderState>(
      builder: (context, state) {
        return ScaffoldImage(
          appBar: customAppBar(
            title: lang.orderDetails,
            context: context,
            hasIcon: cubit.customerOrder.status == 'Delivered' &&
                !RefundCubit.get(context)
                    .refunds
                    .map((e) => e.orderId)
                    .contains(widget.id),
            icon: Icons.error_outline,
            iconColor: ColorManager.primaryR,
            onPressed: () {
              navigateTo(
                  context: context, screen: RefundPage(orderId: widget.id));
            },
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const DefaultDivider(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Container(
                        width: screenWidth(context, 1),
                        height: screenHeight(context, 1) > 769 ? 320 : 290,
                        decoration: ShapeDecoration(
                          color: ColorManager.primaryW,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          shadows: const [
                            BoxShadow(
                              color: ColorManager.primaryBL4,
                              blurRadius: 8,
                              offset: Offset(0, 2),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            BlocBuilder<OrderCubit, OrderState>(
                              builder: (context, state) {
                                return orderSummaryItems2(
                                    lang.orderDate,
                                    Text(
                                      DateFormat('dd-MM-yyyy')
                                          .format(cubit.customerOrder.date),
                                    ));
                              },
                            ),
                            orderSummaryItems2(
                              lang.orderState,
                              BlocBuilder<OrderCubit, OrderState>(
                                builder: (context, state) {
                                  return state.maybeWhen(
                                    loading: () =>
                                        const CircularProgressIndicator(),
                                    success: () => Container(
                                      height: 35,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          color: orderState[cubit
                                              .customerOrder.status]['color']),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          SvgPicture.asset(orderState[cubit
                                              .customerOrder.status]['icon']),
                                          Text(
                                            cubit.customerOrder.status,
                                            style: const TextStyle(
                                                color: ColorManager.primaryW),
                                          ),
                                        ],
                                      ),
                                    ),
                                    orElse: () => SizedBox(
                                      height: 35,
                                      width: 100,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            cubit.customerOrder.status,
                                            style: const TextStyle(
                                                color: ColorManager.primaryW),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )!;
                                },
                              ),
                            ),
                            orderSummaryItems2(
                                lang.recievedDate,
                                Text(
                                  DateFormat('dd-MM-yyyy')
                                      .format(cubit.customerOrder.date),
                                  style: AppStylesManager.customTextStyleG,
                                )),
                            BlocBuilder<OrderCubit, OrderState>(
                              builder: (context, state) {
                                return orderSummaryItems2(
                                  lang.paymentMethod,
                                  Text(
                                    cubit.customerOrder.paymentType,
                                    style: AppStylesManager.customTextStyleBl8,
                                  ),
                                );
                              },
                            ),
                            BlocBuilder<OrderCubit, OrderState>(
                              builder: (context, state) {
                                return orderSummaryItems2(
                                  lang.promoCodeApplied,
                                  Text(
                                    cubit.customerOrder.promoCodeName != null
                                        ? lang.yes
                                        : lang.no,
                                    style: AppStylesManager.customTextStyleG
                                        .copyWith(
                                      color:
                                          cubit.customerOrder.promoCodeName !=
                                                  null
                                              ? ColorManager.primaryGR
                                              : ColorManager.primaryR,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Container(
                        width: screenWidth(context, 1),
                        height: screenHeight(context, 1) > 769 ? 200 : 180,
                        decoration: ShapeDecoration(
                          color: ColorManager.primaryW,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          shadows: const [
                            BoxShadow(
                              color: ColorManager.primaryBL4,
                              blurRadius: 8,
                              offset: Offset(0, 2),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: BlocBuilder<OrderCubit, OrderState>(
                          builder: (context, state) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                state.maybeWhen(
                                  loading: () =>
                                      const CircularProgressIndicator(),
                                  success: () => orderSummaryItems(
                                    S.of(context).order,
                                    (price).toString(),
                                  ),
                                  orElse: () => orderSummaryItems(
                                    S.of(context).order,
                                    (cubit.customerOrder.total).toString(),
                                  ),
                                )!,
                                state.maybeWhen(
                                  loading: () =>
                                      const CircularProgressIndicator(),
                                  success: () => orderSummaryItems(
                                    S.of(context).delivery,
                                    cubit.customerOrder.shippingCost,
                                  ),
                                  orElse: () => orderSummaryItems(
                                    S.of(context).delivery,
                                    cubit.customerOrder.shippingCost,
                                  ),
                                )!,
                                state.maybeWhen(
                                  loading: () =>
                                      const CircularProgressIndicator(),
                                  success: () => orderSummaryItems(
                                    lang.total,
                                    (cubit.customerOrder.total).toString(),
                                    AppStylesManager.customTextStyleO5,
                                  ),
                                  orElse: () => orderSummaryItems(
                                    lang.total,
                                    (cubit.customerOrder.total).toString(),
                                    AppStylesManager.customTextStyleO5,
                                  ),
                                )!,
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                itemsRow(),
              ],
            ),
          ),
          persistentFooterButtons: [
            BlocBuilder<OrderCubit, OrderState>(
              builder: (context, state) {
                return OrderDetailsFooter(
                  visible: cubit.customerOrder != OrderCustomerModel.empty(),
                  order: cubit.customerOrder,
                );
              },
            ),
          ],
        );
      },
    );
  }

  Padding orderSummaryItems(String title, String content, [style]) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: style ??
                AppStylesManager.customTextStyleBl8
                    .copyWith(fontWeight: FontWeight.w600),
          ),
          Text(
            content,
            style: style ?? AppStylesManager.customTextStyleBl8,
          )
        ],
      ),
    );
  }

  Padding orderSummaryItems2(String title, Widget content) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppStylesManager.customTextStyleBl8
                .copyWith(fontWeight: FontWeight.w600),
          ),
          content,
        ],
      ),
    );
  }

  SizedBox itemsRow() {
    return SizedBox(
      height: screenHeight(context, 1) > 769 ? 225 : 190,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<OrderCubit, OrderState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  '${cubit.customerOrder.orderProductVariants.length} ${S.of(context).items}',
                  style: AppStylesManager.customTextStyleBl8,
                ),
              );
            },
          ),
          const SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: SizedBox(
              height: screenHeight(context, 1) > 769 ? 130 : 120,
              child: BlocBuilder<OrderCubit, OrderState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    loading: () => buildShimmerIndicatorRow(),
                    success: () => ListView.builder(
                      scrollDirection: Axis.horizontal,
                      clipBehavior: Clip.none,
                      itemBuilder: (context, index) {
                        final product =
                            cubit.customerOrder.orderProductVariants[index];
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: OrderDetailsCard(
                            product: product,
                          ),
                        );
                      },
                      itemCount:
                          cubit.customerOrder.orderProductVariants.length,
                    ),
                    orElse: () => ListView.builder(
                      scrollDirection: Axis.horizontal,
                      clipBehavior: Clip.none,
                      itemBuilder: (context, index) {
                        final product =
                            cubit.customerOrder.orderProductVariants[index];
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: OrderDetailsCard(
                            product: product,
                          ),
                        );
                      },
                      itemCount:
                          cubit.customerOrder.orderProductVariants.length,
                    ),
                  )!;
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
