import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/features/closet/presentation/cubit/closet_cubit.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/features/closet/presentation/widget/closet_widget_with_options.dart';
import 'package:nilelon/core/widgets/view_all_row/view_all_row.dart';

import '../../../../core/color_const.dart';
import '../widget/create_section_widget.dart';

class ClosetSheetBarView extends StatefulWidget {
  const ClosetSheetBarView({super.key, this.productId = ''});
  final String productId;
  @override
  State<ClosetSheetBarView> createState() => _ClosetViewState();
}

class _ClosetViewState extends State<ClosetSheetBarView> {
  @override
  void initState() {
    ClosetCubit.get(context).getclosets();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return Scaffold(
      backgroundColor: ColorManager.primaryGB3,
      appBar: AppBar(
        backgroundColor: ColorManager.primaryW,
        automaticallyImplyLeading: false,
        actions: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: colorConst
                  .map(
                    (e) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      width: 10.w,
                      height: 10.w,
                      decoration: BoxDecoration(
                        color: e,
                        shape: BoxShape.circle,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          ViewAllRow(
            text: lang.saveToCloset,
            onPressed: () {},
            noButton: true,
            buttonWidget: Text(
              lang.showItems,
              style: AppStylesManager.customTextStyleO,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              BlocBuilder<ClosetCubit, ClosetState>(
                builder: (context, state) {
                  return state.whenOrNull(
                    loading: () {
                      return const Center(child: CircularProgressIndicator());
                    },
                    success: () {
                      return SizedBox(
                        width: screenWidth(context, 1),
                        height: screenHeight(context, 0.4),
                        child: ListView.builder(
                          itemCount: ClosetCubit.get(context).closets.length,
                          itemBuilder: (context, index) {
                            final closet =
                                ClosetCubit.get(context).closets[index];
                            return Container(
                              child: index == 0
                                  ? Container(
                                      margin: const EdgeInsets.only(
                                        top: 16,
                                        bottom: 16,
                                        left: 13,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 12),
                                      child: ListTile(
                                        onTap: () {
                                          showModalBottomSheet(
                                            backgroundColor:
                                                ColorManager.primaryW,
                                            shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(30),
                                                topRight: Radius.circular(30),
                                              ),
                                            ),
                                            clipBehavior:
                                                Clip.antiAliasWithSaveLayer,
                                            context: context,
                                            builder: (BuildContext context) {
                                              return const CreateNewSection();
                                            },
                                          );
                                        },
                                        leading: Container(
                                          padding: const EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            border: Border.all(),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: const Icon(Icons.add),
                                        ),
                                        title: Text(lang.addNewSection),
                                      ),
                                    )
                                  : ClosetsWidgetWithOptions(
                                      closet: closet,
                                      isPage: false,
                                      onTap: () {
                                        ClosetCubit.get(context)
                                            .addProductToClosets(
                                          widget.productId,
                                          closet.id,
                                        );
                                      },
                                    ),
                            );
                          },
                        ),
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
    );
  }
}