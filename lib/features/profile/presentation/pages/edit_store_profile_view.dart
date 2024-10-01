import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nilelon/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/core/widgets/button/button_builder.dart';
import 'package:nilelon/core/widgets/button/gradient_button_builder.dart';
import 'package:nilelon/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/core/widgets/divider/default_divider.dart';
import 'package:nilelon/core/widgets/pop_ups/camera_popup.dart';
import 'package:nilelon/core/widgets/text_form_field/text_and_form_field_column/without_icon/text_and_form_field_column_no_icon.dart';

import '../../../../core/widgets/pop_ups/success_creation_popup.dart';
import '../../../../core/widgets/scaffold_image.dart';

class EditStoreProfileView extends StatefulWidget {
  const EditStoreProfileView({super.key});

  @override
  State<EditStoreProfileView> createState() => _EditStoreProfileViewState();
}

class _EditStoreProfileViewState extends State<EditStoreProfileView> {
  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return ScaffoldImage(
      appBar: customAppBar(
        title: lang.profileInfo,
        context: context,
        hasIcon: false,
      ),
      body: BlocListener<AuthCubit, AuthState>(
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
                highlightedText:
                    'Info has been updated successfully\nplease relogin to update your info',
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
            photosStack(context),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextAndFormFieldColumnNoIcon(
                    title: lang.storeName,
                    label: 'Twixi',
                    height: 25,
                    controller: AuthCubit.get(context).nameController,
                    type: TextInputType.text,
                  ),
                  TextAndFormFieldColumnNoIcon(
                    title: lang.storeSlogan,
                    label: 'Twixi',
                    controller: AuthCubit.get(context).sloganController,
                    height: 25,
                    type: TextInputType.text,
                  ),
                ],
              ),
            ),
            const Spacer(),
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
                        AuthCubit.get(context).updateStore(context);
                      }),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            )
          ],
        ),
      ),
    );
  }

  SizedBox photosStack(context) {
    return SizedBox(
      height: 130,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              return Container(
                width: 100,
                height: 100,
                decoration: ShapeDecoration(
                  image: DecorationImage(
                    image: AuthCubit.get(context).image.path.isEmpty
                        ? const AssetImage('assets/images/brand1.png')
                        : FileImage(AuthCubit.get(context).image),
                    fit: BoxFit.fill,
                  ),
                  shape: const CircleBorder(
                    side: BorderSide(
                      width: 5,
                      strokeAlign: BorderSide.strokeAlignOutside,
                      color: Color(0xFFFCFCFC),
                    ),
                  ),
                ),
              );
            },
          ),
          Positioned(
            bottom: 2,
            right: 2,
            child: GestureDetector(
              onTap: () async {
                AuthCubit.get(context).image = await cameraDialog(context);
                setState(() {});
              },
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                    color: ColorManager.primaryO,
                    borderRadius: BorderRadius.circular(12)),
                child: const Icon(
                  Icons.camera_alt,
                  color: ColorManager.primaryW,
                  size: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
