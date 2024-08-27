import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/core/generated/l10n.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/widgets/button/gradient_button_builder.dart';
import 'package:nilelon/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/features/order/presentation/pages/order_product_details_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:svg_flutter/svg.dart';

class OrderedStoreDetailsView extends StatefulWidget {
  const OrderedStoreDetailsView({
    super.key,
    required this.items,
    required this.index,
  });
  final List<Map<String, dynamic>> items;
  final int index;
  @override
  State<OrderedStoreDetailsView> createState() =>
      _OrderedStoreDetailsViewState();
}

class _OrderedStoreDetailsViewState extends State<OrderedStoreDetailsView> {
  bool isLast = false;
  final controller = PageController();
  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);

    return Scaffold(
      backgroundColor: ColorManager.primaryW,
      appBar: customAppBar(
          title: lang.orderDetails, hasIcon: false, context: context),
      body: Stack(
        alignment: Alignment.center,
        children: [
          PageView.builder(
            physics: const BouncingScrollPhysics(),
            controller: controller,
            onPageChanged: (i) {
              if (i == widget.items.length - 1 && !isLast) {
                setState(() => isLast = true);
              } else if (isLast) {
                setState(() => isLast = false);
              }
            },
            itemBuilder: (context, index) {
              return OrderProductDetailsWidget(
                images: widget.items[index]['images'],
                name: widget.items[index]['name'],
                storeName: widget.items[index]['storeName'],
                rating: widget.items[index]['rating'],
                price: widget.items[index]['price'],
                size: widget.items[index]['size'],
                quan: widget.items[index]['quan'],
              );
            },
            itemCount: widget.items.length,
          ),
          Positioned(
            top: 1.sw > 600
                ? screenHeight(context, 0.82)
                : screenHeight(context, 0.75),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                  count: widget.items.length,
                ),
              ],
            ),
          ),
          Positioned(
            top: 1.sw > 600
                ? screenHeight(context, 0.85)
                : screenHeight(context, 0.81),
            child: widget.index == 0
                ? GradientButtonBuilder(
                    width: screenWidth(context, 0.9),
                    text: lang.readyToBeShipped,
                    ontap: () {},
                  )
                : widget.index == 1
                    ? Column(
                        children: [
                          SizedBox(
                            width: 50,
                            height: 50,
                            child: SvgPicture.asset(
                                'assets/images/inProgress.svg'),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Text(
                            lang.shipped,
                            style: AppStylesManager.customTextStyleG16,
                          )
                        ],
                      )
                    : Column(
                        children: [
                          SizedBox(
                            width: 50,
                            height: 50,
                            child: Image.asset('assets/images/arrived2.png'),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Text(
                            lang.received,
                            style: AppStylesManager.customTextStyleG16,
                          )
                        ],
                      ),
          ),
        ],
      ),
    );
  }
}
