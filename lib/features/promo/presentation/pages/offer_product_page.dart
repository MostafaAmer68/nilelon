import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/core/data/hive_stroage.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/tools.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/core/widgets/button/gradient_button_builder.dart';
import 'package:nilelon/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/core/widgets/scaffold_image.dart';
import 'package:nilelon/features/auth/domain/model/user_model.dart';
import 'package:nilelon/features/product/presentation/cubit/products_cubit/products_cubit.dart';
import 'package:nilelon/features/promo/presentation/cubit/promo_cubit.dart';
import 'package:nilelon/features/promo/presentation/pages/apply_offer_page.dart';
import 'package:nilelon/features/refund/presentation/widgets/custom_check_box.dart';

import '../../../../core/resources/appstyles_manager.dart';
import '../../../../core/widgets/shimmer_indicator/build_shimmer.dart';
import '../../../../generated/l10n.dart';
import '../../../product/presentation/cubit/products_cubit/products_state.dart';
import '../../../product/presentation/widgets/product_card/product_squar_item.dart';

class OfferProductPage extends StatefulWidget {
  const OfferProductPage({super.key});

  @override
  State<OfferProductPage> createState() => _OfferProductPageState();
}

class _OfferProductPageState extends State<OfferProductPage> {
  late final PromoCubit cubit;
  late final ProductsCubit pcubit;
  @override
  void initState() {
    cubit = PromoCubit.get(context);
    pcubit = ProductsCubit.get(context);
    pcubit.getStoreProducts('');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return ScaffoldImage(
      appBar: customAppBar(title: lang.offers, context: context),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BlocListener<ProductsCubit, ProductsState>(
                  listener: (context, state) {
                    state.mapOrNull(success: (_) {
                      setState(() {});
                    });
                  },
                  child: Row(
                    children: [
                      GradientCheckBox(
                          value: cubit.selectedProducts.length ==
                              pcubit.storeProducts.data.length,
                          onChanged: (value) {
                            cubit.isSelectedAll = value;
                            if (value) {
                              if (cubit.selectedProducts.isNotEmpty) {
                                cubit.selectedProducts.clear();
                                cubit.selectedProducts
                                    .addAll(pcubit.storeProducts.data);
                              } else {
                                cubit.selectedProducts
                                    .addAll(pcubit.storeProducts.data);
                              }
                            } else {
                              cubit.selectedProducts.clear();
                            }
                            setState(() {});
                          }),
                      const SizedBox(width: 10),
                      Text(lang.selectAll),
                    ],
                  ),
                ),
                Text(
                    '${lang.selected} ${cubit.selectedProducts.length} / ${pcubit.storeProducts.data.length}'),
              ],
            ),
          ),
          const SizedBox(height: 20),
          BlocBuilder<ProductsCubit, ProductsState>(
            builder: (context, state) {
              return state.maybeWhen(initial: () {
                return Expanded(child: buildShimmerIndicatorGrid(context));
              }, loading: () {
                return Expanded(child: buildShimmerIndicatorGrid(context));
              }, storeProductSuccess: (products) {
                if (products.data.isEmpty) {
                  return Center(
                    child: Text(
                      S.of(context).thereNoProduct,
                      style: AppStylesManager.customTextStyleG2,
                    ),
                  );
                } else {
                  return Container(
                    height: screenHeight(context, 0.70),
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: GridView.builder(
                      gridDelegate: gridDelegate(context),
                      shrinkWrap: true,
                      itemCount: products.data.length,
                      itemBuilder: (context, index) {
                        final product = products.data[index];
                        return productSquarItem(
                          context: context,
                          isSelectable: true,
                          isSelected: cubit.selectedProducts.contains(product),
                          onTap: (value) {
                            if (value) {
                              cubit.selectedProducts.add(product);
                            } else {
                              cubit.selectedProducts.remove(product);
                              cubit.isSelectedAll = false;
                            }
                            setState(() {});
                          },
                          product: product,
                        );
                      },
                    ),
                  );
                }
              }, failure: (message) {
                return Text(message);
              }, orElse: () {
                if (pcubit.storeProducts.data.isEmpty) {
                  return Center(
                    child: Text(
                      S.of(context).thereNoProduct,
                      style: AppStylesManager.customTextStyleG2,
                    ),
                  );
                } else {
                  return Container(
                    height: screenHeight(context, 0.70),
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: GridView.builder(
                      gridDelegate: gridDelegate(context),
                      shrinkWrap: true,
                      itemCount: pcubit.storeProducts.data.length,
                      itemBuilder: (context, index) {
                        final product = pcubit.storeProducts.data[index];
                        return productSquarItem(
                          context: context,
                          isSelectable: true,
                          isSelected: cubit.selectedProducts.contains(product),
                          onTap: (value) {
                            if (value) {
                              cubit.selectedProducts.add(product);
                            } else {
                              cubit.selectedProducts.remove(product);
                              cubit.isSelectedAll = false;
                            }
                            setState(() {});
                          },
                          product: product,
                        );
                      },
                    ),
                  );
                }
              });
            },
          ),
          // const Spacer(),
        ],
      ),
      btmBar: SizedBox(
        height: 90,
        child: GradientButtonBuilder(
          text: lang.continuePress,
          width: screenWidth(context, 0.9),
          ontap: () {
            if (cubit.selectedProducts.isEmpty) {
              BotToast.showText(text: lang.youMustSelectOneProduct);
            } else {
              navigateTo(context: context, screen: const ApplyOfferPage());
            }
          },
        ),
      ),
    );
  }
}
