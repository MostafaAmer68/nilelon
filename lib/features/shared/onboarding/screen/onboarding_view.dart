import 'package:flutter/material.dart';
import 'package:nilelon/core/data/hive_stroage.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/resources/appstyles_manager.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/core/widgets/button/button_builder.dart';
import 'package:nilelon/core/widgets/button/gradient_button_builder.dart';
import 'package:nilelon/core/widgets/dot_indicators/gradient_dot.dart';
import 'package:nilelon/core/widgets/dot_indicators/gradient_dot_active.dart';
import 'package:nilelon/features/shared/onboarding/onboarding_cubit/onboarding_cubit.dart';
import 'package:nilelon/features/shared/welcomePage/welcome_page.dart';

import '../../../../core/widgets/scaffold_image.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  @override
  Widget build(BuildContext context) {
    final controller = PageController();
    final lang = S.of(context);

    return ScaffoldImage(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              width: screenWidth(context, 1),
              height: screenHeight(context, 0.75),
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                onPageChanged: (i) {
                  OnBoardingCubit.get(context).index = i;
                  setState(() {});
                  if (i == 2) {
                    OnBoardingCubit.get(context).changeisLast(true);
                  } else if (OnBoardingCubit.get(context).isLast) {
                    OnBoardingCubit.get(context).changeisLast(false);
                  }
                },
                controller: controller,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        width: screenWidth(context, 1),
                        height: screenHeight(context, 0.75),
                        padding: const EdgeInsets.all(8.0),
                        decoration: const BoxDecoration(
                          shape: BoxShape.rectangle,
                          // color: AppStyles.primaryW,
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: screenHeight(context, 0.06),
                              width: screenWidth(context, 1),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      HiveStorage.set(
                                          HiveKeys.skipOnboarding, true);
                                      navigateAndReplace(
                                          context: context,
                                          screen: const ShopOrSellView());
                                    },
                                    child: Text(
                                      lang.Skip,
                                      style: AppStylesManager.customTextStyleBl,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  photoContainer(context),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    OnBoardingCubit.get(context).index == 0
                                        ? lang.welcomeToNilelon
                                        : OnBoardingCubit.get(context).index ==
                                                1
                                            ? lang.LocalBrandsLimitlessChoices
                                            : lang
                                                .seamlessPaymentsHassleFreeShopping,
                                    style: AppStylesManager.customTextStyleBl2,
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    OnBoardingCubit.get(context).index == 0
                                        ? lang
                                            .discoverLocalTreasuresAtUnbeatablePricesShopWithEaseAndGetExclusiveDiscount
                                        : OnBoardingCubit.get(context).index ==
                                                1
                                            ? lang
                                                .exploreAVastCollectionOfProductsFromLocalBrandsGetEverythingYouNeedInOnePlace
                                            : lang
                                                .saygoodbyeToComplicatedCheckoutProcessesEnjoyASeamlessPaymentExperienceWithSecureTransactions,
                                    style: AppStylesManager.customTextStyleBl3,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const Spacer(),
            OnBoardingCubit.get(context).isLast
                ? ButtonBuilder(
                    text: lang.getStarted,
                    ontap: () {
                      controller.nextPage(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.bounceOut);
                      if (OnBoardingCubit.get(context).isLast) {
                        HiveStorage.set(HiveKeys.skipOnboarding, true);
                        navigateAndReplace(
                            context: context, screen: const ShopOrSellView());
                      }
                    },
                  )
                : GradientButtonBuilder(
                    text: lang.next,
                    ontap: () {
                      controller.nextPage(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.bounceOut);
                      if (OnBoardingCubit.get(context).isLast) {
                        HiveStorage.set(HiveKeys.skipOnboarding, true);
                        navigateAndReplace(
                            context: context, screen: const ShopOrSellView());
                      }
                    },
                  ),
            const Spacer(
              flex: 3,
            ),
            OnBoardingCubit.get(context).index == 0
                ? firstIndex()
                : OnBoardingCubit.get(context).index == 1
                    ? secondIndex()
                    : thirdIndex(),
            const Spacer(
              flex: 4,
            ),
          ],
        ),
      ),
    );
  }

  SizedBox photoContainer(BuildContext context) {
    return SizedBox(
      height: screenHeight(context, 0.4),
      width: screenWidth(context, 1),
      child: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: screenHeight(context, 0.04),
            ),
            Container(
                width: screenWidth(context, 0.8),
                height: screenHeight(context, 0.34),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: OnBoardingCubit.get(context).index == 0
                        ? const AssetImage("assets/images/onboarding1.png")
                        : OnBoardingCubit.get(context).index == 1
                            ? const AssetImage("assets/images/onboarding2.png")
                            : const AssetImage("assets/images/onboarding3.png"),
                    fit: BoxFit.cover,
                  ),
                )),
            SizedBox(
              height: screenHeight(context, 0.01),
            ),
          ],
        ),
      ),
    );
  }

  Row thirdIndex() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.all(4.0),
          child: GradientDot(),
        ),
        Padding(
          padding: EdgeInsets.all(4.0),
          child: GradientDot(),
        ),
        Padding(
          padding: EdgeInsets.all(4.0),
          child: GradientDotActive(),
        ),
      ],
    );
  }

  Row secondIndex() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.all(4.0),
          child: GradientDot(),
        ),
        Padding(
          padding: EdgeInsets.all(4.0),
          child: GradientDotActive(),
        ),
        Padding(
          padding: EdgeInsets.all(4.0),
          child: GradientDot(),
        )
      ],
    );
  }

  Row firstIndex() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.all(4.0),
          child: GradientDotActive(),
        ),
        Padding(
          padding: EdgeInsets.all(4.0),
          child: GradientDot(),
        ),
        Padding(
          padding: EdgeInsets.all(4.0),
          child: GradientDot(),
        )
      ],
    );
  }
}
