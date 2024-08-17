import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/features/cart/data/repos_impl/cart_repos_impl.dart';
import 'package:nilelon/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:nilelon/features/closet/data/repo_impl/closet_repo_impl.dart';
import 'package:nilelon/features/closet/presentation/cubit/closet_cubit.dart';
import 'package:nilelon/features/payments/data/repositories/payment_repo_impl.dart';
import 'package:nilelon/features/payments/presentation/cubit/payment_cubit.dart';
import 'package:nilelon/features/product/presentation/cubit/cubit/add_product_cubit.dart';
import 'package:nilelon/features/product/presentation/cubit/products_cubit/products_cubit.dart';
import 'package:nilelon/features/product/data/repositories/products_repos_impl.dart';
import 'package:nilelon/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:nilelon/features/auth/data/repos_impl/auth_repos_impl.dart';
import 'package:nilelon/features/shared/splash/splash_view.dart';
import 'package:nilelon/features/store_flow/analytics/cubit/reservation_cubit/reservation_date_cubit.dart';
import 'package:nilelon/features/categories/presentation/cubit/category_cubit.dart';
import 'package:nilelon/features/categories/data/repos_impl/category_repos_impl.dart';
import 'package:nilelon/generated/l10n.dart';
import 'package:nilelon/service/set_up_locator_service.dart';
import 'package:nilelon/widgets/rating/cubit/review_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(locatorService<AuthReposImpl>()),
        ),
        BlocProvider<CategoryCubit>(
          create: (context) =>
              CategoryCubit(locatorService<CategoryReposImpl>()),
        ),
        BlocProvider<ProductsCubit>(
          create: (context) =>
              ProductsCubit(locatorService<ProductsReposImpl>()),
        ),
        BlocProvider<ReservationDateCubit>(
          create: (context) => ReservationDateCubit(),
        ),
        BlocProvider<RatingCubit>(
          create: (context) => RatingCubit(),
        ),
        BlocProvider<CategoryCubit>(
          create: (context) =>
              CategoryCubit(locatorService<CategoryReposImpl>()),
        ),
        BlocProvider<ClosetCubit>(
          create: (context) => ClosetCubit(locatorService<ClosetRepoImpl>()),
        ),
        BlocProvider<CartCubit>(
          create: (context) => CartCubit(locatorService<CartReposImpl>()),
        ),
        BlocProvider<ProductsCubit>(
          create: (context) =>
              ProductsCubit(locatorService<ProductsReposImpl>()),
        ),
        BlocProvider<AddproductCubit>(
          create: (context) =>
              AddproductCubit(locatorService<ProductsReposImpl>()),
        ),
        BlocProvider<PaymentCubit>(
          create: (context) => PaymentCubit(locatorService<PaymentRepoImpl>()),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        useInheritedMediaQuery: true,
        ensureScreenSize: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            // useInheritedMediaQuery: true,
            builder: BotToastInit(),
            // builder: DevicePreview.appBuilder,
            locale: //HiveStorage.get(HiveKeys.isArabic)
                // ? const Locale('ar')
                // :
                const Locale('en'),
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            home: const SplashView(),
          );
        },
      ),
    );
  }
}
