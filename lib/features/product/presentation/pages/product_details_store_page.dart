import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/widgets/alert/delete_alert.dart';
import 'package:nilelon/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:nilelon/features/product/presentation/cubit/products_cubit/products_cubit.dart';
import 'package:nilelon/features/promo/presentation/cubit/promo_cubit.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/font_weight_manger.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/core/widgets/button/small_button.dart';
import 'package:nilelon/core/widgets/divider/default_divider.dart';
import 'package:nilelon/core/widgets/view_all_row/view_all_row.dart';
import 'package:nilelon/features/product/presentation/pages/product_edit_page.dart';
import 'package:nilelon/features/product/presentation/widgets/image_banner.dart';
import 'package:nilelon/features/product/presentation/widgets/rating_container.dart';
import 'package:nilelon/features/profile/presentation/pages/store_profile_customer.dart';

import '../../../../core/tools.dart';
import '../../../../core/widgets/button/gradient_button_builder.dart';
import '../../../../core/widgets/scaffold_image.dart';
import '../../../../core/widgets/shimmer_indicator/build_shimmer.dart';
import '../../../promo/presentation/pages/appy_offer_page.dart';
import '../cubit/products_cubit/products_state.dart';
import '../widgets/color_selector.dart';
import '../widgets/custom_toggle_button.dart';

class ProductStoreDetailsView extends StatefulWidget {
  const ProductStoreDetailsView({
    super.key,
    required this.productId,
  });
  final String productId;

  @override
  State<ProductStoreDetailsView> createState() =>
      _ProductStoreDetailsViewState();
}

class _ProductStoreDetailsViewState extends State<ProductStoreDetailsView> {
  bool isEnabled = true;
  late List<String> sizes;
  late final CartCubit cubit;
  late final ProductsCubit productCubit;
  @override
  void initState() {
    super.initState();
    cubit = CartCubit.get(context);
    productCubit = ProductsCubit.get(context);
    ProductsCubit.get(context).getProductDetails(widget.productId);
    // ProductsCubit.get(context).getReviews(widget.productId);
  }

  void incrementCounter() {
    setState(() {
      CartCubit.get(context).counter++;
    });
  }

  void decrementCounter() {
    setState(() {
      if (CartCubit.get(context).counter > 1) {
        CartCubit.get(context).counter--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return BlocListener<ProductsCubit, ProductsState>(
      listener: (context, state) {
        state.mapOrNull(success: (_) {
          BotToast.closeAllLoading();
          cubit.selectedColor =
              productCubit.product.productVariants.first.color;
          cubit.selectedSize = productCubit.product.productVariants.first.size;
          sizes = productCubit.product.productVariants
              .where((e) => e.quantity != 0 && e.quantity > 0)
              .map((e) => e.size)
              .toList();
        });
      },
      child: ScaffoldImage(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
              onPressed: () => navigatePop(context: context),
              icon: const Icon(Icons.arrow_back)),
          title: Text(
            lang.productDetails,
            style: AppStylesManager.customTextStyleBl6,
          ),
          centerTitle: true,
          actions: [
            PopupMenuButton<String>(
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    value: 'delete',
                    child: Text(lang.delete),
                  ),
                  PopupMenuItem(
                    value: 'update',
                    child: Text(lang.updateDraft),
                  ),
                ];
              },
              onSelected: (value) {
                if (value == 'delete') {
                  deleteAlert(context, lang.areYouSureYouWantToDeleteThisDraft,
                      () {
                    productCubit.deleteProduct(widget.productId);
                    navigatePop(context: context);
                  });
                } else if (value == 'update') {
                  navigateTo(
                      context: context,
                      screen: EditProductpage(product: productCubit.product));
                }
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const DefaultDivider(),
              BlocBuilder<ProductsCubit, ProductsState>(
                builder: (context, state) {
                  return state.whenOrNull(
                    loading: () => buildShimmerIndicatorSmall(500, 600),
                    success: () => ImageBanner(
                      images: productCubit.product.productImages
                          .map((e) => e.url)
                          .toList(),
                    ),
                  )!;
                },
              ),
              const SizedBox(height: 20),
              Center(
                child: SizedBox(
                  height: screenHeight(context, 0.07),
                  width: screenWidth(context, 0.3),
                  child: BlocBuilder<ProductsCubit, ProductsState>(
                    builder: (context, state) {
                      return state.whenOrNull(
                          loading: () => buildShimmerIndicatorRow(),
                          success: () => ListView.builder(
                                itemCount:
                                    productCubit.product.productImages.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  final image =
                                      productCubit.product.productImages[index];
                                  return Image.network(
                                    image.url,
                                    fit: BoxFit.cover,
                                    // width: 30,
                                  );
                                },
                              ))!;
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: BlocBuilder<ProductsCubit, ProductsState>(
                  builder: (context, state) {
                    return state.whenOrNull(
                        loading: () => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    buildShimmerIndicatorSmall(40),
                                    buildShimmerIndicatorSmall(40, 100),
                                  ],
                                ),
                                const SizedBox(height: 24),
                                buildShimmerIndicatorSmall(100, 400),
                                SizedBox(height: 20.h),
                                Row(
                                  children: [
                                    buildShimmerIndicatorSmall(40, 100),
                                    buildShimmerIndicatorSmall(40),
                                  ],
                                ),
                                SizedBox(height: 22.h),
                                Row(
                                  children: [
                                    buildShimmerIndicatorSmall(40, 100),
                                    buildShimmerIndicatorSmall(40),
                                  ],
                                ),
                                SizedBox(height: 20.h),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    buildShimmerIndicatorSmall(40, 80),
                                    buildShimmerIndicatorSmall(40, 80),
                                  ],
                                ),
                              ],
                            ),
                        success: () => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildNameAndPriceRow(context),
                                const SizedBox(height: 24),
                                _buildDescription(),
                                SizedBox(height: 20.h),
                                _buildSizeSelector(lang),
                                SizedBox(height: 22.h),
                                _buildColorSelector(),
                                SizedBox(height: 20.h),
                                _buildStockCounter(),
                              ],
                            ))!;
                  },
                ),
              ),
              SizedBox(height: 6.h),
              _buildReviewSection(lang),
              const Divider(color: ColorManager.primaryG8, height: 4),
              const SizedBox(height: 24),
              BlocBuilder<ProductsCubit, ProductsState>(
                builder: (context, state) {
                  return state.whenOrNull(
                    loading: () => buildShimmerIndicatorSmall(),
                    success: () {
                      if (productCubit.review.isEmpty) {
                        return Center(child: Text(lang.noReviews));
                      }
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: productCubit.review.length,
                        itemBuilder: (context, index) {
                          final review = productCubit.review[index];
                          return RatingContainer(review: review);
                        },
                      );
                    },
                  )!;
                },
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
        persistentFooterButtons: [
          GradientButtonBuilder(
            text: S.of(context).applyOffer,
            width: screenWidth(context, 1),
            ontap: () {
              PromoCubit.get(context).selectedProducts.clear();
              PromoCubit.get(context)
                  .selectedProducts
                  .add(productCubit.product);
              navigateTo(context: context, screen: const ApplyOfferPage());
            },
          )
        ],
      ),
    );
  }

  Widget _buildNameAndPriceRow(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _buildProductInfo(context)),
        Column(
          children: [
            Text(
              '${calcSale(productCubit.product.productVariants.firstWhere((e) => e.color == cubit.selectedColor && e.size == cubit.selectedSize).price, productCubit.product.productVariants.firstWhere((e) => e.color == cubit.selectedColor && e.size == cubit.selectedSize).discountRate)} L.E',
              style: AppStylesManager.customTextStyleO4,
            ),
            Visibility(
              visible: productCubit.product.productVariants
                      .firstWhere((e) =>
                          e.color == cubit.selectedColor &&
                          e.size == cubit.selectedSize)
                      .discountRate >
                  0,
              child: Text(
                '${productCubit.product.productVariants.firstWhere((e) => e.color == cubit.selectedColor && e.size == cubit.selectedSize).price} L.E',
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
        Text(
          productCubit.product.name,
          style: AppStylesManager.customTextStyleBl6.copyWith(
            fontSize: 30.sp,
            fontWeight: FontWeight.bold,
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('${lang.size} :', style: AppStylesManager.customTextStyleG10),
        SizeToggleButtons(
          sizes: productCubit.product.productVariants
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
                onTap: () => CartCubit.get(context).counter == 1
                    ? null
                    : decrementCounter,
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
        noButton: true,
        onPressed: () {
          // ratingDialog(context);
        },
        buttonWidget: Text(
          lang.rate,
          style: AppStylesManager.customTextStyleO,
        ),
      ),
    );
  }
}
