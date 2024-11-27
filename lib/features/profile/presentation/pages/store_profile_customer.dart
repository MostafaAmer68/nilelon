// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nilelon/core/constants/assets.dart';
import 'package:nilelon/core/data/hive_stroage.dart';

import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/tools.dart';
import 'package:nilelon/core/widgets/button/gradient_button_builder.dart';
import 'package:nilelon/core/widgets/button/outlined_button_builder.dart';
import 'package:nilelon/features/categories/presentation/widget/category_filter_widget.dart';
import 'package:nilelon/features/product/presentation/widgets/product_card/product_squar_item.dart';
import 'package:nilelon/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/core/widgets/divider/default_divider.dart';
import 'package:nilelon/core/widgets/pop_ups/customer_store_popup.dart';
import 'package:nilelon/core/widgets/shimmer_indicator/build_shimmer.dart';
import 'package:nilelon/features/product/presentation/cubit/products_cubit/products_cubit.dart';
import 'package:nilelon/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:nilelon/features/profile/presentation/widgets/profile_avater_widget.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:svg_flutter/svg.dart';

import '../../../../core/widgets/scaffold_image.dart';
import '../../../product/presentation/cubit/products_cubit/products_state.dart';

class StoreProfileCustomer extends StatefulWidget {
  const StoreProfileCustomer({super.key, required this.storeId});

  final String storeId;
  @override
  State<StoreProfileCustomer> createState() => _StoreProfileCustomerState();
}

class _StoreProfileCustomerState extends State<StoreProfileCustomer> {
  late final ProfileCubit cubit;

  bool notFollowing = true;
  @override
  void initState() {
    cubit = BlocProvider.of(context);
    cubit.getStoreById(widget.storeId);

    ProductsCubit.get(context).getStoreProducts(widget.storeId);
    super.initState();
  }

  @override
  void dispose() {
    cubit.validationOption = {
      'isFollow': false,
      'isNotify': false,
    };
    cubit.storeProfile = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return ScaffoldImage(
          appBar: customAppBar(
            title: cubit.storeProfile == null
                ? lang.loading
                : cubit.storeProfile!.name,
            context: context,
            onPressed: () {
              customerStoreDialog(context, widget.storeId);
            },
            icon: Icons.more_vert_rounded,
          ),
          body: SingleChildScrollView(
            child: BlocConsumer<ProfileCubit, ProfileState>(
              listener: (context, state) {
                state.mapOrNull(initial: (_) {
                  cubit.getStoreById(widget.storeId);
                });
              },
              builder: (context, state) {
                return state.whenOrNull(
                  initial: () => const SizedBox(),
                  failure: (_) => Text(lang.smothingWent),
                  loading: () => Column(
                    children: [
                      const DefaultDivider(),
                      const SizedBox(
                        height: 30,
                      ),
                      buildShimmerIndicatorSmall(radius: 300),
                      const SizedBox(
                        height: 16,
                      ),
                      buildShimmerIndicatorSmall(height: 40),
                      const SizedBox(
                        height: 8,
                      ),
                      buildShimmerIndicatorSmall(height: 40),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          buildShimmerIndicatorSmall(height: 40),
                          buildShimmerIndicatorSmall(height: 40, width: 40),
                        ],
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
                            child: SizedBox(
                              height: 52,
                              width: MediaQuery.of(context).size.width,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: 3,
                                itemBuilder: (context, index) =>
                                    buildShimmerIndicatorSmall(
                                        width: 60, height: 60),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: ProductStoreWidget(),
                      ),
                    ],
                  ),
                  success: () {
                    return Column(
                      children: [
                        const DefaultDivider(),
                        const SizedBox(
                          height: 30,
                        ),
                        ProfileAvater(
                            image: cubit.storeProfile!.profilePic ?? ''),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          cubit.storeProfile!.name,
                          style: AppStylesManager.customTextStyleBl8
                              .copyWith(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          cubit.storeProfile!.storeSlogan ?? '',
                          style: AppStylesManager.customTextStyleG5,
                        ),
                        const SizedBox(height: 30),
                        if (!HiveStorage.get(HiveKeys.isStore)) ...[
                          FollowAndNotifyWidget(storeId: widget.storeId),
                          const SizedBox(height: 30),
                        ],
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
                        const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: ProductStoreWidget(),
                        ),
                      ],
                    );
                  },
                )!;
              },
            ),
          ),
        );
      },
    );
  }
}

class ProductStoreWidget extends StatelessWidget {
  const ProductStoreWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var profileCubit = ProfileCubit.get(context);
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        return state.maybeWhen(
          // initial: () => const SizedBox(),
          failure: (_) => Text(_),
          loading: () => buildShimmerIndicatorGrid(context),
          storeProductSuccess: (products) => GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: gridDelegate(context),
            shrinkWrap: true,
            itemCount: ProductsCubit.get(context)
                .filterListByCategory(profileCubit.selectedCategory,
                    ProductsCubit.get(context).storeProducts.data)
                .length,
            itemBuilder: (context, sizeIndex) {
              return productSquarItem(
                context: context,
                product: ProductsCubit.get(context)
                    .filterListByCategory(profileCubit.selectedCategory,
                        ProductsCubit.get(context).storeProducts.data)
                    .toList()[sizeIndex],
              );
            },
          ),
          orElse: () => GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: gridDelegate(context),
            shrinkWrap: true,
            itemCount: ProductsCubit.get(context)
                .filterListByCategory(profileCubit.selectedCategory,
                    ProductsCubit.get(context).storeProducts.data)
                .length,
            itemBuilder: (context, sizeIndex) {
              log('test');
              return productSquarItem(
                context: context,
                product: ProductsCubit.get(context)
                    .filterListByCategory(profileCubit.selectedCategory,
                        ProductsCubit.get(context).storeProducts.data)
                    .toList()[sizeIndex],
              );
            },
          ),
        );
      },
    );
  }
}

class FollowAndNotifyWidget extends StatefulWidget {
  const FollowAndNotifyWidget({
    super.key,
    required this.storeId,
  });

  final String storeId;

  @override
  State<FollowAndNotifyWidget> createState() => _FollowAndNotifyWidgetState();
}

class _FollowAndNotifyWidgetState extends State<FollowAndNotifyWidget> {
  late final ProfileCubit cubit;
  @override
  void initState() {
    cubit = ProfileCubit.get(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return state.whenOrNull(
          loading: () {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildShimmerIndicatorSmall(),
                const SizedBox(width: 16),
                buildShimmerIndicatorSmall(),
              ],
            );
          },
          success: () {
            return cubit.validationOption.isEmpty
                ? const Text('field to follow')
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      !cubit.validationOption['isFollow']
                          ? GradientButtonBuilder(
                              text: lang(context).follow,
                              ontap: () {
                                cubit.followStore(widget.storeId);
                              },
                              width: screenWidth(context, 0.55),
                              height: 38,
                            )
                          : OutlinedButtonBuilder(
                              text: lang(context).following,
                              ontap: () {
                                cubit.followStore(widget.storeId);
                              },
                              width: screenWidth(context, 0.55),
                              height: 38,
                            ),
                      const SizedBox(
                        width: 16,
                      ),
                      Container(
                        height: 38,
                        width: 60,
                        decoration: BoxDecoration(
                          color: ColorManager.primaryG16,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: IconButton(
                          icon: SvgPicture.asset(
                            !cubit.validationOption['isNotify']
                                ? Assets.assetsImagesNotifications
                                : Assets.assetsImagesNotificationsActive,
                            fit: BoxFit.cover,
                          ),
                          iconSize: 50,
                          onPressed: () {
                            if (cubit.validationOption['isFollow']) {
                              cubit.notifyStore(widget.storeId);
                            } else {
                              BotToast.showText(
                                  text: lang(context).plsFollowStore);
                            }
                          },
                        ),
                      ),
                    ],
                  );
          },
        )!;
      },
    );
  }
}
