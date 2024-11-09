import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nilelon/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/core/widgets/button/button_builder.dart';
import 'package:nilelon/core/widgets/button/gradient_button_builder.dart';
import 'package:nilelon/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/core/widgets/divider/default_divider.dart';
import 'package:nilelon/core/widgets/pop_ups/success_creation_popup.dart';
import 'package:nilelon/core/widgets/text_form_field/text_and_form_field_column/without_icon/text_and_form_field_column_no_icon.dart';

import '../../../../core/tools.dart';
import '../../../../core/widgets/scaffold_image.dart';
import '../../../../my_app.dart';
import '../../../auth/domain/model/user_model.dart';

class EditStoreInfoView extends StatefulWidget {
  const EditStoreInfoView({super.key});

  @override
  State<EditStoreInfoView> createState() => _EditStoreInfoViewState();
}

class _EditStoreInfoViewState extends State<EditStoreInfoView> {
  late final ProfileCubit cubit;
  @override
  void initState() {
    cubit = ProfileCubit.get(context);
    cubit.repNameController =
        TextEditingController(text: currentUsr<StoreModel>().repName);
    cubit.repPhoneController =
        TextEditingController(text: currentUsr<StoreModel>().repPhone);
    cubit.wareHouseAddressController =
        TextEditingController(text: currentUsr<StoreModel>().warehouseAddress);
    // cubit.websiteLinkController =
    //     TextEditingController(text: currentUsr<StoreModel>().);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);

    return ScaffoldImage(
      appBar: customAppBar(
        title: lang.storeInfo,
        context: context,
        hasIcon: false,
      ),
      body: SingleChildScrollView(
        child: BlocListener<ProfileCubit, ProfileState>(
          listener: (context, state) {
            state.mapOrNull(
              loading: (_) {
                BotToast.showLoading();
              },
              success: (_) {
                BotToast.closeAllLoading();
                successCreationDialog(
                    context: context,
                    highlightedText: S.of(context).infoUpdate,
                    regularText: '',
                    buttonText: lang.save,
                    ontap: () {
                      MyApp.restartApp(context);
                    });
              },
              failure: (_) {
                BotToast.closeAllLoading();
                BotToast.showText(text: _.er);
              },
            );
          },
          child: Column(
            children: [
              const DefaultDivider(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 24,
                    ),
                    TextAndFormFieldColumnNoIcon(
                      title: lang.storeRepresentativeName,
                      label: 'Twixi',
                      height: 25,
                      controller: cubit.repNameController,
                      type: TextInputType.text,
                    ),
                    TextAndFormFieldColumnNoIcon(
                      title: lang.storeRepresentativeNumber,
                      label: '01000000000',
                      controller: cubit.repPhoneController,
                      height: 25,
                      type: TextInputType.phone,
                    ),
                    TextAndFormFieldColumnNoIcon(
                      title: lang.websiteLink,
                      label: 'TwixiShop',
                      controller: cubit.websiteLinkController,
                      height: 25,
                      type: TextInputType.text,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: screenHeight(context, 0.11),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ButtonBuilder(
                      text: lang.cancel,
                      width: screenWidth(context, 0.44),
                      height: screenHeight(context, 0.06),
                      ontap: () {
                        navigatePop(context: context);
                      },
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    GradientButtonBuilder(
                      text: lang.save,
                      width: screenWidth(context, 0.44),
                      height: screenHeight(context, 0.06),
                      ontap: () {
                        ProfileCubit.get(context).updateStoreInfo(context);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              )
            ],
          ),
        ),
      ),
    );
  }
}
