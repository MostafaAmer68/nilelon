import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/core/constants/assets.dart';
import 'package:nilelon/core/tools.dart';
import 'package:nilelon/core/widgets/replacer/image_replacer.dart';
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
import 'package:nilelon/core/widgets/pop_ups/success_creation_popup.dart';
import 'package:nilelon/core/widgets/text_form_field/text_field/text_form_field_builder.dart';
import 'package:svg_flutter/svg_flutter.dart';

import '../../../../core/widgets/scaffold_image.dart';
import '../../../auth/domain/model/user_model.dart';
import '../cubit/profile_cubit.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  late final ProfileCubit cubit;
  @override
  void initState() {
    cubit = ProfileCubit.get(context);
    cubit.nameController =
        TextEditingController(text: currentUsr<CustomerModel>().name);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    // log(currentUsr<CustomerModel>().profilePic, name: 'image');
    return ScaffoldImage(
      appBar: customAppBar(
          title: lang.editAccount, context: context, hasIcon: false),
      body: BlocListener<ProfileCubit, ProfileState>(
        listener: (context, state) {
          state.mapOrNull(
            loading: (_) {
              BotToast.showLoading();
            },
            success: (_) {
              BotToast.closeAllLoading();
              successCreationDialog(
                  context: context,
                  highlightedText: S.of(context).infoUpdateReglogin,
                  regularText: '',
                  buttonText: lang.save,
                  ontap: () {
                    navigatePop(context: context);
                  });
            },
            failure: (_) {
              BotToast.closeAllLoading();
              BotToast.showText(text: _.er);
            },
          );
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
                          child: SvgPicture.asset(Assets.assetsImagesProfileI)),
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
                              ProfileCubit.get(context).updateCustomer(context);
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
            decoration: const ShapeDecoration(
              shape: CircleBorder(
                side: BorderSide(
                  width: 5,
                  strokeAlign: BorderSide.strokeAlignOutside,
                  color: Color(0xFFFCFCFC),
                ),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(360),
              child: cubit.image.path.isEmpty &&
                      currentUsr<CustomerModel>().profilePic.isEmpty
                  ? Image.asset(Assets.assetsImagesProfile)
                  : currentUsr<CustomerModel>().profilePic.isNotEmpty &&
                          cubit.image.path.isNotEmpty
                      ? Image.file(cubit.image)
                      : imageReplacer(
                          url: currentUsr<CustomerModel>().profilePic),
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
