import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/core/widgets/button/gradient_button_builder.dart';
import 'package:nilelon/features/closet/presentation/cubit/closet_cubit.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/features/closet/presentation/widget/closet_widget_with_options.dart';
import 'package:nilelon/core/widgets/view_all_row/view_all_row.dart';

import '../../../../core/tools.dart';
import '../../../../core/widgets/scaffold_image.dart';
import '../../../../core/widgets/shimmer_indicator/build_shimmer.dart';
import '../../../product/presentation/widgets/product_card/section_small_card.dart';
import '../widget/create_section_widget.dart';
import 'closet_product_page.dart';

class ClosetPage extends StatefulWidget {
  const ClosetPage({super.key, this.productId = ''});
  final String productId;
  @override
  State<ClosetPage> createState() => _ClosetViewState();
}

class _ClosetViewState extends State<ClosetPage> {
  @override
  void initState() {
    ClosetCubit.get(context).getclosets();
    super.initState();
  }

  bool isClosetItem = false;
  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    // BotToast.closeAllLoading();
    return ScaffoldImage(
      appBar: customAppBar(title: lang.closet, context: context),
      body: BlocListener<ClosetCubit, ClosetState>(
        listener: (context, state) {
          state.mapOrNull(success: (_) {
            BotToast.closeAllLoading();
          }, successDelete: (_) {
            ClosetCubit.get(context).getclosets();
          });
        },
        child: Column(
          children: [
            const Divider(
              color: ColorManager.primaryG8,
            ),
            Column(
              children: [
                const SizedBox(
                  height: 16,
                ),
                ViewAllRow(
                  text: lang.yourSections,
                  onPressed: () {
                    ClosetCubit.get(context).getAllClosetsItems();
                    isClosetItem = !isClosetItem;
                    setState(() {});
                  },
                  buttonWidget: Text(
                    lang.showItems,
                    style: AppStylesManager.customTextStyleO,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                BlocBuilder<ClosetCubit, ClosetState>(
                  builder: (context, state) {
                    return state.whenOrNull(
                      loading: () {
                        return SizedBox(
                          height: screenHeight(context, 0.65),
                          child: isClosetItem
                              ? buildShimmerIndicatorGrid(context)
                              : buildShimmerIndicator(),
                        );
                      },
                      successDelete: () {
                        if (isClosetItem) {
                          return BlocListener<ClosetCubit, ClosetState>(
                            listener: (context, state) {
                              state.mapOrNull(
                                loading: (_) {
                                  BotToast.showLoading();
                                },
                                successDelete: (_) {
                                  BotToast.closeAllLoading();
                                  BotToast.showText(text: 'success delete');
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
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child:
                                        BlocBuilder<ClosetCubit, ClosetState>(
                                      builder: (context, state) {
                                        return state.whenOrNull(
                                          loading: () =>
                                              buildShimmerIndicatorGrid(
                                                  context),
                                          success: () => GridView.builder(
                                            gridDelegate: gridDelegate(context),
                                            itemCount: ClosetCubit.get(context)
                                                .closetsItem
                                                .length,
                                            itemBuilder: (context, index) {
                                              return Container(
                                                child: sectionSmallCard(
                                                    context: context,
                                                    product:
                                                        ClosetCubit.get(context)
                                                            .closetsItem[index],
                                                    closetId: ''),
                                              );
                                            },
                                          ),
                                          failure: () =>
                                              Text(S.of(context).smothingWent),
                                        )!;
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: ClosetCubit.get(context).closets.length,
                          itemBuilder: (context, index) {
                            final closet =
                                ClosetCubit.get(context).closets[index];
                            return ClosetsWidgetWithOptions(
                              isPage: true,
                              closet: closet,
                              onTap: () {
                                navigateTo(
                                  context: context,
                                  screen: ProductClosetPage(closet: closet),
                                );
                              },
                            );
                          },
                        );
                      },
                      success: () {
                        if (isClosetItem) {
                          return Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: BlocBuilder<ClosetCubit, ClosetState>(
                              builder: (context, state) {
                                return state.whenOrNull(
                                  loading: () =>
                                      buildShimmerIndicatorGrid(context),
                                  success: () => SizedBox(
                                    width: screenWidth(context, 1),
                                    height: screenHeight(context, 0.64),
                                    child: GridView.builder(
                                      shrinkWrap: true,
                                      gridDelegate: gridDelegate(context),
                                      itemCount: ClosetCubit.get(context)
                                          .closetsItem
                                          .length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          child: sectionSmallCard(
                                            context: context,
                                            product: ClosetCubit.get(context)
                                                .closetsItem[index],
                                            closetId: '',
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  failure: () => Text(
                                    S.of(context).smothingWent,
                                  ),
                                )!;
                              },
                            ),
                          );
                        }
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: ClosetCubit.get(context).closets.length,
                          itemBuilder: (context, index) {
                            final closet =
                                ClosetCubit.get(context).closets[index];
                            return ClosetsWidgetWithOptions(
                              isPage: true,
                              closet: closet,
                              onTap: () {
                                navigateTo(
                                  context: context,
                                  screen: ProductClosetPage(closet: closet),
                                );
                              },
                            );
                          },
                        );
                      },
                      failure: () {
                        return const Icon(Icons.error);
                      },
                    )!;
                  },
                ),
              ],
            )
          ],
        ),
      ),
      persistentFooterButtons: [
        GradientButtonBuilder(
            text: lang.addNewSection,
            width: screenWidth(context, 0.94),
            ontap: () {
              showModalBottomSheet(
                backgroundColor: ColorManager.primaryW,
                isScrollControlled: true,
                useSafeArea: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                context: context,
                builder: (BuildContext context) {
                  return const CreateNewSection();
                },
              );
            })
      ],
    );
  }

  // Future<dynamic> showBtmSheet(BuildContext context) {
  //   return
  // }
}
