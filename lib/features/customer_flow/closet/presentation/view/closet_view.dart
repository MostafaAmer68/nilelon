import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nilelon/features/customer_flow/closet/presentation/cubit/closet_cubit.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/resources/color_manager.dart';
import 'package:nilelon/resources/const_functions.dart';
import 'package:nilelon/resources/appstyles_manager.dart';
import 'package:nilelon/utils/navigation.dart';
import 'package:nilelon/widgets/button/button_builder.dart';
import 'package:nilelon/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/features/customer_flow/closet/presentation/widget/closet_widget_with_options.dart';
import 'package:nilelon/widgets/pop_ups/create_new_section_popup.dart';
import 'package:nilelon/widgets/view_all_row/view_all_row.dart';
import 'package:nilelon/features/customer_flow/section_details/section_details_view.dart';

class ClosetView extends StatefulWidget {
  const ClosetView({super.key});

  @override
  State<ClosetView> createState() => _ClosetViewState();
}

class _ClosetViewState extends State<ClosetView> {
  @override
  void initState() {
    ClosetCubit.get(context).getclosets();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return Scaffold(
      backgroundColor: ColorManager.primaryW,
      appBar: customAppBar(title: lang.closet, context: context),
      body: Column(
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
                onPressed: () {},
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
                          return const Center(
                              child: CircularProgressIndicator());
                        },
                        success: () {
                          return ListView.builder(
                              shrinkWrap: true,
                              itemCount:
                                  ClosetCubit.get(context).closets.length,
                              itemBuilder: (context, index) {
                                final closet =
                                    ClosetCubit.get(context).closets[index];
                                return ClosetsWidgetWithOptions(
                                  closet: closet,
                                  onTap: () {
                                    //  ClosetCubit.get(context).addProductToClosets(productId)
                                  },
                                );
                              });
                        },
                        failure: () {
                          return const Icon(Icons.error);
                        },
                      )!;
                    },
                  ),
                ],
              ),
            ],
          )
        ],
      ),
      persistentFooterButtons: [
        ButtonBuilder(
            text: lang.addNewSection,
            width: screenWidth(context, 0.94),
            ontap: () {
              createNewSectionDialog(context);
            })
      ],
    );
  }
}
