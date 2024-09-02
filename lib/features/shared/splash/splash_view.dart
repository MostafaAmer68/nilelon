import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/core/data/hive_stroage.dart';
import 'package:nilelon/features/categories/presentation/cubit/category_cubit.dart';
import 'package:nilelon/features/customer_flow/layout/customer_bottom_tab_bar.dart';
import 'package:nilelon/features/shared/welcomePage/welcome_page.dart';
import 'package:nilelon/features/store_flow/layout/store_bottom_tab_bar.dart';

import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/core/utils/navigation.dart';
import 'package:nilelon/features/shared/onboarding/onboarding_cubit/onboarding_cubit.dart';
import 'package:nilelon/features/shared/onboarding/screen/onboarding_view.dart';

import '../../../core/widgets/scaffold_image.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    // BlocProvider.of(context)
    BlocProvider.of<CategoryCubit>(context).getCategories();
    Timer(const Duration(seconds: 3), () {
      !HiveStorage.get(HiveKeys.skipOnboarding)
          ? navigateAndRemoveUntil(
              context: context,
              screen: BlocProvider<OnBoardingCubit>(
                create: (context) => OnBoardingCubit(),
                child: const OnBoardingView(),
              ))
          : HiveStorage.get(HiveKeys.token) == null
              ? navigateAndRemoveUntil(
                  context: context, screen: const ShopOrSellView())
              : HiveStorage.get(HiveKeys.isStore)
                  ? navigateAndRemoveUntil(
                      context: context, screen: const StoreBottomTabBar())
                  : navigateAndRemoveUntil(
                      context: context, screen: const CustomerBottomTabBar());
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldImage(
      body: Container(
        decoration: const BoxDecoration(color: ColorManager.primaryB2),
        child: const AnimationExample(),
      ),
    );
  }
}

class AnimationExample extends StatefulWidget {
  const AnimationExample({super.key});
  @override
  State<AnimationExample> createState() => _AnimationExampleState();
}

class _AnimationExampleState extends State<AnimationExample>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;
  late Animation<double> _translationAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    // Define the rotation animation
    _rotationAnimation = TweenSequence([
      TweenSequenceItem(
          tween: Tween(begin: 0.0, end: 0.25),
          weight: 0.1), // Rotate 90 degrees to the right
      TweenSequenceItem(tween: ConstantTween(0.25), weight: 0.05),
      TweenSequenceItem(
          tween: Tween(begin: 0.25, end: 0.0),
          weight: 0.1), // Rotate back to normal
    ]).animate(
        CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.25)));

    // Define the translation animation
    _translationAnimation = TweenSequence([
      TweenSequenceItem(
          tween: Tween(begin: 0.0, end: -100.0),
          weight: 1.0), // Translate to the left
    ]).animate(CurvedAnimation(
        parent: _controller, curve: const Interval(0.25, 0.40)));

    _opacityAnimation = TweenSequence([
      TweenSequenceItem(tween: ConstantTween(0.0), weight: 0.5),
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0), weight: 0.5),
    ]).animate(CurvedAnimation(
        parent: _controller, curve: const Interval(0.40, 0.60)));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                left: MediaQuery.of(context).size.width / 2 -
                    25.w +
                    _translationAnimation.value,
                child: Transform(
                  transform: Matrix4.identity()
                    ..rotateZ(_rotationAnimation.value * 2.6),
                  alignment: Alignment.center,
                  child: Image.asset('assets/images/nilelonDLogo.png',
                      width: 1.sw > 600 ? 40.w : 60.w,
                      height: 1.sw > 600 ? 40.w : 60.w),
                ),
              ),
              if (_translationAnimation.value == -100.0)
                Positioned(
                  left: MediaQuery.of(context).size.width / 2 - 40.w,
                  // +
                  // _translationAnimation2.value,
                  child: Opacity(
                    opacity: _opacityAnimation.value,
                    child: Image.asset('assets/images/nilelonEcommerceW.png',
                        width: 1.sw > 600 ? 150.w : 170.w,
                        height: 1.sw > 600 ? 40.w : 60.w),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
