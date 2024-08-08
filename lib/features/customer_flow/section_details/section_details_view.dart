import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nilelon/features/customer_flow/closet/domain/model/closet_model.dart';
import 'package:nilelon/features/customer_flow/closet/presentation/cubit/closet_cubit.dart';
import 'package:nilelon/resources/color_manager.dart';
import 'package:nilelon/widgets/cards/small/section_small_card.dart';
import 'package:nilelon/widgets/custom_app_bar/custom_app_bar.dart';

class SectionDetailsView extends StatefulWidget {
  const SectionDetailsView({super.key, required this.closet});
  final ClosetModel closet;
  @override
  State<SectionDetailsView> createState() => _SectionDetailsViewState();
}

class _SectionDetailsViewState extends State<SectionDetailsView> {
  @override
  void initState() {
    ClosetCubit.get(context).getClosetsItems(widget.closet.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BotToast.closeAllLoading();
    return Scaffold(
      backgroundColor: ColorManager.primaryW,
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
                ClosetCubit.get(context).getclosets();
              },
              success: (_) {
                // Navigator.pop(context);
              },
              failure: (_) {});
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
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.85,
                      crossAxisCount: 2,
                      crossAxisSpacing: 20.0,
                      mainAxisSpacing: 12),
                  itemCount: ClosetCubit.get(context).closetsItem.length,
                  itemBuilder: (context, index) {
                    return Container(
                      child: sectionSmallCard(
                          context: context,
                          product: ClosetCubit.get(context).closetsItem[index],
                          closetId: widget.closet.id),
                    );
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
