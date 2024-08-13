import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nilelon/data/hive_stroage.dart';
import 'package:nilelon/features/cart/domain/model/add_cart_request_model.dart';
import 'package:nilelon/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:nilelon/features/product/domain/models/product_model.dart';
import 'package:nilelon/features/product/domain/models/product_data/product_data.dart';
import 'package:nilelon/widgets/button/button_builder.dart';
import 'package:nilelon/widgets/button/gradient_button_builder.dart';

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
                BlocBuilder<CartCubit, CartState>(
                  builder: (context, state) {
                    return GradientButtonBuilder(
                        text:
                            state is CartLoading ? 'Loading...' : 'Add To Cart',
                        ontap: () {
                          CartCubit.get(context).addToCart(AddToCartModel(
                              quantity: 1,
                              size: product.productVariants![0].size!,
                              color: product.productVariants![0].color!.toInt(),
                              productId: product.id!,
                              customerId: HiveStorage.get(HiveKeys.userId)));
                        });
                  },
                ),
                ButtonBuilder(text: 'Buy Now', ontap: () {})
              ],
            ),
          ),
        ],
      ),
    );
  }
}
