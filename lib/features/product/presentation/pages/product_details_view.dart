import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nilelon/features/product/domain/models/product_model.dart';
import 'package:nilelon/core/generated/l10n.dart';
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
    super.initState();
    sizes = widget.product.productVariants.map((e) => false).toList();
  }

  void incrementCounter() {
    setState(() {
      counter++;
    });
  }

  void decrementCounter() {
    setState(() {
      if (counter > 1) {
        counter--;
      }
    });
  }

  // int getColorValue(String colorString, String component) {
  //   // Extracts the RGB component value from a color string
  //   colorString = colorString.replaceAll("Color [", "").replaceAll("]", "");
  //   List<String> components = colorString.split(", ");
  //   for (String comp in components) {
  //     List<String> keyValue = comp.split("=");
  //     if (keyValue[0] == component) {
  //       return int.parse(keyValue[1]);
  //     }
  //   }
  //   return 0; // Default value if component not found
  // }

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
        context: context,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DefaultDivider(),
            ImageBanner(
                images:
                    widget.product.productImages.map((e) => e.url).toList()),
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
          '${widget.product.productVariants[0].price} L.E',
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
          style: AppStylesManager.customTextStyleBl6,
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('${lang.size} :', style: AppStylesManager.customTextStyleG10),
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: ToggleButtons(
            selectedColor: AppStylesManager.customTextStyleO.color,
            selectedBorderColor: ColorManager.primaryR2,
            textStyle: AppStylesManager.customTextStyleG11,
            onPressed: (index) {
              sizes = List<bool>.filled(sizes.length, false);
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
    );
  }

  Widget _buildColorSelector() {
    return Row(
      children: [
        Text('Color :', style: AppStylesManager.customTextStyleG10),
        const Spacer(),
        SizedBox(
          width: 200,
          height: 60,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.product.productVariants.length,
            itemBuilder: (context, index) {
              final variant = widget.product.productVariants[index];
              return InkWell(
                onTap: () {},
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  width: 24.w,
                  height: 24.w,
                  decoration: BoxDecoration(
                    color: Color(int.parse('0xff${variant.color}')),
                    shape: BoxShape.circle,
                  ),
                ),
              );
            },
          ),
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
                color: counter == 1 ? ColorManager.primaryG3 : null,
                onTap: () => counter == 1 ? null : decrementCounter,
              ),
              const SizedBox(width: 8),
              Text(counter.toString()),
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
