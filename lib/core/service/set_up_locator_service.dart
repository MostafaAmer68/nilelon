import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:nilelon/features/cart/data/datasource/cart_service.dart';
import 'package:nilelon/features/cart/data/repos_impl/cart_repos_impl.dart';
import 'package:nilelon/features/closet/data/remote_data_source/closet_remote_data_source.dart';
import 'package:nilelon/features/closet/data/repo_impl/closet_repo_impl.dart';
import 'package:nilelon/features/order/data/datasources/order_service.dart';
import 'package:nilelon/features/order/data/repositories/order_repo_impl.dart';
import 'package:nilelon/features/payments/data/datasources/payment_service.dart';
import 'package:nilelon/features/payments/data/repositories/payment_repo_impl.dart';
import 'package:nilelon/features/product/data/datasources/products_service.dart';
import 'package:nilelon/features/product/data/repositories/products_repos_impl.dart';
import 'package:nilelon/features/auth/data/datasource/auth_service.dart';
import 'package:nilelon/features/auth/data/repos_impl/auth_repos_impl.dart';
import 'package:nilelon/features/profile/data/datasources/profile_service.dart';
import 'package:nilelon/features/profile/data/repositories/profile_repo_impl.dart';
import 'package:nilelon/features/promo/data/datasources/promo_service.dart';
import 'package:nilelon/features/promo/data/repositories/promo_repo_impl.dart';
import 'package:nilelon/features/refund/data/datasources/refund_service.dart';
import 'package:nilelon/features/refund/data/repositories/refund_repo_impl.dart';
import 'package:nilelon/features/search/data/datasources/search_service.dart';
import 'package:nilelon/features/search/data/repositories/search_repo_impl.dart';
import 'package:nilelon/features/shared/recommendation/data/remote_data_source/recommendation_remot_data_source.dart';
import 'package:nilelon/features/shared/recommendation/data/repos_impl/recommendation_repos_impl.dart';
import 'package:nilelon/features/store_flow/analytics/data/remote_data_source/analytics_remote_data_source.dart';
import 'package:nilelon/features/store_flow/analytics/data/repos_impl/analytics_repos_impl.dart';
import 'package:nilelon/features/categories/data/service/category_service.dart';
import 'package:nilelon/features/categories/data/repo/category_repos_impl.dart';
import 'package:nilelon/core/service/network/api_service.dart';

import 'network/end_point.dart';

final locatorService = GetIt.instance;
void setUpLocatorService() {
  locatorService.registerSingleton<ApiService>(
    ApiService(
      dio: Dio(
        BaseOptions(
          baseUrl: EndPoint.baseUrl,
        ),
      ),
    ),
  );

  // profile
  locatorService.registerSingleton(ProfileService(
    locatorService(),
  ));
  locatorService.registerSingleton<ProfileRepoIMpl>(ProfileRepoIMpl(
    locatorService(),
  ));

  //closets
  locatorService.registerSingleton(ClosetService(
    locatorService(),
  ));
  locatorService.registerSingleton<ClosetRepoImpl>(ClosetRepoImpl(
    locatorService(),
  ));

  //promo
  locatorService.registerSingleton(PromoService(
    locatorService(),
  ));
  locatorService.registerSingleton<PromoRepoImpl>(PromoRepoImpl(
    locatorService(),
  ));

  // search
  locatorService.registerSingleton(SearchService(locatorService()));
  locatorService.registerSingleton<SearchRepoImpl>(
    SearchRepoImpl(locatorService()),
  );

  // refund
  locatorService.registerSingleton(RefundService(locatorService()));
  locatorService
      .registerSingleton<RefundRepoImpl>(RefundRepoImpl(locatorService()));

  // payment
  locatorService.registerSingleton(PaymentService(
    locatorService(),
  ));
  locatorService.registerSingleton<PaymentRepoImpl>(PaymentRepoImpl(
    locatorService(),
  ));

  //order
  locatorService.registerSingleton(OrderService(locatorService()));
  locatorService.registerSingleton<OrderRepoImpl>(OrderRepoImpl(
    locatorService(),
  ));

  //category
  locatorService
      .registerSingleton(CategoryService(apiService: locatorService()));
  locatorService.registerSingleton<CategoryReposImpl>(CategoryReposImpl(
    locatorService(),
  ));

  //auth
  locatorService.registerSingleton<AuthService>(
      AuthService(apiService: locatorService<ApiService>()));
  locatorService.registerSingleton<AuthReposImpl>(AuthReposImpl(
    locatorService<AuthService>(),
  ));

  // cart
  locatorService.registerSingleton<CartService>(CartService(
    apiService: locatorService<ApiService>(),
  ));
  locatorService.registerSingleton<CartReposImpl>(CartReposImpl(
    locatorService<CartService>(),
  ));

  //product
  locatorService.registerSingleton<ProductsService>(ProductsService(
    apiService: locatorService<ApiService>(),
  ));
  locatorService.registerSingleton<ProductsReposImpl>(ProductsReposImpl(
    locatorService<ProductsService>(),
  ));

  // analytics
  locatorService.registerSingleton<AnalyticsService>(AnalyticsService(
    apiService: locatorService<ApiService>(),
  ));
  locatorService.registerSingleton<AnalyticsReposImpl>(AnalyticsReposImpl(
    locatorService<AnalyticsService>(),
  ));

  //recommanded
  locatorService.registerSingleton<RecommendationService>(RecommendationService(
    apiService: locatorService<ApiService>(),
  ));
  locatorService.registerSingleton<RecommendationReposImpl>(
    RecommendationReposImpl(
      locatorService<RecommendationService>(),
    ),
  );
}
