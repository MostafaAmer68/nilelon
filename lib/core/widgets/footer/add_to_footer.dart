import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nilelon/core/data/hive_stroage.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/tools.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/features/auth/domain/model/user_model.dart';
import 'package:nilelon/features/cart/domain/model/add_cart_request_model.dart';
import 'package:nilelon/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:nilelon/features/layout/customer_bottom_tab_bar.dart';
import 'package:nilelon/features/product/domain/models/product_model.dart';
import 'package:nilelon/core/widgets/button/button_builder.dart';
import 'package:nilelon/core/widgets/button/gradient_button_builder.dart';

import '../../../generated/l10n.dart';

class AddToFooter extends StatelessWidget {
  const AddToFooter({super.key, this.visible = true, required this.product});
  final bool visible;
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BlocConsumer<CartCubit, CartState>(
                  listener: (context, state) {
                    if (state is CartSuccess) {
                      BotToast.showCustomText(
                        duration: const Duration(seconds: 4),
                        toastBuilder: (_) => Card(
                          color: Colors.black87,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  S.of(context).productAddedToCart,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                const SizedBox(width: 10),
                                TextButton(
                                  onPressed: () {
                                    BotToast.closeAllLoading();
                                    // BotToast.remove()

                                    navigateTo(
                                        context: context,
                                        screen: const CustomerBottomTabBar(
                                          index: 1,
                                        ));

                                    BotToast.cleanAll();
                                  },
                                  child: Text(
                                    S.of(context).viewCart,
                                    style: const TextStyle(color: Colors.blue),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    } else if (state is GetCartFailure) {
                      BotToast.showText(text: state.message);
                    }
                  },
                  builder: (context, state) {
                    return GradientButtonBuilder(
                      text: state is CartLoading
                          ? S.of(context).loading
                          : S.of(context).addToCart,
                      ontap: () {
                        if (HiveStorage.get(HiveKeys.userModel) != null) {
                          if (product.id.isNotEmpty) {
                            CartCubit.get(context).addToCart(
                              AddToCartModel(
                                quantity: CartCubit.get(context).counter,
                                size: CartCubit.get(context).selectedSize,
                                color: CartCubit.get(context).selectedColor,
                                productId: product.id,
                                customerId: HiveStorage.get<UserModel>(
                                        HiveKeys.userModel)
                                    .id,
                              ),
                            );
                          } else {
                            BotToast.showText(text: lang(context).smothingWent);
                          }
                        } else {
                          // CartCubit.get(context).getCart();
                          navigateTo(
                              context: context,
                              screen: const CustomerBottomTabBar(index: 3));
                        }
                      },
                    );
                  },
                ),
                ButtonBuilder(
                  text: S.of(context).buyNow,
                  ontap: () {
                    if (HiveStorage.get(HiveKeys.userModel) != null) {
                      ///TODO:
                    } else {
                      navigateTo(
                          context: context,
                          screen: const CustomerBottomTabBar(index: 3));
                    }
                  },
                  buttonColor: ColorManager.primaryW,
                  frameColor: ColorManager.gradientColors.first,
                  style: AppStylesManager.customTextStyleB4,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
