import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nilelon/features/product/domain/models/product_model.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/resources/appstyles_manager.dart';
import 'package:nilelon/resources/color_manager.dart';
import 'package:nilelon/resources/font_weight_manger.dart';
import 'package:nilelon/utils/navigation.dart';
import 'package:nilelon/widgets/button/small_button.dart';
import 'package:nilelon/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/widgets/divider/default_divider.dart';
import 'package:nilelon/widgets/footer/add_to_footer.dart';
import 'package:nilelon/widgets/pop_ups/add_to_closet_popup.dart';
import 'package:nilelon/widgets/view_all_row/view_all_row.dart';
import 'package:nilelon/features/product/presentation/widgets/image_banner.dart';
import 'package:nilelon/features/product/presentation/widgets/rating_container.dart';
import 'package:nilelon/widgets/rating/view/rating_dialog.dart';
import 'package:nilelon/features/customer_flow/store_profile_customer/store_profile_customer.dart';

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({
    super.key,
    required this.product,
  });
  final ProductModel product;
  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  int counter = 1;
  bool isEnabled = true;
  late List<bool> sizes;
  @override
  void initState() {
    sizes = widget.product.productVariants.map((e) => false).toList();
    super.initState();
  }

  void incrementCounter() {
    setState(() {
      counter++;
    });
  }

  void decrementCounter() {
    setState(() {
      counter--;
    });
  }

  int getColorValue(String colorString, String component) {
    // Remove the "Color [" prefix and "]" suffix
    colorString = colorString.replaceAll("Color [", "").replaceAll("]", "");

    // Split the string by ", " to get individual components
    List<String> components = colorString.split(", ");

    // Iterate through the components to find the desired one
    for (String comp in components) {
      List<String> keyValue = comp.split("=");
      if (keyValue[0] == component) {
        return int.parse(keyValue[1]); // Convert the value to an integer
      }
    }

    // Return 0 if the component is not found (default value)
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return Scaffold(
      backgroundColor: ColorManager.primaryW,
      appBar: customAppBar(
          title: lang.productDetails,
          icon: Icons.share_outlined,
          onPressed: () {
            addToClosetDialog(context, widget.product.id);
          },
          context: context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DefaultDivider(),
            ImageBanner(
              images: widget.product.productImages.map((e) => e.url).toList(),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      nameAndPriceRow(context),
                      const Spacer(),
                      Text(
                        '${widget.product.productVariants[0].price} L.E',
                        style: AppStylesManager.customTextStyleO4,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Text(
                    widget.product.description,
                    style: AppStylesManager.customTextStyleG18.copyWith(
                      fontWeight: FontWeightManager.regular400,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${lang.size} :',
                        style: AppStylesManager.customTextStyleG10,
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: ToggleButtons(
                          selectedColor:
                              AppStylesManager.customTextStyleO.color,
                          selectedBorderColor: ColorManager.primaryR2,
                          textStyle: AppStylesManager.customTextStyleG11,
                          onPressed: (index) {
                            sizes = sizes.map((e) => false).toList();
                            sizes[index] = !sizes[index];
                            setState(() {});
                          },
                          isSelected: sizes,
                          children: widget.product.productVariants
                              .map((e) => Text(e.size))
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 22.h,
                  ),
                  Row(
                    children: [
                      Text(
                        'Color :',
                        style: AppStylesManager.customTextStyleG10,
                      ),
                      const Spacer(),
                      SizedBox(
                        width: 200,
                        height: 60,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.product.productVariants.length,
                          itemBuilder: (context, index) {
                            final variant =
                                widget.product.productVariants[index];
                            return InkWell(
                              onTap: () {},
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 6),
                                width: 24.w,
                                height: 24.w,
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(
                                        getColorValue(variant.color, 'R'),
                                        getColorValue(variant.color, 'G'),
                                        getColorValue(variant.color, 'B'),
                                        1),
                                    shape: BoxShape.circle),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  widget.product.inStock > 0
                      ? Row(
                          children: [
                            Text(
                              'In stock',
                              style: AppStylesManager.customTextStyleL3,
                            ),
                            const Spacer(),
                            counter == 1
                                ? SmallButton(
                                    icon: Iconsax.minus,
                                    color: ColorManager.primaryG3,
                                    onTap: () {},
                                  )
                                : SmallButton(
                                    icon: Iconsax.minus,
                                    onTap: () {
                                      decrementCounter();
                                    },
                                  ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(counter.toString()),
                            const SizedBox(
                              width: 8,
                            ),
                            SmallButton(
                              icon: Iconsax.add,
                              onTap: () {
                                incrementCounter();
                              },
                            ),
                          ],
                        )
                      : Text(
                          'Out of stock',
                          style: AppStylesManager.customTextStyleL3
                              .copyWith(color: ColorManager.primaryR),
                        ),
                ],
              ),
            ),
            SizedBox(
              height: 6.h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ViewAllRow(
                text: lang.reviews,
                noPadding: true,
                onPressed: () {
                  ratingDialog(context);
                },
                buttonWidget: Text(
                  lang.rate,
                  style: AppStylesManager.customTextStyleO,
                ),
              ),
            ),
            SizedBox(
              height: 4.h,
              child: const Divider(
                color: ColorManager.primaryG8,
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            const RatingContainer(),
            const SizedBox(
              height: 24,
            ),
          ],
        ),
      ),
      persistentFooterButtons: [
        AddToFooter(
          visible: true,
          product: widget.product,
        )
      ],
    );
  }

  Column nameAndPriceRow(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.product.name,
          style: AppStylesManager.customTextStyleBl6,
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                navigateTo(
                    context: context,
                    screen: StoreProfileCustomer(
                        storeName: widget.product.name,
                        image: 'assets/images/brand1.png',
                        description: 'Shop for Women'));
              },
              child: Text(
                widget.product.storeName,
                style: AppStylesManager.customTextStyleG9,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            const Icon(
              Icons.star,
              color: ColorManager.primaryO2,
              size: 20,
            ),
            Text(widget.product.rating.toString())
          ],
        )
      ],
    );
  }

  InkWell sizeContainer(BuildContext context, void Function() onTap,
      String size, bool isSelected) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 35.w,
        width: 60.w,
        decoration: BoxDecoration(
          color: isSelected ? ColorManager.primaryR2 : ColorManager.primaryW,
          border: Border.all(
            color:
                isSelected ? ColorManager.primaryR2 : ColorManager.primaryG14,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            size,
            style: isSelected
                ? AppStylesManager.customTextStyleO
                : AppStylesManager.customTextStyleG11,
          ),
        ),
      ),
    );
  }
}
