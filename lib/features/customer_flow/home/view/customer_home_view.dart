import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nilelon/core/data/hive_stroage.dart';
import 'package:nilelon/features/product/presentation/cubit/products_cubit/products_cubit.dart';
import 'package:nilelon/features/product/presentation/cubit/products_cubit/products_state.dart';
import 'package:nilelon/features/customer_flow/recommendation_profile/recommendation_profile_view.dart';
import 'package:nilelon/core/generated/l10n.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/core/widgets/scaffold_image.dart';
import 'package:nilelon/core/widgets/shimmer_indicator/build_shimmer.dart';
import 'package:nilelon/core/widgets/text_form_field/text_field/const_text_form_field.dart';
import 'package:nilelon/features/product/presentation/pages/following_view_all.dart';
import 'package:nilelon/core/widgets/banner/banner_product.dart';
import 'package:nilelon/core/widgets/custom_app_bar/home_custom_app_bar.dart';
import 'package:nilelon/core/widgets/cards/small/product_squar_item.dart';
import 'package:nilelon/core/widgets/view_all_row/view_all_row.dart';
import 'package:nilelon/features/search/presentation/pages/search_view.dart';

import '../../../auth/domain/model/user_model.dart';

class CustomerHomeView extends StatefulWidget {
  const CustomerHomeView({super.key});

  @override
  State<CustomerHomeView> createState() => _CustomerHomeViewState();
}

class _CustomerHomeViewState extends State<CustomerHomeView> {
  int page = 5;
  int pageSize = 1;
  bool isLoadMore = false;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    if (HiveStorage.get<UserModel>(HiveKeys.userModel).id.isNotEmpty) {
      ProductsCubit.get(context).getFollowedProductsPagination(page, pageSize);
      scrollController.addListener(() {
        if (scrollController.position.pixels ==
                scrollController.position.maxScrollExtent &&
            !isLoadMore) {
          getMoreData();
        }
      });
    }
    super.initState();
  }

  getMoreData() async {
    setState(() {
      isLoadMore = true;
    });

    page = page + 1;
    if (HiveStorage.get<UserModel>(HiveKeys.userModel).id.isNotEmpty) {
      ProductsCubit.get(context).getFollowedProductsPagination(page, pageSize);
    }
    setState(() {
      isLoadMore = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return ScaffoldImage(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const HomeCustomAppBar(),
              const SizedBox(
                height: 24,
              ),
              GestureDetector(
                onTap: () {
                  navigateTo(context: context, screen: const SearchView());
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0.sp),
                  child: ConstTextFieldBuilder(
                    label: lang.searchForAnything,
                    width: screenWidth(context, 1),
                    prefixWidget: const Icon(
                      Iconsax.search_normal,
                      color: ColorManager.primaryG,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GestureDetector(
                  onTap: () {
                    navigateTo(
                        context: context,
                        screen: const RecommendationProfileView());
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        HiveStorage.get(HiveKeys.shopFor),
                        style: AppStylesManager.customTextStyleBl6,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 16,
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              banner(context),
              SizedBox(
                height: 16.h,
              ),
              // ViewAllRow(
              //   text: lang.hotPicks,
              //   onPressed: () {
              //     navigateTo(
              //         context: context, screen: const CustomerHotPicksView());
              //   },
              // ),
              // const SizedBox(
              //   height: 8,
              // ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 16),
              //   child: SizedBox(
              //     height: 170.h,
              //     child: ListView.builder(
              //       itemBuilder: (context, index) => Row(
              //         children: [
              //           wideCard(
              //               onTap: () {
              //                 // addToClosetDialog(context);
              //               },
              //               context: context),
              //           SizedBox(
              //             width: 8.w,
              //           )
              //         ],
              //       ),
              //       itemCount: 5,
              //       scrollDirection: Axis.horizontal,
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: 8.h,
              // ),
              ViewAllRow(
                text: lang.following,
                onPressed: () {
                  navigateTo(
                      context: context, screen: const FollowingViewAll());
                },
              ),
              const SizedBox(
                height: 8,
              ),
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 16.w),
              //   child: GridView.builder(
              //     controller: scrollController,
              //     physics: const NeverScrollableScrollPhysics(),
              //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //       crossAxisCount: 1.sw > 600 ? 3 : 2,
              //       crossAxisSpacing: 1.sw > 600 ? 14 : 16.0,
              //       mainAxisExtent: 1.sw > 600 ? 300 : 220,
              //       mainAxisSpacing: 1.sw > 600 ? 16 : 12,
              //     ),
              //     shrinkWrap: true,
              //     itemCount: isLoadMore ? products.length + 1 : products.length,
              //     itemBuilder: (context, sizeIndex) {
              //       if (sizeIndex == products.length && isLoadMore) {
              //         return buildShimmerIndicatorSmall();
              //       } else {
              //         return smallCardC(
              //           context: context,
              //           model: products[sizeIndex],
              //         );
              //       }
              //     },
              //   ),
              // ),
              // const SizedBox(
              //   height: 50,
              // )
              BlocBuilder<ProductsCubit, ProductsState>(
                builder: (context, state) {
                  return state.getFollowedProducts.when(initial: () {
                    return buildShimmerIndicatorGrid();
                  }, loading: () {
                    return buildShimmerIndicatorGrid();
                  }, success: (productsList) {
                    return productsList.isEmpty
                        ? SizedBox(
                            height: 180.h,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'you dont followed any store yet.',
                                  style: AppStylesManager.customTextStyleG2,
                                ),
                              ],
                            ),
                          )
                        : Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: GridView.builder(
                              controller: scrollController,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1.sw > 600 ? 3 : 2,
                                crossAxisSpacing: 1.sw > 600 ? 14 : 16.0,
                                mainAxisExtent: 1.sw > 600 ? 300 : 300,
                                mainAxisSpacing: 1.sw > 600 ? 16 : 12,
                              ),
                              shrinkWrap: true,
                              itemCount: isLoadMore
                                  ? productsList.length + 1
                                  : productsList.length,
                              itemBuilder: (context, sizeIndex) {
                                if (sizeIndex == productsList.length &&
                                    isLoadMore) {
                                  return buildShimmerIndicatorSmall();
                                } else {
                                  return productSquarItem(
                                    context: context,
                                    model: productsList[sizeIndex],
                                  );
                                }
                              },
                            ),
                          );
                  }, failure: (message) {
                    return const SizedBox(
                        height: 100,
                        child: Center(
                            child: Text('There is no following products')));
                  });
                },
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  BannerProduct banner(BuildContext context) {
    return BannerProduct(
      height: MediaQuery.of(context).size.height * .60,
      isStore: false,
    );
  }
}
