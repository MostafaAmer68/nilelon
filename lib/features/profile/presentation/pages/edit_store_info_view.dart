import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nilelon/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:nilelon/core/generated/l10n.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/core/widgets/button/button_builder.dart';
import 'package:nilelon/core/widgets/button/gradient_button_builder.dart';
import 'package:nilelon/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/core/widgets/divider/default_divider.dart';
import 'package:nilelon/core/widgets/pop_ups/success_creation_popup.dart';
import 'package:nilelon/core/widgets/text_form_field/text_and_form_field_column/without_icon/text_and_form_field_column_no_icon.dart';

class EditStoreInfoView extends StatelessWidget {
  const EditStoreInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);

    return Scaffold(
      backgroundColor: ColorManager.primaryW,
      appBar: customAppBar(
        title: lang.storeInfo,
        context: context,
        hasIcon: false,
      ),
      body: SingleChildScrollView(
        child: BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is LoginLoading) {
              BotToast.showLoading();
            }
            if (state is LoginFailure) {
              BotToast.closeAllLoading();
              BotToast.showText(text: state.errorMessage);
            }
            if (state is UpdateStoreSuccess) {
              BotToast.closeAllLoading();
              successCreationDialog(
                  context: context,
                  highlightedText: 'Info has been updated successfully',
                  regularText: '',
                  buttonText: lang.save,
                  ontap: () {
                    navigatePop(context: context);
                  });
            }
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
                      controller: AuthCubit.get(context).repNameController,
                      type: TextInputType.text,
                    ),
                    TextAndFormFieldColumnNoIcon(
                      title: lang.storeRepresentativeNumber,
                      label: '01000000000',
                      controller: AuthCubit.get(context).repPhoneController,
                      height: 25,
                      type: TextInputType.phone,
                    ),
                    TextAndFormFieldColumnNoIcon(
                      title: lang.warehouseAddress,
                      label: 'Cairo',
                      controller: TextEditingController(),
                      height: 25,
                      type: TextInputType.text,
                    ),
                    // TextAndFormFieldColumnNoIcon(
                    //   title: lang.profileLink,
                    //   label: 'TwixiShop',
                    //   controller: AuthCubit.get(context).re,
                    //   height: 25,
                    //   desc: ' (Facebook or Instagram)',
                    //   type: TextInputType.text,
                    // ),
                    TextAndFormFieldColumnNoIcon(
                      title: lang.websiteLink,
                      label: 'TwixiShop',
                      controller: AuthCubit.get(context).websiteLinkController,
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
                        buttonColor: Colors.transparent,
                        frameColor: ColorManager.primaryB2,
                        style: AppStylesManager.customTextStyleB4,
                        ontap: () {
                          navigatePop(context: context);
                        }),
                    const SizedBox(
                      width: 12,
                    ),
                    GradientButtonBuilder(
                      text: lang.save,
                      width: screenWidth(context, 0.44),
                      height: screenHeight(context, 0.06),
                      ontap: () {
                        AuthCubit.get(context).updateStoreInfo(context);
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
