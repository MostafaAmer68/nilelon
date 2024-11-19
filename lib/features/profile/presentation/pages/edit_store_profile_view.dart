import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nilelon/core/constants/assets.dart';
import 'package:nilelon/features/auth/domain/model/user_model.dart';
import 'package:nilelon/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/core/widgets/button/gradient_button_builder.dart';
import 'package:nilelon/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:nilelon/core/widgets/divider/default_divider.dart';
import 'package:nilelon/core/widgets/pop_ups/camera_popup.dart';
import 'package:nilelon/core/widgets/text_form_field/text_and_form_field_column/without_icon/text_and_form_field_column_no_icon.dart';
import 'package:nilelon/my_app.dart';

import '../../../../core/tools.dart';
import '../../../../core/widgets/button/outlined_button_builder.dart';
import '../../../../core/widgets/pop_ups/success_creation_popup.dart';
import '../../../../core/widgets/replacer/image_replacer.dart';
import '../../../../core/widgets/scaffold_image.dart';

class EditStoreProfileView extends StatefulWidget {
  const EditStoreProfileView({super.key});

  @override
  State<EditStoreProfileView> createState() => _EditStoreProfileViewState();
}

class _EditStoreProfileViewState extends State<EditStoreProfileView> {
  late final ProfileCubit cubit;
  @override
  void initState() {
    cubit = ProfileCubit.get(context);
    cubit.nameController =
        TextEditingController(text: currentUsr<StoreModel>().name);
    cubit.sloganController =
        TextEditingController(text: currentUsr<StoreModel>().storeSlogan);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    return ScaffoldImage(
      appBar: customAppBar(
        title: lang.profileInfo,
        context: context,
        hasIcon: false,
      ),
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
                  MyApp.restartApp(context);
                },
              );
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
                    controller: ProfileCubit.get(context).nameController,
                    type: TextInputType.text,
                  ),
                  TextAndFormFieldColumnNoIcon(
                    title: lang.storeSlogan,
                    label: 'Twixi',
                    controller: ProfileCubit.get(context).sloganController,
                    height: 25,
                    type: TextInputType.text,
                  ),
                ],
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
      btmBar: Container(
        height: 100,
        color: ColorManager.primaryW,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            OutlinedButtonBuilder(
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
                ProfileCubit.get(context).updateStore(context);
              },
            ),
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
          BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              return Container(
                width: 100,
                height: 100,
                decoration: const ShapeDecoration(
                  shape: CircleBorder(
                    side: BorderSide(
                      width: 5,
                      strokeAlign: BorderSide.strokeAlignOutside,
                      color: Color(0xFFFCFCFC),
                    ),
                  ),
                ),
                child: cubit.image.path.isEmpty &&
                        currentUsr<StoreModel>().profilePic.isEmpty
                    ? Image.asset(Assets.assetsImagesBrand1)
                    : currentUsr<StoreModel>().profilePic.isNotEmpty &&
                            cubit.image.path.isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(300),
                            child: Image.file(
                              cubit.image,
                              fit: BoxFit.cover,
                            ),
                          )
                        : imageReplacer(
                            radius: 300,
                            url: currentUsr<StoreModel>().profilePic),
              );
            },
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
