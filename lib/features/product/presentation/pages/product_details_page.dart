import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/widgets/replacer/image_replacer.dart';
import 'package:nilelon/core/widgets/shimmer_indicator/build_shimmer.dart';
import 'package:nilelon/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:nilelon/features/product/presentation/cubit/products_cubit/products_cubit.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/font_weight_manger.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/core/widgets/button/small_button.dart';
import 'package:nilelon/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/core/widgets/divider/default_divider.dart';
import 'package:nilelon/core/widgets/footer/add_to_footer.dart';
import 'package:nilelon/core/widgets/view_all_row/view_all_row.dart';
import 'package:nilelon/features/product/presentation/widgets/image_banner.dart';
import 'package:nilelon/features/product/presentation/widgets/rating_container.dart';
import 'package:nilelon/core/widgets/rating/view/rating_dialog.dart';
import 'package:nilelon/features/profile/presentation/pages/store_profile_customer.dart';
import 'package:share_plus/share_plus.dart';
import 'package:svg_flutter/svg.dart';

import '../../../../core/constants/assets.dart';
import '../../../../core/data/hive_stroage.dart';
import '../../../../core/tools.dart';
import '../../../../core/widgets/scaffold_image.dart';
import '../../../closet/presentation/view/closet_sheet_bar_view.dart';
import '../../domain/models/product_model.dart';
import '../cubit/products_cubit/products_state.dart';
import '../widgets/color_selector.dart';
import '../widgets/custom_toggle_button.dart';

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({
    super.key,
    required this.productId,
  });
  final String productId;

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  bool isEnabled = true;
  late List<String> sizes;
  late final CartCubit cubit;
  late final ProductsCubit productCubit;
  @override
  void initState() {
    super.initState();
    cubit = CartCubit.get(context);
    productCubit = ProductsCubit.get(context);
    productCubit.getProductDetails(widget.productId);
  }

  @override
  void dispose() {
    productCubit.product = ProductModel.empty();
    productCubit.review.clear();
    super.dispose();
  }

  void incrementCounter() {
    setState(() {
      CartCubit.get(context).counter++;
    });
  }

  void decrementCounter() {
    setState(() {
      CartCubit.get(context).counter--;
      if (CartCubit.get(context).counter != 1) {}
    });
  }

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return BlocListener<ProductsCubit, ProductsState>(
      listener: (context, state) {
        state.mapOrNull(
          initial: (_) {},
          success: (_) {
            setState(() {});
            log((productCubit.product == ProductModel.empty()).toString());
            BotToast.closeAllLoading();
            if (productCubit.product != ProductModel.empty()) {
              cubit.selectedColor = productCubit.product.productVariants
                  .firstWhere((e) => e.price != 0)
                  .color;
              cubit.selectedSize = productCubit.product.productVariants
                  .firstWhere((e) => e.price != 0)
                  .size;
              sizes = productCubit.product.productVariants
                  .where((e) => e.quantity != 0 && e.quantity > 0)
                  .map((e) => e.size)
                  .toList();
              setState(() {});
            }
            setState(() {});
          },
        );
      },
      child: ScaffoldImage(
        appBar: customAppBar(
          title: lang.productDetails,
          icon: Icons.share_outlined,
          onPressed: () {
            Share.share(
              'http://nilelon.somee.com/Product',
            );
          },
          context: context,
        ),
        body: BlocBuilder<ProductsCubit, ProductsState>(
          builder: (context, state) {
            return state.whenOrNull(success: () {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const DefaultDivider(),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 20),
                      child: Stack(
                        children: [
                          ImageBanner(
                            images: productCubit.product.productImages
                                .where((e) => e.color == cubit.selectedColor)
                                .map((e) => e.url)
                                .toList(),
                          ),
                          Positioned(
                            top: 10,
                            right: 25,
                            child: Visibility(
                              visible: !HiveStorage.get(HiveKeys.isStore),
                              child: InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    backgroundColor: ColorManager.primaryW,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        topRight: Radius.circular(30),
                                      ),
                                    ),
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    builder: (context) => ClosetSheetBarView(
                                        productId: widget.productId),
                                  );
                                },
                                child: !productCubit.product.isInCloset
                                    ? Container(
                                        width: 30.w,
                                        height: 30.w,
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.orange.shade300
                                                  .withOpacity(1),
                                              offset: const Offset(3, 3),
                                              blurRadius: 5,
                                            ),
                                          ],
                                        ),
                                        child: SvgPicture.asset(
                                          Assets.assetsImagesHanger,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : Image.asset(
                                        Assets.assetsImagesClosetFollowing,
                                        fit: BoxFit.cover,
                                        width: 60,
                                      ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: SizedBox(
                        height: screenHeight(context, 0.07),
                        width: screenWidth(context, 0.3),
                        child: ListView.builder(
                          itemCount: productCubit.product.productImages
                              .where((e) => e.color == cubit.selectedColor)
                              .length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final image = productCubit.product.productImages
                                .where((e) => e.color == cubit.selectedColor)
                                .toList()[index];

                            return imageReplacer(
                              url: image.url,
                              fit: BoxFit.cover,
                              width: 50,
                              radius: 8,
                            );
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildNameAndPriceRow(context),
                          const SizedBox(height: 24),
                          _buildDescription(),
                          SizedBox(height: 20.h),
                          Visibility(
                            visible: isNOtEMpty,
                            child: InkWell(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (c) {
                                      return Scaffold(
                                        appBar: AppBar(
                                          centerTitle: true,
                                          title: Text(lang.sizeGuide),
                                          leading: IconButton(
                                            onPressed: () {
                                              navigatePop(context: c);
                                            },
                                            icon: const Icon(Icons.close),
                                          ),
                                        ),
                                        body: Center(
                                          child: imageReplacer(
                                              height:
                                                  screenHeight(context, 0.85),
                                              url: productCubit
                                                  .product.sizeguide),
                                        ),
                                      );
                                    });
                              },
                              child: Text(
                                lang.sizeGuide,
                                style: AppStylesManager.customTextStyleO4,
                              ),
                            ),
                          ),
                          SizedBox(height: 20.h),
                          _buildSizeSelector(lang),
                          SizedBox(height: 22.h),
                          _buildColorSelector(),
                          SizedBox(height: 20.h),
                          _buildStockCounter(),
                        ],
                      ),
                    ),
                    SizedBox(height: 6.h),
                    _buildReviewSection(lang),
                    const SizedBox(height: 15),
                    const Divider(color: ColorManager.primaryG8, height: 4),
                    const SizedBox(height: 24),
                    ReviewWidget(productId: widget.productId),
                    const SizedBox(height: 24),
                  ],
                ),
              );
            }, loading: () {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const DefaultDivider(),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 20),
                      child:
                          buildShimmerIndicatorSmall(height: 400, width: 400),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: SizedBox(
                        height: screenHeight(context, 0.07),
                        width: screenWidth(context, 0.3),
                        child: ListView.builder(
                          itemCount: 4,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return buildShimmerIndicatorSmall(
                                width: 50, height: 100);
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  buildShimmerIndicatorSmall(
                                      height: 30, width: 100),
                                  buildShimmerIndicatorSmall(
                                      height: 30, width: 100),
                                ],
                              ),
                              buildShimmerIndicatorSmall(
                                  height: 60, width: 100),
                            ],
                          )),
                          const SizedBox(height: 24),
                          buildShimmerIndicatorSmall(height: 40, width: 100),
                          SizedBox(height: 20.h),
                          buildShimmerIndicatorSmall(height: 40, width: 100),
                          SizedBox(height: 20.h),
                          SizedBox(
                              height: 60, child: buildShimmerIndicatorRow()),
                          SizedBox(height: 22.h),
                          SizedBox(
                              height: 60, child: buildShimmerIndicatorRow()),
                          SizedBox(height: 20.h),
                          Center(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              buildShimmerIndicatorSmall(
                                  height: 60, width: 100),
                              buildShimmerIndicatorSmall(
                                  height: 60, width: 100),
                            ],
                          )),
                        ],
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Center(
                        child:
                            buildShimmerIndicatorSmall(height: 60, width: 400)),
                    const SizedBox(height: 15),
                    const Divider(color: ColorManager.primaryG8, height: 4),
                    const SizedBox(height: 24),
                    SizedBox(height: 200, child: buildShimmerIndicator()),
                    const SizedBox(height: 24),
                  ],
                ),
              );
            }, initial: () {
              return Text('init');
            }, failure: (_) {
              return Text(_);
            })!;
          },
        ),
        btmBar: BlocBuilder<ProductsCubit, ProductsState>(
          builder: (context, state) {
            return state.whenOrNull(
              loading: () => buildShimmerIndicatorSmall(),
              failure: (_) => Text(_),
              success: () =>
                  AddToFooter(visible: true, product: productCubit.product),
            )!;
          },
        ),
      ),
    );
  }

  bool get isNOtEMpty => productCubit.product.sizeguide.isNotEmpty;

  Widget _buildNameAndPriceRow(BuildContext context) {
    final priceAfterDis;
    num price = 0;
    bool isHasDis = false;
    if (productCubit.product.productVariants.isNotEmpty) {
      priceAfterDis = calcSale(
          productCubit.product.productVariants
              .firstWhere(
                  (e) =>
                      e.color == cubit.selectedColor &&
                      e.size == cubit.selectedSize,
                  orElse: () => productCubit.product.productVariants.first)
              .price,
          productCubit.product.productVariants
              .firstWhere(
                  (e) =>
                      e.color == cubit.selectedColor &&
                      e.size == cubit.selectedSize,
                  orElse: () => productCubit.product.productVariants.first)
              .discountRate);

      log(productCubit.product.productVariants.length.toString());
      price = productCubit.product.productVariants
          .firstWhere(
              (e) =>
                  e.color == cubit.selectedColor &&
                  e.size == cubit.selectedSize,
              orElse: () => productCubit.product.productVariants.first)
          .price;
      isHasDis = productCubit.product.productVariants
              .firstWhere(
                (e) =>
                    e.color == cubit.selectedColor &&
                    e.size == cubit.selectedSize,
                orElse: () => productCubit.product.productVariants.first,
              )
              .discountRate >
          0;
    } else {
      priceAfterDis = 'No variants available';
    }

    return Row(
      children: [
        Expanded(child: _buildProductInfo(context)),
        Column(
          children: [
            Text(
              '$priceAfterDis ${lang(context).le}',
              style: AppStylesManager.customTextStyleO4,
            ),
            Visibility(
              visible: isHasDis,
              child: Text(
                '$price ${lang(context).le}',
                style: AppStylesManager.customTextStyleO5
                    .copyWith(decoration: TextDecoration.lineThrough),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProductInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: screenWidth(context, 0.5),
          child: Text(
            productCubit.product.name,
            style: AppStylesManager.customTextStyleBl6.copyWith(
              fontSize: 25.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                navigateTo(
                  context: context,
                  screen: StoreProfileCustomer(
                    storeId: productCubit.product.storeId,
                  ),
                );
              },
              child: Text(
                productCubit.product.storeName,
                style: AppStylesManager.customTextStyleG9,
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.star, color: ColorManager.primaryO2, size: 20),
            Text(productCubit.product.rating.toString()),
          ],
        ),
      ],
    );
  }

  Widget _buildDescription() {
    return Text(
      productCubit.product.description,
      style: AppStylesManager.customTextStyleG18.copyWith(
        fontWeight: FontWeightManager.regular400,
      ),
    );
  }

  Widget _buildSizeSelector(S lang) {
    return Row(
      children: [
        Text('${lang.size} :', style: AppStylesManager.customTextStyleG10),
        SizeToggleButtons(
          sizes: productCubit.product.productVariants
              .where((e) => e.color == cubit.selectedColor)
              .toList()
              .where((e) => e.quantity > 0 && e.price != 0)
              .map((e) => e.size)
              .toList()
              .toSet()
              .toList(),
          selectedSize: cubit.selectedSize,
          onSizeSelected: (size) {
            cubit.selectedSize = size;
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildColorSelector() {
    return Row(
      children: [
        Text('${S.of(context).color}:',
            style: AppStylesManager.customTextStyleG10),
        ColorSelector(
          colors: productCubit.product.productVariants
              .where((e) => e.quantity != 0 && e.price != 0)
              .map((e) => e.color)
              .toList()
              .toSet()
              .toList(),
          selectedColor: cubit.selectedColor,
          onColorSelected: (color) {
            cubit.selectedColor = color;
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildStockCounter() {
    return productCubit.product.inStock > 0
        ? Row(
            children: [
              Text(S.of(context).inStock,
                  style: AppStylesManager.customTextStyleL3),
              const Spacer(),
              SmallButton(
                icon: Iconsax.minus,
                color: CartCubit.get(context).counter == 1
                    ? ColorManager.primaryG3
                    : null,
                onTap: () => CartCubit.get(context).counter > 1
                    ? decrementCounter()
                    : null,
              ),
              const SizedBox(width: 8),
              Text(CartCubit.get(context).counter.toString()),
              const SizedBox(width: 8),
              SmallButton(
                icon: Iconsax.add,
                onTap: incrementCounter,
              ),
            ],
          )
        : Text(
            S.of(context).outOfStock,
            style: AppStylesManager.customTextStyleL3.copyWith(
              color: ColorManager.primaryR,
            ),
          );
  }

  Widget _buildReviewSection(S lang) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ViewAllRow(
        text: lang.reviews,
        noPadding: true,
        noButton: !HiveStorage.get<bool>(HiveKeys.isStore) &&
            productCubit.product.isReviewed,
        onPressed: () {
          ratingDialog(context);
        },
        buttonWidget: Text(
          lang.rate,
          style: AppStylesManager.customTextStyleO,
        ),
      ),
    );
  }
}

class ReviewWidget extends StatefulWidget {
  const ReviewWidget({
    super.key,
    required this.productId,
  });
  final String productId;

  @override
  State<ReviewWidget> createState() => _ReviewWidgetState();
}

class _ReviewWidgetState extends State<ReviewWidget> {
  late final ProductsCubit cubit;

  @override
  void initState() {
    cubit = ProductsCubit.get(context);
    // cubit.getReviews(widget.productId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (cubit.review.isEmpty) {
      return Center(child: Text(lang(context).noReviews));
    }
    return ListView.builder(
      shrinkWrap: true,
      itemCount: cubit.review.length,
      itemBuilder: (context, index) {
        final review = cubit.review[index];
        return RatingContainer(review: review);
      },
    );
  }
}
