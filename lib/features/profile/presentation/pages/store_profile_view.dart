import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/core/constants/assets.dart';
import 'package:nilelon/core/data/hive_stroage.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/tools.dart';
import 'package:nilelon/core/widgets/button/gradient_button_builder.dart';
import 'package:nilelon/features/auth/domain/model/user_model.dart';
import 'package:nilelon/features/categories/presentation/widget/category_filter_widget.dart';
import 'package:nilelon/features/product/presentation/cubit/products_cubit/products_cubit.dart';
import 'package:nilelon/features/product/presentation/cubit/products_cubit/products_state.dart';
import 'package:nilelon/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:nilelon/features/profile/presentation/widgets/profile_avater_widget.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/features/product/presentation/widgets/product_card/product_squar_item.dart';
import 'package:nilelon/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/core/widgets/divider/default_divider.dart';
import 'package:nilelon/features/profile/presentation/pages/store_settings_view.dart';
import 'package:nilelon/core/widgets/shimmer_indicator/build_shimmer.dart';
import 'package:svg_flutter/svg.dart';

import '../../../../core/widgets/scaffold_image.dart';
import '../../../promo/presentation/pages/offer_product_page.dart';

class StoreProfileView extends StatefulWidget {
  const StoreProfileView({
    super.key,
  });

  @override
  State<StoreProfileView> createState() => _StoreProfileViewState();
}

class _StoreProfileViewState extends State<StoreProfileView> {
  late final ProductsCubit pCubit;
  late final ProfileCubit cubit;
  late final StoreModel user;

  @override
  void initState() {
    user = HiveStorage.get<UserModel>(HiveKeys.userModel)
        .getUserData<StoreModel>();

    pCubit = ProductsCubit.get(context);
    cubit = ProfileCubit.get(context);
    pCubit.getStoreProducts('');

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // String _indexName = 'All Items';
  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);

    return ScaffoldImage(
      appBar: customAppBar(
        hasLeading: false,
        title: lang.profile,
        context: context,
        onPressed: () {
          navigateTo(context: context, screen: const StoreSettingsView());
        },
        icon: Icons.settings_outlined,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const DefaultDivider(),
            const SizedBox(
              height: 30,
            ),
            ProfileAvater(
              image: user.profilePic,
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              user.name,
              style: AppStylesManager.customTextStyleBl8
                  .copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              user.storeSlogan,
              style: AppStylesManager.customTextStyleG5,
            ),
            const SizedBox(
              height: 8,
            ),
            GradientButtonBuilder(
              text: lang.applyOffer,
              icon: SvgPicture.asset(
                Assets.assetsImagesTag,
                fit: BoxFit.cover,
                height: 28.w,
              ),
              isIcon: true,
              ontap: () {
                navigateTo(
                  context: context,
                  screen: const OfferProductPage(),
                );
              },
              height: 50,
              width: screenWidth(context, 0.7),
            ),
            const SizedBox(
              height: 30,
            ),
            const DefaultDivider(),
            const SizedBox(
              height: 18,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 16,
                ),
                const Icon(Icons.tune),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: CategoryFilterWidget(
                    selectedCategory: cubit.selectedCategory,
                    onSelected: (category) {
                      cubit.selectedCategory = category;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            BlocBuilder<ProductsCubit, ProductsState>(
              builder: (context, state) {
                return state.maybeWhen(initial: () {
                  return buildShimmerIndicatorGrid(context);
                }, loading: () {
                  return buildShimmerIndicatorGrid(context);
                }, storeProductSuccess: (products) {
                  if (pCubit
                      .filterListByCategory(cubit.selectedCategory, products.data)
                      .isEmpty) {
                    return SizedBox(
                      height: 280.h,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              S.of(context).thereNoProduct,
                              style: AppStylesManager.customTextStyleG2,
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: GridView.builder(
                        controller: ProductsCubit.get(context).scroll,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: gridDelegate(context),
                        shrinkWrap: true,
                        itemCount: pCubit
                            .filterListByCategory(
                                cubit.selectedCategory, products.data)
                            .length,
                        itemBuilder: (context, sizeIndex) {
                          return productSquarItem(
                            context: context,
                            product: pCubit.filterListByCategory(
                                cubit.selectedCategory, products.data)[sizeIndex],
                          );
                        },
                      ),
                    );
                  }
                }, failure: (message) {
                  return Text(message);
                }, orElse: () {
                  return Text(S.of(context).waitingToGet);
                });
              },
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
