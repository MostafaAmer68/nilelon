import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nilelon/core/data/hive_stroage.dart';
import 'package:nilelon/features/auth/domain/model/user_model.dart';
import 'package:nilelon/features/cart/domain/model/get_cart_model/cart_item.dart';
import 'package:nilelon/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:nilelon/features/cart/domain/model/change_quantity_model.dart';
import 'package:nilelon/core/generated/l10n.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/widgets/button/small_button.dart';

class CartCard extends StatefulWidget {
  const CartCard({
    super.key,
    required this.cart,
  });
  final CartItem cart;
  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  int localCounter = 1;
  bool isEnabled = true;
  @override
  void initState() {
    localCounter = widget.cart.quantity!;
    super.initState();
  }

  void incrementCounter() {
    setState(() {
      localCounter++;
    });
  }

  void decrementCounter() {
    setState(() {
      localCounter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);

    return Column(
      children: [
        GestureDetector(
          onTap: () {
            // navigateTo(
            //     context: context,
            //     screen: ProductDetailsView(
            //    product: model,
            //     ));
          },
          child: SizedBox(
            width: screenWidth(context, 0.9),
            child: Container(
              clipBehavior: Clip.antiAlias,
              height: 1.sw > 600 ? 160 : 150,
              margin: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: ColorManager.primaryG6,
                    blurRadius: 10,
                    offset: Offset(0, 2),
                    spreadRadius: 0,
                  )
                ],
                color: ColorManager.primaryW,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 12,
                  ),
                  Container(
                    width: 1.sw > 600 ? 110 : 80,
                    height: 1.sw > 600 ? 130 : 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: const DecorationImage(
                            image: AssetImage('assets/images/app_logo.png'),
                            fit: BoxFit.cover)),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 8,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  widget.cart.productName!,
                                  style: AppStylesManager.customTextStyleBl7
                                      .copyWith(fontSize: 1.sw > 600 ? 22 : 14),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Checkbox(
                                  splashRadius: 1.sw > 600 ? 20 : 12,
                                  value: isEnabled,
                                  activeColor: ColorManager.primaryO,
                                  onChanged: (value) {
                                    isEnabled = !isEnabled;
                                    setState(() {});
                                  }),
                            ],
                          ),
                          // const SizedBox(
                          //   height: 12,
                          // ),
                          Text(
                            '${lang.size} ${widget.cart.size!}',
                            style: AppStylesManager.customTextStyleG5,
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${widget.cart.price!} L.E',
                                style: AppStylesManager.customTextStyleO2,
                              ),
                              const Spacer(),
                              BlocListener<CartCubit, CartState>(
                                listener: (context, state) {
                                  if (state is UpdateQuantityCartFailure) {
                                    incrementCounter();
                                  }
                                },
                                child: localCounter == 1
                                    ? SmallButton(
                                        icon: Iconsax.minus,
                                        color: ColorManager.primaryG3,
                                        onTap: () {},
                                      )
                                    : SmallButton(
                                        icon: Iconsax.minus,
                                        onTap: () {
                                          decrementCounter();
                                          BlocProvider.of<CartCubit>(context)
                                              .updateQuantityCart(
                                                  ChangeQuantityModel(
                                            customrId:
                                                HiveStorage.get<UserModel>(
                                                        HiveKeys.userModel)
                                                    .id,
                                            size: widget.cart.size,
                                            color: widget.cart.color!,
                                            productId: widget.cart.productId,
                                            quantity: localCounter,
                                          ));
                                        },
                                      ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(localCounter.toString()),
                              const SizedBox(
                                width: 8,
                              ),
                              BlocListener<CartCubit, CartState>(
                                listener: (context, state) {
                                  if (state is UpdateQuantityCartFailure) {
                                    decrementCounter();
                                  }
                                },
                                child: SmallButton(
                                  icon: Iconsax.add,
                                  onTap: () {
                                    incrementCounter();
                                    BlocProvider.of<CartCubit>(context)
                                        .updateQuantityCart(ChangeQuantityModel(
                                      customrId: HiveStorage.get<UserModel>(
                                              HiveKeys.userModel)
                                          .id,
                                      size: widget.cart.size,
                                      color: widget.cart.color!,
                                      productId: widget.cart.productId,
                                      quantity: localCounter,
                                    ));
                                  },
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 12,
        )
      ],
    );
  }
}
