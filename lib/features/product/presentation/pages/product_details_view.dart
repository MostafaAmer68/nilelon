import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nilelon/core/data/hive_stroage.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:nilelon/features/product/domain/models/product_model.dart';
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
import 'package:nilelon/features/product/presentation/pages/edit_product_page.dart';
import 'package:nilelon/features/product/presentation/widgets/image_banner.dart';
import 'package:nilelon/features/product/presentation/widgets/rating_container.dart';
import 'package:nilelon/core/widgets/rating/view/rating_dialog.dart';
import 'package:nilelon/features/profile/presentation/pages/store_profile_customer.dart';

import '../../../../core/widgets/scaffold_image.dart';
import '../widgets/color_selector.dart';
import '../widgets/custom_toggle_button.dart';

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
  bool isEnabled = true;
  late List<String> sizes;
  late final CartCubit cubit;
  @override
  void initState() {
    super.initState();
    cubit = CartCubit.get(context);
    cubit.selectedColor = widget.product.productVariants.first.color;
    cubit.selectedSize = widget.product.productVariants.first.size;
    sizes = widget.product.productVariants
        .where((e) => e.quantity != 0 && e.quantity > 0)
        .map((e) => e.size)
        .toList();
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
    return ScaffoldImage(
      appBar: !HiveStorage.get(HiveKeys.isStore)
          ? customAppBar(
              title: lang.productDetails,
              icon: Icons.share_outlined,
              onPressed: () {
                addToClosetDialog(context, widget.product.id);
              },
              context: context,
            )
          : AppBar(
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
                    } else if (value == 'update') {
                      navigateTo(
                          context: context,
                          screen: EditProductpage(product: widget.product));
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
            ImageBanner(
              images: widget.product.productImages.map((e) => e.url).toList(),
            ),
            const SizedBox(height: 20),
            Center(
              child: SizedBox(
                height: screenHeight(context, 0.07),
                width: screenWidth(context, 0.3),
                child: ListView.builder(
                  itemCount: widget.product.productImages.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final image = widget.product.productImages[index];
                    return Image.network(
                      image.url,
                      fit: BoxFit.cover,
                      // width: 30,
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
            const Divider(color: ColorManager.primaryG8, height: 4),
            const SizedBox(height: 24),
            const RatingContainer(),
            const SizedBox(height: 24),
          ],
        ),
      ),
      persistentFooterButtons: [
        AddToFooter(visible: true, product: widget.product),
      ],
    );
  }

  Widget _buildNameAndPriceRow(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _buildProductInfo(context)),
        Text(
          '${widget.product.productVariants.firstWhere((e) => e.color == cubit.selectedColor && e.size == cubit.selectedSize).price} L.E',
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
          widget.product.name,
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
                    storeId: widget.product.storeId,
                  ),
                );
              },
              child: Text(
                widget.product.storeName,
                style: AppStylesManager.customTextStyleG9,
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.star, color: ColorManager.primaryO2, size: 20),
            Text(widget.product.rating.toString()),
          ],
        ),
      ],
    );
  }

  Widget _buildDescription() {
    return Text(
      widget.product.description,
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
        Text('Color :', style: AppStylesManager.customTextStyleG10),
        ColorSelector(
          colors: widget.product.productVariants
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
    return widget.product.inStock > 0
        ? Row(
            children: [
              Text('In stock', style: AppStylesManager.customTextStyleL3),
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
            'Out of stock',
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
