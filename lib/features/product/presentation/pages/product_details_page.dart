import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nilelon/core/resources/const_functions.dart';
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
import 'package:nilelon/core/widgets/pop_ups/add_to_closet_popup.dart';
import 'package:nilelon/core/widgets/view_all_row/view_all_row.dart';
import 'package:nilelon/features/product/presentation/widgets/image_banner.dart';
import 'package:nilelon/features/product/presentation/widgets/rating_container.dart';
import 'package:nilelon/core/widgets/rating/view/rating_dialog.dart';
import 'package:nilelon/features/profile/presentation/pages/store_profile_customer.dart';

import '../../../../core/widgets/scaffold_image.dart';
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
        appBar: customAppBar(
          title: lang.productDetails,
          icon: Icons.share_outlined,
          onPressed: () {
            addToClosetDialog(context, productCubit.product.id);
          },
          context: context,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const DefaultDivider(),
              BlocBuilder<ProductsCubit, ProductsState>(
                builder: (context, state) {
                  return state.whenOrNull(
                    failure: (_) => Text(_),
                    loading: () => const CircularProgressIndicator(),
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
                          failure: (_) => Text(_),
                          loading: () => const CircularProgressIndicator(),
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
                        failure: (_) => Text(_),
                        loading: () => const CircularProgressIndicator(),
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
                    failure: (_) => Text(_),
                    loading: () => const CircularProgressIndicator(),
                    success: () {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: ProductsCubit.get(context).review.length,
                        itemBuilder: (context, index) {
                          final review =
                              ProductsCubit.get(context).review[index];
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
          AddToFooter(visible: true, product: productCubit.product),
        ],
      ),
    );
  }

  Widget _buildNameAndPriceRow(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _buildProductInfo(context)),
        Text(
          '${productCubit.product.productVariants.firstWhere((e) => e.color == cubit.selectedColor && e.size == cubit.selectedSize).price} L.E',
          style: AppStylesManager.customTextStyleO4,
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
          sizes: sizes,
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
