import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nilelon/data/hive_stroage.dart';
import 'package:nilelon/features/customer_flow/cart/cubit/cart_cubit.dart';
import 'package:nilelon/features/customer_flow/cart/model/delete_request_model.dart';
import 'package:nilelon/features/customer_flow/cart/repos_impl/cart_repos_impl.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/resources/color_manager.dart';
import 'package:nilelon/resources/const_functions.dart';
import 'package:nilelon/service/set_up_locator_service.dart';
import 'package:nilelon/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/widgets/divider/default_divider.dart';
import 'package:nilelon/widgets/footer/cart_footer.dart';
import 'package:nilelon/widgets/cards/wide/cart_card.dart';
import 'package:nilelon/features/customer_flow/closet/view/closet_view.dart';
import 'package:nilelon/widgets/shimmer_indicator/build_shimmer.dart';
import 'package:nilelon/widgets/view_all_row/view_all_row.dart';
import 'package:nilelon/utils/navigation.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);

    return Scaffold(
      backgroundColor: ColorManager.primaryW,
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
          BlocBuilder<CartCubit, CartState>(
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
                    : Expanded(
                        child: ListView.builder(
                          itemBuilder: (context, index) => Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              BlocListener<CartCubit, CartState>(
                                listener: (context, state) {
                                  if (state is DeleteFromCartSuccess) {
                                    BotToast.showText(
                                        text: 'Item deleted successfully');
                                  } else if (state is DeleteFromCartFailure) {
                                    BotToast.showText(
                                      text: state.message,
                                    );
                                  } else {}
                                },
                                child: Slidable(
                                  key: ValueKey(index),
                                  endActionPane: ActionPane(
                                      motion: const BehindMotion(),
                                      dismissible:
                                          DismissiblePane(onDismissed: () {
                                        BlocProvider.of<CartCubit>(context)
                                            .deleteFromCart(
                                          DeleteRequestModel(
                                            color: state.items[index].color,
                                            size: state.items[index].size,
                                            productId:
                                                state.items[index].productId,
                                            customrId: HiveStorage.get(
                                                HiveKeys.idToken),
                                          ),
                                        );
                                      }),
                                      children: [
                                        SlidableAction(
                                          onPressed: (context) {
                                            BlocProvider.of<CartCubit>(context)
                                                .deleteFromCart(
                                              DeleteRequestModel(
                                                color: state.items[index].color,
                                                size: state.items[index].size,
                                                productId: state
                                                    .items[index].productId,
                                                customrId: HiveStorage.get(
                                                    HiveKeys.idToken),
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
                                      counter: state.items[index].quantity!,
                                      size: state.items[index].size!,
                                      color: state.items[index].color!,
                                      productId: state.items[index].productId!,
                                      cartId: state.items[index].cartId!,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          itemCount: state.items.length,
                          padding: const EdgeInsets.only(bottom: 12),
                        ),
                      );
              } else {
                return const Text('Something went wrong');
              }
            },
          ),
        ],
      ),
      persistentFooterButtons: const [CartFooter()],
    );
  }
}
