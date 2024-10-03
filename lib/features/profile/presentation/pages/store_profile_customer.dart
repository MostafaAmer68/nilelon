import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/widgets/button/gradient_button_builder.dart';
import 'package:nilelon/core/widgets/button/outlined_button_builder.dart';
import 'package:nilelon/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/core/widgets/divider/default_divider.dart';
import 'package:nilelon/core/widgets/pop_ups/customer_store_popup.dart';
import 'package:nilelon/core/widgets/cards/small/product_squar_item.dart';
import 'package:nilelon/core/widgets/shimmer_indicator/build_shimmer.dart';
import 'package:nilelon/features/product/presentation/cubit/products_cubit/products_cubit.dart';
import 'package:nilelon/features/profile/presentation/cubit/profile_cubit.dart';

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
  List<String> items = [
    'All Items',
    'T-Shirts',
    'Jackets',
    'Sneakers',
    'Pants'
  ];
  bool notFollowing = true;
  int _selectedIndex = 0;
  @override
  void initState() {
    cubit = BlocProvider.of(context);
    cubit.getStoreById(widget.storeId);
    cubit.getStoreForCustomer(widget.storeId);
    ProductsCubit.get(context).getStoreProductsPagination(widget.storeId, 1, 100);
    super.initState();
  }

  // String _indexName = 'All Items';
  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return ScaffoldImage(
      appBar: customAppBar(
        title: cubit.storeProfile == null
            ? 'loading...'
            : cubit.storeProfile!.name,
        context: context,
        onPressed: () {
          customerStoreDialog(context);
        },
        icon: Icons.more_vert_rounded,
      ),
      body: SingleChildScrollView(
        child: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {
            state.mapOrNull(loading: (r) {
              BotToast.showLoading();
            }, successFollow: (r) {
              BotToast.closeAllLoading();
              BotToast.showText(text: 'You are now following this store');
            }, success: (r) {
              BotToast.closeAllLoading();
            }, failure: (r) {
              BotToast.closeAllLoading();
            });
          },
          builder: (context, state) {
            return state.whenOrNull(
              initial: () => const SizedBox(),
              failure: () => const SizedBox(),
              loading: () => const Center(child: CircularProgressIndicator()),
              success: () {
                return Column(
                  children: [
                    const DefaultDivider(),
                    const SizedBox(
                      height: 30,
                    ),
                    circleItems(cubit.storeProfile!.profilePic ?? ''),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      cubit.storeProfile!.name,
                      style: AppStylesManager.customTextStyleBl8
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      cubit.storeProfile!.storeSlogan ?? '',
                      style: AppStylesManager.customTextStyleG5,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    FollowAndNotifyWidget(
                        cubit: cubit, lang: lang, widget: widget),
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
                              itemBuilder: (context, index) =>
                                  filterContainer(items[index], index),
                              itemCount: items.length,
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
                );
              },
            )!;
          },
        ),
      ),
    );
  }

  GestureDetector filterContainer(String name, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
          // _indexName = name;
        });
      },
      child: _selectedIndex == index
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Container(
                // height: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: ColorManager.primaryB2,
                    border: Border.all(color: ColorManager.primaryB2)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: Center(
                    child: Text(
                      name,
                      textAlign: TextAlign.center,
                      style: AppStylesManager.customTextStyleW4,
                    ),
                  ),
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Container(
                // height: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: ColorManager.primaryB2)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: Center(
                    child: Text(
                      name,
                      textAlign: TextAlign.center,
                      style: AppStylesManager.customTextStyleB3
                          .copyWith(fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  Container circleItems(String image) {
    return Container(
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(500),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x33726363),
            blurRadius: 16,
            offset: Offset(0, 1),
            spreadRadius: 0,
          )
        ],
      ),
      child: CircleAvatar(
        radius: 50,
        backgroundImage: NetworkImage(image),
      ),
    );
  }
}

class ProductStoreWidget extends StatelessWidget {
  const ProductStoreWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        return state.whenOrNull(
          loading: () => buildShimmerIndicatorGrid(),
          success: () => GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: 270,
                crossAxisCount: 2,
                crossAxisSpacing: 20.0,
                mainAxisSpacing: 12),
            shrinkWrap: true,
            itemCount: ProductsCubit.get(context).products.length,
            itemBuilder: (context, sizeIndex) {
              return productSquarItem(
                context: context,
                model: ProductsCubit.get(context).products[sizeIndex],
              );
            },
          ),
        )!;
      },
    );
  }
}

class FollowAndNotifyWidget extends StatelessWidget {
  const FollowAndNotifyWidget({
    super.key,
    required this.cubit,
    required this.lang,
    required this.widget,
  });

  final ProfileCubit cubit;
  final S lang;
  final StoreProfileCustomer widget;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return state.whenOrNull(
          loading: () => const CircularProgressIndicator(),
          success: () {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                !cubit.validationOption['isFollow']
                    ? GradientButtonBuilder(
                        text: lang.follow,
                        ontap: () {
                          cubit.followStore(widget.storeId);
                          cubit.getStoreForCustomer(widget.storeId);
                        },
                        width: screenWidth(context, 0.55),
                        height: 38,
                      )
                    : OutlinedButtonBuilder(
                        text: lang.following,
                        ontap: () {
                          cubit.followStore(widget.storeId);
                          cubit.getStoreForCustomer(widget.storeId);
                        },
                        width: screenWidth(context, 0.55),
                        height: 38,
                      ),
                const SizedBox(
                  width: 16,
                ),
                Container(
                  height: 38,
                  width: 38,
                  decoration: BoxDecoration(
                      color: ColorManager.primaryG16,
                      borderRadius: BorderRadius.circular(12)),
                  child: !cubit.validationOption['isNotify']
                      ? IconButton(
                          icon: const Icon(
                            Iconsax.notification,
                            color: ColorManager.primaryO,
                            size: 18,
                          ),
                          onPressed: () {
                            cubit.notifyStore(widget.storeId);
                            cubit.getStoreForCustomer(widget.storeId);
                          },
                        )
                      : IconButton(
                          icon: const Icon(
                            Iconsax.notification,
                            color: ColorManager.primaryB,
                            size: 18,
                          ),
                          onPressed: () {
                            cubit.notifyStore(widget.storeId);
                            cubit.getStoreForCustomer(widget.storeId);
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
