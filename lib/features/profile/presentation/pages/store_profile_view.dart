import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/data/hive_stroage.dart';
import 'package:nilelon/features/auth/domain/model/user_model.dart';
import 'package:nilelon/features/product/presentation/cubit/products_cubit/products_cubit.dart';
import 'package:nilelon/features/product/presentation/cubit/products_cubit/products_state.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/resources/appstyles_manager.dart';
import 'package:nilelon/resources/color_manager.dart';
import 'package:nilelon/utils/navigation.dart';
import 'package:nilelon/widgets/cards/small/small_card.dart';
import 'package:nilelon/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/widgets/divider/default_divider.dart';
import 'package:nilelon/features/profile/presentation/pages/store_settings_view.dart';
import 'package:nilelon/widgets/shimmer_indicator/build_shimmer.dart';

class StoreProfileView extends StatefulWidget {
  const StoreProfileView({
    super.key,
  });

  @override
  State<StoreProfileView> createState() => _StoreProfileViewState();
}

class _StoreProfileViewState extends State<StoreProfileView> {
  List<String> items = [
    'All Items',
    'T-Shirts',
    'Jackets',
    'Sneakers',
    'Pants'
  ];
  int _selectedIndex = 0;
  int page = 5;
  int pageSize = 1;
  bool isLoadMore = false;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    BlocProvider.of<ProductsCubit>(context).getStoreProducts(page, pageSize);
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !isLoadMore) {
        getMoreData();
      }
    });
    super.initState();
  }

  getMoreData() async {
    setState(() {
      isLoadMore = true;
    });

    page = page + 1;
    await BlocProvider.of<ProductsCubit>(context)
        .getStoreProductsPagination(page, pageSize);
    setState(() {
      isLoadMore = false;
    });
  }

  // String _indexName = 'All Items';
  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);

    return Scaffold(
      backgroundColor: ColorManager.primaryW,
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
            circleItems('assets/images/brand1.png'),
            const SizedBox(
              height: 16,
            ),
            Text(
              HiveStorage.get<UserModel>(HiveKeys.userModel)
                  .getUserData<StoreModel>()
                  .name,
              style: AppStylesManager.customTextStyleBl8
                  .copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              HiveStorage.get<UserModel>(HiveKeys.userModel)
                  .getUserData<StoreModel>()
                  .storeSlogan,
              style: AppStylesManager.customTextStyleG5,
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text('129', style: AppStylesManager.customTextStyleBl8),
                    Text(
                      lang.followers,
                      style: AppStylesManager.customTextStyleG5,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text('600', style: AppStylesManager.customTextStyleBl8),
                    Text(
                      lang.notified,
                      style: AppStylesManager.customTextStyleG5,
                    ),
                  ],
                ),
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
                      itemBuilder: (context, index) =>
                          filterContainer(items[index], index),
                      itemCount: items.length,
                    ),
                  ),
                ),
              ],
            ),
            BlocBuilder<ProductsCubit, ProductsState>(
              builder: (context, state) {
                return state.getStoreProducts.when(initial: () {
                  return buildShimmerIndicatorGrid();
                }, loading: () {
                  return buildShimmerIndicatorGrid();
                }, success: (productsList) {
                  return productsList.isEmpty
                      ? SizedBox(
                          height: 350.h,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'There is no products added yet.',
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
                              mainAxisExtent: 1.sw > 600 ? 320 : 220,
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
                                return Container(
                                  child: smallCardC(
                                    context: context,
                                    model: productsList[sizeIndex],
                                  ),
                                );
                              }
                            },
                          ),
                        );
                }, failure: (message) {
                  return Text(message);
                });
              },
            ),
          ],
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
        backgroundImage: AssetImage(image),
      ),
    );
  }
}
