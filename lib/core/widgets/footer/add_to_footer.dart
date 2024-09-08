import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:nilelon/core/data/hive_stroage.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/features/auth/domain/model/user_model.dart';
import 'package:nilelon/features/cart/domain/model/add_cart_request_model.dart';
import 'package:nilelon/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:nilelon/features/product/domain/models/product_model.dart';
import 'package:nilelon/core/widgets/button/button_builder.dart';
import 'package:nilelon/core/widgets/button/gradient_button_builder.dart';

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
                        duration: Duration(seconds: 4),
                        toastBuilder: (_) => Card(
                          color: Colors.black87,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "This is a toast message",
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(width: 10),
                                TextButton(
                                  onPressed: () {
                                    BotToast.closeAllLoading();
                                  },
                                  child: Text(
                                    "View Cart",
                                    style: TextStyle(color: Colors.blue),
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
                      text: state is CartLoading ? 'Loading...' : 'Add To Cart',
                      ontap: () {
                        CartCubit.get(context).addToCart(
                          AddToCartModel(
                            quantity: CartCubit.get(context).counter,
                            size: CartCubit.get(context).selectedSize,
                            color: CartCubit.get(context).selectedColor,
                            productId: product.id,
                            customerId:
                                HiveStorage.get<UserModel>(HiveKeys.userModel)
                                    .id,
                          ),
                        );
                      },
                    );
                  },
                ),
                ButtonBuilder(
                  text: 'Buy Now',
                  ontap: () {},
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
