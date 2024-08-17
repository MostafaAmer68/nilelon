import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/resources/appstyles_manager.dart';
import 'package:nilelon/resources/color_manager.dart';
import 'package:nilelon/resources/font_weight_manger.dart';
import 'package:nilelon/utils/navigation.dart';
import 'package:nilelon/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/widgets/divider/default_divider.dart';
import 'package:nilelon/widgets/view_all_row/view_all_row.dart';
import 'package:nilelon/features/product/presentation/widgets/image_banner.dart';
import 'package:nilelon/features/product/presentation/widgets/rating_container.dart';
import 'package:nilelon/features/profile/presentation/pages/store_profile_store.dart';

class StoreProductDetailsView extends StatefulWidget {
  const StoreProductDetailsView(
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
  State<StoreProductDetailsView> createState() =>
      _StoreProductDetailsViewState();
}

class _StoreProductDetailsViewState extends State<StoreProductDetailsView> {
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
              padding: EdgeInsets.all(16.0.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Column(
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
                                      screen: StoreProfileStore(
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
                      ),
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
                  const SizedBox(
                    height: 24,
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
                              "S",
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            sizeContainer(
                              context,
                              "M",
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            sizeContainer(
                              context,
                              "L",
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            sizeContainer(
                              context,
                              "XL",
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    children: [
                      Text(
                        '${lang.color} :',
                        style: AppStylesManager.customTextStyleG10,
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          width: 32,
                          height: 32,
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
                          width: 32,
                          height: 32,
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
                          width: 32,
                          height: 32,
                          decoration: const BoxDecoration(
                              color: ColorManager.primaryG15,
                              shape: BoxShape.circle),
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          width: 32,
                          height: 32,
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
                  Text(
                    widget.status,
                    style: widget.status == "In Stock"
                        ? AppStylesManager.customTextStyleL3
                        : AppStylesManager.customTextStyleL3
                            .copyWith(color: ColorManager.primaryR),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                ],
              ),
            ),
            ViewAllRow(
              text: lang.reviews,
              noButton: true,
            ),
            const SizedBox(
              height: 4,
              child: Divider(
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
    );
  }

  Container sizeContainer(
    BuildContext context,
    String size,
  ) {
    return Container(
      height: 1.sw > 600 ? 50 : 40,
      width: 1.sw > 600 ? 50 : 40,
      decoration: BoxDecoration(
        color: ColorManager.primaryW,
        border: Border.all(
          color: ColorManager.primaryG14,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          size,
          style: AppStylesManager.customTextStyleG11,
        ),
      ),
    );
  }
}
