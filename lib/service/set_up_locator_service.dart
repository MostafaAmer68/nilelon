import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:nilelon/features/categories/data/datasources/category_services.dart';
import 'package:nilelon/features/categories/data/repositories/category_repo_impl.dart';
import 'package:nilelon/features/categories/domain/repositories/category_repo.dart';
import 'package:nilelon/features/cart/data/remote_data_source/cart_remote_data_source.dart';
import 'package:nilelon/features/cart/data/repos_impl/cart_repos_impl.dart';
import 'package:nilelon/features/closet/data/remote_data_source/closet_remote_data_source.dart';
import 'package:nilelon/features/closet/data/repo_impl/closet_repo_impl.dart';
import 'package:nilelon/features/closet/domain/repo/closet_repo.dart';
import 'package:nilelon/features/order/data/datasources/order_service.dart';
import 'package:nilelon/features/order/data/repositories/order_repo_impl.dart';
import 'package:nilelon/features/order/domain/repositories/order_repo.dart';
import 'package:nilelon/features/product/data/datasources/products_remote_data_source.dart';
import 'package:nilelon/features/product/data/repositories/products_repos_impl.dart';
import 'package:nilelon/features/auth/data/remote_data_source/auth_remote_data_source.dart';
import 'package:nilelon/features/auth/data/repos_impl/auth_repos_impl.dart';
import 'package:nilelon/features/store_flow/analytics/remote_data_source/analytics_remote_data_source.dart';
import 'package:nilelon/features/store_flow/analytics/repos_impl/analytics_repos_impl.dart';
import 'package:nilelon/features/store_flow/choose_category/remote_data_source/choose_category_remote_data_source.dart';
import 'package:nilelon/features/store_flow/choose_category/repos_impl/choose_category_repos_impl.dart';
import 'package:nilelon/service/network/api_service.dart';

import 'network/end_point.dart';

final locatorService = GetIt.instance;
void setUpLocatorService() {
  locatorService.registerSingleton<ApiService>(ApiService(
      dio: Dio(BaseOptions(
    baseUrl: EndPoint.baseUrl,
  ))));
  locatorService
      .registerSingleton(ClosetRemoteDataSourceImpl(locatorService()));
  locatorService
      .registerSingleton<ClosetRepoImpl>(ClosetRepoImpl(locatorService()));
  locatorService.registerSingleton(OrderService(locatorService()));
  locatorService
      .registerSingleton<OrderRepoImpl>(OrderRepoImpl(locatorService()));
  locatorService.registerSingleton(CategoryServices(Dio()));
  locatorService
      .registerSingleton<CategoryRepo>(CategoryRepoImpl(locatorService()));
  locatorService.registerSingleton<AuthRemoteDataSourceImpl>(
    AuthRemoteDataSourceImpl(apiService: locatorService<ApiService>()),
  );
  locatorService.registerSingleton<AuthReposImpl>(
    AuthReposImpl(locatorService<AuthRemoteDataSourceImpl>()),
  );
  // chose category
  locatorService.registerSingleton<ChooseCategoryRemoteDataSourceImpl>(
    ChooseCategoryRemoteDataSourceImpl(
        apiService: locatorService<ApiService>()),
  );
  locatorService.registerSingleton<ChooseCategoryReposImpl>(
    ChooseCategoryReposImpl(
        locatorService<ChooseCategoryRemoteDataSourceImpl>()),
  );
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
}
