import 'package:flutter/material.dart';
import 'package:nilelon/core/generated/l10n.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/core/widgets/divider/default_divider.dart';
import 'package:nilelon/core/widgets/footer/order_details_footer.dart';
import 'package:nilelon/features/cart/domain/model/get_cart_model/cart_item.dart';
import 'package:nilelon/features/customer_flow/order_details/widget/order_details_card.dart';
import 'package:svg_flutter/svg.dart';

class OrderDetailsView extends StatelessWidget {
  const OrderDetailsView(
      {super.key, required this.index, required this.recievedDate});
  final int index;
  final String recievedDate;
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> items = [
      {'title': 'Order', 'content': '600 L.E'},
      {'title': 'Delivery', 'content': '50 L.E'},
      {'title': 'Total', 'content': '650 L.E'},
    ];
    List<Map<String, dynamic>> orderState = [
      {
        'title': 'Ordered',
        'icon': 'assets/images/bag-timer.svg',
        'color': ColorManager.primaryL
      },
      {
        'title': 'Shipped',
        'icon': 'assets/images/bag-timer2.svg',
        'color': ColorManager.primaryO
      },
      {
        'title': 'Received',
        'icon': 'assets/images/bag-timer3.svg',
        'color': ColorManager.primaryGR
      },
    ];
    final lang = S.of(context);
    return Scaffold(
      backgroundColor: ColorManager.primaryW,
      appBar: customAppBar(
        title: lang.orderDetails,
        context: context,
        hasIcon: false,
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
                    height: 310,
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
                        orderSummaryItems2(
                            lang.orderDate,
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12)),
                            )),
                        const DefaultDivider(),
                        orderSummaryItems2(
                          lang.orderState,
                          Container(
                            height: 35,
                            width: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: orderState[index]['color']),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SvgPicture.asset(orderState[index]['icon']),
                                Text(
                                  orderState[index]['title'],
                                  style: const TextStyle(
                                      color: ColorManager.primaryW),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const DefaultDivider(),
                        orderSummaryItems2(
                            lang.recievedDate,
                            Text(
                              recievedDate,
                              style: AppStylesManager.customTextStyleG,
                            )),
                        const DefaultDivider(),
                        orderSummaryItems2(
                            lang.paymentMethod,
                            Text(
                              'Credit Card',
                              style: AppStylesManager.customTextStyleG,
                            )),
                        const DefaultDivider(),
                        orderSummaryItems2(
                            lang.promoCodeApplied,
                            Text(
                              lang.yes,
                              style: AppStylesManager.customTextStyleG
                                  .copyWith(color: ColorManager.primaryGR),
                            )),
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
                    height: 190,
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
                        orderSummaryItems(
                          items[0]['title'],
                          items[0]['content'],
                        ),
                        const DefaultDivider(),
                        orderSummaryItems(
                          items[1]['title'],
                          items[1]['content'],
                        ),
                        const DefaultDivider(),
                        orderSummaryItems(
                          items[2]['title'],
                          items[2]['content'],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            itemsRow(),
          ],
        ),
      ),
      persistentFooterButtons: const [
        OrderDetailsFooter(),
      ],
    );
  }

  Padding orderSummaryItems(String title, String content) {
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
          Text(
            content,
            style: AppStylesManager.customTextStyleBl8,
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
      height: 190,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              '5 Items',
              style: AppStylesManager.customTextStyleBl8,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                clipBehavior: Clip.none,
                itemBuilder: (context, index) => const Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: OrderDetailsCard(
                    cartItem: CartItem(productName: '', price: 132),
                  ),
                ),
                itemCount: 10,
              ),
            ),
          )
        ],
      ),
    );
  }
}
