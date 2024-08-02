import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/resources/appstyles_manager.dart';
import 'package:nilelon/resources/color_manager.dart';
import 'package:nilelon/resources/font_weight_manger.dart';
import 'package:nilelon/utils/navigation.dart';
import 'package:nilelon/widgets/button/small_button.dart';
import 'package:nilelon/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/widgets/divider/default_divider.dart';
import 'package:nilelon/widgets/footer/add_to_footer.dart';
import 'package:nilelon/widgets/view_all_row/view_all_row.dart';
import 'package:nilelon/features/customer_flow/products_view/product_details/widget/image_banner.dart';
import 'package:nilelon/features/customer_flow/products_view/product_details/widget/rating_container.dart';
import 'package:nilelon/widgets/rating/view/rating_dialog.dart';
import 'package:nilelon/features/customer_flow/store_profile_customer/store_profile_customer.dart';

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView(
      {super.key,
      required this.images,
      required this.name,
      required this.storeName,
      required this.rating,
      required this.price,
      required this.status,
      required this.reviews});
  final List<String> images;
  final String name;
  final String storeName;
  final String rating;
  final String price;
  final String status;
  final List reviews;
  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  var s = true;
  var m = false;
  var l = false;
  var xl = false;
  int counter = 1;
  bool isEnabled = true;
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

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return Scaffold(
      backgroundColor: ColorManager.primaryW,
      appBar: customAppBar(
          title: lang.productDetails,
          icon: Icons.share_outlined,
          onPressed: () {},
          context: context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DefaultDivider(),
            ImageBanner(
              images: widget.images,
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
                        '${widget.price} L.E',
                        style: AppStylesManager.customTextStyleO4,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Text(
                    'Lorem ipsum dolor sit amet consectetur. Lorem aenean eget dolor mattis viverra. Sapien quisque donec gravida aenean quam amet rhoncus id. Leo mi nec in tincidunt turpis.',
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
                        child: Row(
                          children: [
                            sizeContainer(
                              context,
                              () {
                                s = true;
                                m = false;
                                l = false;
                                xl = false;
                                setState(() {});
                              },
                              "S",
                              s,
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            sizeContainer(
                              context,
                              () {
                                s = false;
                                m = true;
                                l = false;
                                xl = false;
                                setState(() {});
                              },
                              "M",
                              m,
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            sizeContainer(
                              context,
                              () {
                                s = false;
                                m = false;
                                l = true;
                                xl = false;
                                setState(() {});
                              },
                              "L",
                              l,
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            sizeContainer(
                              context,
                              () {
                                s = false;
                                m = false;
                                l = false;
                                xl = true;
                                setState(() {});
                              },
                              "XL",
                              xl,
                            ),
                          ],
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
                      InkWell(
                        onTap: () {},
                        child: Container(
                          width: 24.w,
                          height: 24.w,
                          decoration: const BoxDecoration(
                              color: ColorManager.primaryL2,
                              shape: BoxShape.circle),
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          width: 24.w,
                          height: 24.w,
                          decoration: const BoxDecoration(
                              color: ColorManager.primaryL4,
                              shape: BoxShape.circle),
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          width: 24.w,
                          height: 24.w,
                          decoration: const BoxDecoration(
                            color: ColorManager.primaryG15,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          width: 24.w,
                          height: 24.w,
                          decoration: const BoxDecoration(
                              color: ColorManager.primaryO,
                              shape: BoxShape.circle),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  widget.status == "In Stock"
                      ? Row(
                          children: [
                            Text(
                              widget.status,
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
                          widget.status,
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
          visible: widget.status == "In Stock" ? true : false,
        )
      ],
    );
  }

  Column nameAndPriceRow(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.name,
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
                        storeName: widget.name,
                        image: 'assets/images/brand1.png',
                        description: 'Shop for Women'));
              },
              child: Text(
                widget.storeName,
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
            Text(widget.rating)
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
        width: 35.w,
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
