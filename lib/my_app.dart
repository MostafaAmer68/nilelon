
import 'package:app_links/app_links.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/core/data/hive_stroage.dart';
import 'package:nilelon/features/cart/data/repos_impl/cart_repos_impl.dart';
import 'package:nilelon/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:nilelon/features/notification/data/repositories/notifiy_repo_impl.dart';
import 'package:nilelon/features/order/presentation/progress_cubit/progress_cubit.dart';
import 'package:nilelon/features/closet/data/repo_impl/closet_repo_impl.dart';
import 'package:nilelon/features/closet/presentation/cubit/closet_cubit.dart';
import 'package:nilelon/features/order/data/repositories/order_repo_impl.dart';
import 'package:nilelon/features/order/presentation/cubit/order_cubit.dart';
import 'package:nilelon/features/payments/data/repositories/payment_repo_impl.dart';
import 'package:nilelon/features/payments/presentation/cubit/payment_cubit.dart';
import 'package:nilelon/features/product/presentation/cubit/add_product/add_product_cubit.dart';
import 'package:nilelon/features/product/presentation/cubit/products_cubit/products_cubit.dart';
import 'package:nilelon/features/product/data/repositories/products_repos_impl.dart';
import 'package:nilelon/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:nilelon/features/auth/data/repos_impl/auth_repos_impl.dart';
import 'package:nilelon/features/profile/data/repositories/profile_repo_impl.dart';
import 'package:nilelon/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:nilelon/features/promo/data/repositories/promo_repo_impl.dart';
import 'package:nilelon/features/promo/presentation/cubit/promo_cubit.dart';
import 'package:nilelon/features/refund/data/repositories/refund_repo_impl.dart';
import 'package:nilelon/features/refund/presentation/cubit/refund_cubit.dart';
import 'package:nilelon/features/search/presentation/cubit/search_cubit.dart';
import 'package:nilelon/features/shared/recommendation/data/repos_impl/recommendation_repos_impl.dart';
import 'package:nilelon/features/shared/recommendation/presentation/cubit/recommendation_cubit.dart';
import 'package:nilelon/features/shared/splash/splash_view.dart';
import 'package:nilelon/features/store_flow/analytics/presentation/cubit/reservation_cubit/reservation_date_cubit.dart';
import 'package:nilelon/features/categories/presentation/cubit/category_cubit.dart';
import 'package:nilelon/features/categories/data/repo/category_repos_impl.dart';
import 'package:nilelon/core/service/set_up_locator_service.dart';
import 'package:nilelon/generated/l10n.dart';

import 'features/notification/presentation/cubit/notification_cubit.dart';
import 'features/search/data/repositories/search_repo_impl.dart';
import 'features/store_flow/analytics/data/repos_impl/analytics_repos_impl.dart';
import 'features/store_flow/analytics/presentation/cubit/analytics_cubit.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_MyAppState>()?.restartApp();
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  final appLinks = AppLinks(); // AppLinks is singleton
  @override
  void initState() {
// Subscribe to all events (initial link and further)
    
    super.initState();
  }

 
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      // key: key,
      providers: [
        BlocProvider<RecommendationCubit>(
          create: (context) =>
              RecommendationCubit(locatorService<RecommendationReposImpl>()),
        ),
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
        BlocProvider<AddProductCubit>(
          create: (context) =>
              AddProductCubit(locatorService<ProductsReposImpl>()),
        ),
        BlocProvider<PaymentCubit>(
          create: (context) => PaymentCubit(locatorService<PaymentRepoImpl>()),
        ),
        BlocProvider<OrderCubit>(
          create: (context) => OrderCubit(locatorService<OrderRepoImpl>()),
        ),
        BlocProvider<ProfileCubit>(
          create: (context) => ProfileCubit(locatorService<ProfileRepoIMpl>()),
        ),
        BlocProvider<SearchCubit>(
          create: (context) => SearchCubit(locatorService<SearchRepoImpl>()),
        ),
        BlocProvider<RefundCubit>(
          create: (context) => RefundCubit(locatorService<RefundRepoImpl>()),
        ),
        BlocProvider<PromoCubit>(
          create: (context) => PromoCubit(locatorService<PromoRepoImpl>()),
        ),
        BlocProvider<ProgressCubit>(
          create: (context) => ProgressCubit(),
        ),
        BlocProvider(
          create: (context) =>
              AnalyticsCubit(locatorService<AnalyticsReposImpl>()),
        ),
        BlocProvider(
          create: (context) =>
              NotificationCubit(locatorService<NotifyRepoImpl>()),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(411, 823),
        minTextAdapt: true,
        // useInheritedMediaQuery: true,
        ensureScreenSize: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp(
            key: key,
            debugShowCheckedModeBanner: false,
            // useInheritedMediaQuery: true,
            builder: (context, child) {
              return BotToastInit()(
                context,
                MediaQuery(
                  data: MediaQuery.of(context).copyWith(
                    textScaler: const TextScaler.linear(1),
                  ),
                  child: child!,
                ),
              );
            },
            // builder: DevicePreview.appBuilder,
            locale: HiveStorage.get(HiveKeys.isArabic) != null &&
                    HiveStorage.get(HiveKeys.isArabic)
                ? const Locale('ar')
                : const Locale('en'),
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
