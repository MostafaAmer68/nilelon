import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:nilelon/features/cart/data/remote_data_source/cart_remote_data_source.dart';
import 'package:nilelon/features/cart/data/repos_impl/cart_repos_impl.dart';
import 'package:nilelon/features/closet/data/remote_data_source/closet_remote_data_source.dart';
import 'package:nilelon/features/closet/data/repo_impl/closet_repo_impl.dart';
import 'package:nilelon/features/order/data/datasources/order_service.dart';
import 'package:nilelon/features/order/data/repositories/order_repo_impl.dart';
import 'package:nilelon/features/payments/data/datasources/payment_service.dart';
import 'package:nilelon/features/payments/data/repositories/payment_repo_impl.dart';
import 'package:nilelon/features/product/data/datasources/products_remote_data_source.dart';
import 'package:nilelon/features/product/data/repositories/products_repos_impl.dart';
import 'package:nilelon/features/auth/data/remote_data_source/auth_remote_data_source.dart';
import 'package:nilelon/features/auth/data/repos_impl/auth_repos_impl.dart';
import 'package:nilelon/features/profile/data/datasources/profile_remote_data.dart';
import 'package:nilelon/features/profile/data/repositories/profile_repo_impl.dart';
import 'package:nilelon/features/shared/recommendation/data/remote_data_source/recommendation_remot_data_source.dart';
import 'package:nilelon/features/shared/recommendation/data/repos_impl/recommendation_repos_impl.dart';
import 'package:nilelon/features/store_flow/analytics/data/remote_data_source/analytics_remote_data_source.dart';
import 'package:nilelon/features/store_flow/analytics/data/repos_impl/analytics_repos_impl.dart';
import 'package:nilelon/features/categories/data/remote_data_source/category_remote_data_source.dart';
import 'package:nilelon/features/categories/data/repos_impl/category_repos_impl.dart';
import 'package:nilelon/core/service/network/api_service.dart';

import 'network/end_point.dart';

final locatorService = GetIt.instance;
void setUpLocatorService() {
  locatorService.registerSingleton<ApiService>(ApiService(
      dio: Dio(BaseOptions(
    baseUrl: EndPoint.baseUrl,
  ))));
  locatorService.registerSingleton(ProfileRemoteData(locatorService()));
  locatorService
      .registerSingleton<ProfileRepoIMpl>(ProfileRepoIMpl(locatorService()));
  locatorService
      .registerSingleton(ClosetRemoteDataSourceImpl(locatorService()));
  locatorService
      .registerSingleton<ClosetRepoImpl>(ClosetRepoImpl(locatorService()));
  locatorService.registerSingleton(PaymentService(locatorService()));
  locatorService
      .registerSingleton<PaymentRepoImpl>(PaymentRepoImpl(locatorService()));
  locatorService.registerSingleton(OrderService(locatorService()));
  locatorService
      .registerSingleton<OrderRepoImpl>(OrderRepoImpl(locatorService()));
  locatorService.registerSingleton(
      CategoryRemoteDataSourceImpl(apiService: locatorService()));
  locatorService.registerSingleton<CategoryReposImpl>(
      CategoryReposImpl(locatorService()));
  locatorService.registerSingleton<AuthRemoteDataSourceImpl>(
    AuthRemoteDataSourceImpl(apiService: locatorService<ApiService>()),
  );
  locatorService.registerSingleton<AuthReposImpl>(
    AuthReposImpl(locatorService<AuthRemoteDataSourceImpl>()),
  );
  // chose category

  locatorService.registerSingleton<CartRemoteDataSourceImpl>(
    CartRemoteDataSourceImpl(apiService: locatorService<ApiService>()),
  );
  locatorService.registerSingleton<CartReposImpl>(
    CartReposImpl(locatorService<CartRemoteDataSourceImpl>()),
  );
  locatorService.registerSingleton<ProductsRemoteDataSourceImpl>(
    ProductsRemoteDataSourceImpl(apiService: locatorService<ApiService>()),
  );
  locatorService.registerSingleton<ProductsReposImpl>(
    ProductsReposImpl(locatorService<ProductsRemoteDataSourceImpl>()),
  );
  locatorService.registerSingleton<AnalyticsRemoteDataSourceImpl>(
    AnalyticsRemoteDataSourceImpl(apiService: locatorService<ApiService>()),
  );
  locatorService.registerSingleton<AnalyticsReposImpl>(
    AnalyticsReposImpl(locatorService<AnalyticsRemoteDataSourceImpl>()),
  );
  locatorService.registerSingleton<RecommendationRemotDataSourceImpl>(
    RecommendationRemotDataSourceImpl(apiService:  locatorService<ApiService>()),
  );
  locatorService.registerSingleton<RecommendationReposImpl>(
    RecommendationReposImpl(locatorService<RecommendationRemotDataSourceImpl>()),
  );
}
