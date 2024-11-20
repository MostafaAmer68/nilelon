import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/tools.dart';
import 'package:nilelon/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/features/product/presentation/widgets/product_card/market_small_card.dart';
import 'package:nilelon/core/widgets/divider/default_divider.dart';
import 'package:nilelon/core/widgets/pop_ups/customer_store_popup.dart';
import 'package:nilelon/core/widgets/shimmer_indicator/build_shimmer.dart';
import 'package:nilelon/core/data/hive_stroage.dart';
import 'package:nilelon/features/product/presentation/cubit/products_cubit/products_cubit.dart';
import 'package:nilelon/generated/l10n.dart';

import '../../../../core/widgets/scaffold_image.dart';
import '../../../categories/domain/model/result.dart';
import '../../../product/presentation/cubit/products_cubit/products_state.dart';

class StoreProfileStore extends StatefulWidget {
  const StoreProfileStore(
      {super.key,
      required this.storeName,
      required this.image,
      required this.description});
  final String storeName;
  final String image;
  final String description;
  @override
  State<StoreProfileStore> createState() => _StoreProfileStoreState();
}

class _StoreProfileStoreState extends State<StoreProfileStore> {
  @override
  void initState() {
    ProductsCubit.get(context).getStoreProducts('');
    super.initState();
  }

  int _selectedIndex = 0;
  // String _indexName = 'All Items';
  @override
  Widget build(BuildContext context) {
    return ScaffoldImage(
      appBar: customAppBar(
        title: widget.storeName,
        context: context,
        onPressed: () {
          customerStoreDialog(context);
        },
        icon: Icons.more_vert_rounded,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const DefaultDivider(),
            const SizedBox(
              height: 30,
            ),
            circleItems(widget.image),
            const SizedBox(
              height: 16,
            ),
            Text(
              widget.storeName,
              style: AppStylesManager.customTextStyleBl8
                  .copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              widget.description,
              style: AppStylesManager.customTextStyleG5,
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
                      itemBuilder: (context, index) => filterContainer(
                          HiveStorage.get<List<CategoryModel>>(
                              HiveKeys.categories)[index],
                          index),
                      itemCount: HiveStorage.get<List<CategoryModel>>(
                              HiveKeys.categories)
                          .length,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: BlocBuilder<ProductsCubit, ProductsState>(
                builder: (context, state) {
                  return state.maybeWhen(initial: () {
                    return Text(S.of(context).waitingToGet);
                  }, loading: () {
                    return buildShimmerIndicatorGrid(context);
                  }, failure: (erro) {
                    return Text(erro);
                  }, storeProductSuccess: (products) {
                    return GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 20.0,
                              mainAxisExtent: 300,
                              mainAxisSpacing: 12),
                      shrinkWrap: true,
                      itemCount: ProductsCubit.get(context)
                          .products
                          .data
                          .where((e) =>
                              e.categoryID ==
                              HiveStorage.get<List<CategoryModel>>(
                                      HiveKeys.categories)[_selectedIndex]
                                  .id)
                          .toList()
                          .length,
                      itemBuilder: (context, index) {
                        return Container(
                          child: marketSmallCard(
                              context: context,
                              product: ProductsCubit.get(context)
                                  .products
                                  .data
                                  .where((e) =>
                                      e.categoryID ==
                                      localData<List<CategoryModel>>(HiveKeys
                                              .categories)[_selectedIndex]
                                          .id)
                                  .toList()[index]),
                        );
                      },
                    );
                  }, orElse: () {
                    return Text(S.of(context).waitingToGet);
                  })!;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector filterContainer(CategoryModel category, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
          // _indexName = name;
          ProductsCubit.get(context).getStoreProducts('');
          setState(() {});
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
                      category.name,
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
                      category.name,
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
