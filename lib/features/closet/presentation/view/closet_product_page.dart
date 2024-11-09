import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/tools.dart';
import 'package:nilelon/core/widgets/shimmer_indicator/build_shimmer.dart';
import 'package:nilelon/core/widgets/view_all_row/view_all_row.dart';
import 'package:nilelon/features/closet/domain/model/closet_model.dart';
import 'package:nilelon/features/closet/presentation/cubit/closet_cubit.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/features/product/presentation/widgets/product_card/section_small_card.dart';
import 'package:nilelon/core/widgets/custom_app_bar/custom_app_bar.dart';

import '../../../../core/widgets/scaffold_image.dart';
import '../../../../generated/l10n.dart';

class ProductClosetPage extends StatefulWidget {
  const ProductClosetPage({super.key, required this.closet});
  final ClosetModel closet;
  @override
  State<ProductClosetPage> createState() => _ProductClosetPageState();
}

class _ProductClosetPageState extends State<ProductClosetPage> {
  @override
  void initState() {
    ClosetCubit.get(context).getClosetsItems(widget.closet.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // BotToast.closeAllLoading();
    return ScaffoldImage(
      appBar: customAppBar(title: widget.closet.name, context: context),
      body: BlocListener<ClosetCubit, ClosetState>(
        listener: (context, state) {
          state.mapOrNull(
            loading: (_) {
              BotToast.showLoading();
            },
            successDelete: (_) {
              BotToast.closeAllLoading();
              BotToast.showText(text: 'success delete');
              ClosetCubit.get(context).getClosetsItems(widget.closet.id);
            },
            success: (_) {
              BotToast.closeAllLoading();
            },
            failure: (_) {},
          );
        },
        child: Column(
          children: [
            const SizedBox(
              height: 4,
              child: Divider(
                color: ColorManager.primaryG8,
              ),
            ),
            Visibility(
              visible: ClosetCubit.get(context).closetsItem.isNotEmpty,
              child: Align(
                alignment: AlignmentDirectional.topEnd,
                child: TextButton(
                    onPressed: () {
                      ClosetCubit.get(context).emptyCloset(widget.closet.id);
                    },
                    child: Text(
                      lang(context).emptyCloset,
                      style: AppStylesManager.customTextStyleR,
                    )),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: BlocBuilder<ClosetCubit, ClosetState>(
                  builder: (context, state) {
                    return state.whenOrNull(
                      loading: () => buildShimmerIndicatorGrid(context),
                      success: () {
                        if (ClosetCubit.get(context).closetsItem.isEmpty) {
                          return Center(
                            child: SizedBox(
                              height: screenHeight(context, 0.1),
                              child: Text(lang(context)
                                  .noProductCart
                                  .replaceAll('cart', 'closet')),
                            ),
                          );
                        }
                        return GridView.builder(
                          gridDelegate: gridDelegate(context),
                          itemCount:
                              ClosetCubit.get(context).closetsItem.length,
                          itemBuilder: (context, index) {
                            return Container(
                              child: sectionSmallCard(
                                  context: context,
                                  product: ClosetCubit.get(context)
                                      .closetsItem[index],
                                  closetId: widget.closet.id),
                            );
                          },
                        );
                      },
                      failure: () => Text(S.of(context).smothingWent),
                    )!;
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
