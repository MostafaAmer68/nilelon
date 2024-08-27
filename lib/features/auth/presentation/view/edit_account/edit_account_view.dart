import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
import 'package:nilelon/core/widgets/pop_ups/camera_popup.dart';
import 'package:nilelon/core/widgets/pop_ups/success_creation_popup.dart';
import 'package:nilelon/core/widgets/text_form_field/text_field/text_form_field_builder.dart';
import 'package:svg_flutter/svg_flutter.dart';

class EditAccountView extends StatefulWidget {
  const EditAccountView({super.key});

  @override
  State<EditAccountView> createState() => _EditAccountViewState();
}

class _EditAccountViewState extends State<EditAccountView> {
  late final AuthCubit cubit;
  @override
  void initState() {
    cubit = AuthCubit.get(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return Scaffold(
      backgroundColor: ColorManager.primaryW,
      appBar: customAppBar(
          title: lang.editAccount, context: context, hasIcon: false),
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
                    'Info has been updated successfully \n please relogin to update your info ',
                regularText: '',
                buttonText: lang.save,
                ontap: () {
                  navigatePop(context: context);
                });
          }
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              const DefaultDivider(),
              SizedBox(
                height: 1.sw > 600 ? 24.h : 0,
              ),
              photosStack(context),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lang.name,
                      style: AppStylesManager.customTextStyleBl5,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormFieldBuilder(
                      label: lang.enterYourName,
                      controller: cubit.nameController,
                      type: TextInputType.text,
                      width: screenWidth(context, 1),
                      isIcon: false,
                      prefixWidget: Container(
                          width: 20,
                          height: 20,
                          padding: const EdgeInsets.all(12),
                          child: SvgPicture.asset('assets/images/profile.svg')),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ButtonBuilder(
                            text: lang.cancel,
                            width: screenWidth(context, 0.44),
                            height: screenHeight(context, 0.06),
                            buttonColor: Colors.transparent,
                            frameColor: ColorManager.primaryB2,
                            style: AppStylesManager.customTextStyleB4
                                .copyWith(fontSize: 1.sw > 600 ? 22 : 14),
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
                              AuthCubit.get(context).updateCustomer(context);
                            }),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  SizedBox photosStack(context) {
    return SizedBox(
      height: 130.h,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            width: 100.w,
            height: 100.w,
            decoration: ShapeDecoration(
              image: DecorationImage(
                image: cubit.image.path.isEmpty
                    ? const AssetImage('assets/images/profile.png')
                    : FileImage(cubit.image),
                fit: BoxFit.contain,
              ),
              shape: CircleBorder(
                side: BorderSide(
                  width: 5,
                  strokeAlign: BorderSide.strokeAlignOutside,
                  color: Color(0xFFFCFCFC),
                ),
              ),
            ),
          ),
          Positioned(
              bottom: 2,
              right: 2,
              child: GestureDetector(
                onTap: () async {
                  cubit.image = await cameraDialog(context);
                  setState(() {});
                },
                child: Container(
                    width: 24.w,
                    height: 24.w,
                    decoration: BoxDecoration(
                        color: ColorManager.primaryO,
                        borderRadius: BorderRadius.circular(20.r)),
                    child: Icon(
                      Icons.camera_alt,
                      color: ColorManager.primaryW,
                      size: 16.r,
                    )),
              )),
        ],
      ),
    );
  }
}
