import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nilelon/core/data/hive_stroage.dart';
import 'package:nilelon/features/auth/domain/model/user_model.dart';
import 'package:nilelon/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:nilelon/features/cart/domain/model/delete_request_model.dart';
import 'package:nilelon/features/cart/data/repos_impl/cart_repos_impl.dart';
import 'package:nilelon/core/generated/l10n.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/service/set_up_locator_service.dart';
import 'package:nilelon/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/core/widgets/divider/default_divider.dart';
import 'package:nilelon/core/widgets/footer/cart_footer.dart';
import 'package:nilelon/core/widgets/cards/wide/cart_card.dart';
import 'package:nilelon/features/closet/presentation/view/closet_view.dart';
import 'package:nilelon/core/widgets/scaffold_image.dart';
import 'package:nilelon/core/widgets/shimmer_indicator/build_shimmer.dart';
import 'package:nilelon/core/widgets/view_all_row/view_all_row.dart';
import 'package:nilelon/core/utils/navigation.dart';

import '../../../../core/widgets/button/gradient_button_builder.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);

    return ScaffoldImage(
      appBar:
          customAppBar(title: lang.cart, context: context, hasLeading: false),
      body: Column(
        children: [
          const DefaultDivider(),
          const SizedBox(
            height: 8,
          ),
          ViewAllRow(
            text: '',
            onPressed: () {
              navigateTo(context: context, screen: const ClosetView());
            },
            buttonText: lang.yourcloset,
          ),
          const SizedBox(
            height: 8,
          ),
          BlocConsumer<CartCubit, CartState>(
            listener: (context, state) {
              if (state is DeleteFromCartSuccess) {
                BotToast.showText(text: 'Item deleted successfully');
              } else if (state is DeleteFromCartFailure) {
                BotToast.showText(
                  text: state.message,
                );
              } else {}
            },
            builder: (context, state) {
              if (state is CartLoading) {
                return Expanded(
                    child:
                        SingleChildScrollView(child: buildShimmerIndicator()));
              } else if (state is GetCartFailure) {
                return Text(state.message);
              } else if (state is GetCartSuccess) {
                return state.items.isEmpty
                    ? Column(
                        children: [
                          SizedBox(
                            height: screenHeight(context, 0.25),
                          ),
                          const Text('There is no products in the cart.'),
                        ],
                      )
                    : Column(
                        children: [
                          SizedBox(
                            height: screenHeight(context, 0.5),
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Slidable(
                                        key: ValueKey(index),
                                        endActionPane: ActionPane(
                                            motion: const BehindMotion(),
                                            dismissible: DismissiblePane(
                                                onDismissed: () {
                                              BlocProvider.of<CartCubit>(
                                                      context)
                                                  .deleteFromCart(
                                                DeleteRequestModel(
                                                  color:
                                                      state.items[index].color,
                                                  size: state.items[index].size,
                                                  productId: state
                                                      .items[index].productId,
                                                  customrId: HiveStorage.get<
                                                              UserModel>(
                                                          HiveKeys.userModel)
                                                      .id,
                                                ),
                                              );
                                            }),
                                            children: [
                                              SlidableAction(
                                                onPressed: (context) {
                                                  BlocProvider.of<CartCubit>(
                                                          context)
                                                      .deleteFromCart(
                                                    DeleteRequestModel(
                                                      color: state
                                                          .items[index].color,
                                                      size: state
                                                          .items[index].size,
                                                      productId: state
                                                          .items[index]
                                                          .productId,
                                                      customrId:
                                                          HiveStorage.get(
                                                              HiveKeys.userId),
                                                    ),
                                                  );
                                                },
                                                backgroundColor:
                                                    ColorManager.primaryO,
                                                icon: Iconsax.trash,
                                                foregroundColor:
                                                    ColorManager.primaryW,
                                                label: lang.delete,
                                              ),
                                            ]),
                                        child: BlocProvider<CartCubit>(
                                          create: (context) => CartCubit(
                                              locatorService<CartReposImpl>()),
                                          child: CartCard(
                                            cart: state.items[index],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                              itemCount: state.items.length,
                              padding: const EdgeInsets.only(bottom: 5),
                            ),
                          ),
                          const Divider(),
                          Align(
                            alignment: AlignmentDirectional.centerEnd,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: SizedBox(
                                width: screenWidth(context, 0.4),
                                child: OutlinedButton(
                                  onPressed: () {
                                    CartCubit.get(context).emptyCart();
                                  },
                                  style: OutlinedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: const BorderSide(
                                        color: ColorManager.primaryR,
                                      ),
                                    ),
                                    backgroundColor: ColorManager.scaffoldBG,
                                  ),
                                  child: Text(
                                    lang.emptyCart,
                                    style: const TextStyle(
                                      color: ColorManager.primaryR,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                        ],
                      );
              } else {
                return const Text('Something went wrong');
              }
            },
          ),
        ],
      ),
      persistentFooterButtons: [
        BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is GetCartSuccess) {
              return CartFooter(
                cartModel: state.items,
              );
            }
            return const SizedBox();
          },
        ),
      ],
    );
  }
}
