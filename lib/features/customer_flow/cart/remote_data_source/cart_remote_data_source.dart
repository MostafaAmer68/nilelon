import 'package:nilelon/data/hive_stroage.dart';
import 'package:nilelon/features/customer_flow/cart/model/change_quantity_model.dart';
import 'package:nilelon/features/customer_flow/cart/model/delete_request_model.dart';
import 'package:nilelon/features/customer_flow/cart/model/get_cart_model/get_cart_model.dart';
import 'package:nilelon/service/network/api_service.dart';
import 'package:nilelon/service/network/end_point.dart';

abstract class CartRemoteDataSource {
  Future<GetCartModel> getCart();
  Future<void> deleteFromCart(DeleteRequestModel model);
  Future<void> updateQuantityCart(ChangeQuantityModel model);
}

class CartRemoteDataSourceImpl extends CartRemoteDataSource {
  final ApiService apiService;

  CartRemoteDataSourceImpl({required this.apiService});
  @override
  Future<GetCartModel> getCart() async {
    final data = await apiService.get(
      endPoint:
          '${EndPoint.getCartByCustomerIdUrl}${HiveStorage.get(HiveKeys.idToken)}',
    );
    print(data);
    if (data.statusCode == 200) {
      return GetCartModel.fromJson(data.data as Map<String, dynamic>);
    } else if (data.statusCode == 400) {
      // Handle the bad request response
      final errorMessage = data.data;
      // errorAlert(context, errorMessage);
      throw Exception('Get Cart failed: $errorMessage');
    } else {
      // Handle other status codes if necessary
      throw Exception(
          'Failed to Get Cart: Unexpected status code ${data.statusCode}');
    }
  }

  @override
  Future<void> deleteFromCart(DeleteRequestModel model) async {
    final data = await apiService.delete(
      endPoint: EndPoint.deleteFromCartUrl,
      body: model.toJson(),
    );
    print(data);
    if (data.statusCode == 200) {
      return data.data;
    } else if (data.statusCode == 400) {
      // Handle the bad request response
      final errorMessage = data.data;
      // errorAlert(context, errorMessage);
      throw Exception('Delete From Cart failed: $errorMessage');
    } else {
      // Handle other status codes if necessary
      throw Exception(
          'Failed to Delete From Cart: Unexpected status code ${data.statusCode}');
    }
  }

  @override
  Future<void> updateQuantityCart(ChangeQuantityModel model) async {
    final data = await apiService.put(
      endPoint: EndPoint.updateQuantityCartUrl,
      data: model.toJson(),
    );
    print(data);
    if (data.statusCode == 200) {
      return data.data;
    } else if (data.statusCode == 400) {
      // Handle the bad request response
      final errorMessage = data.data;
      // errorAlert(context, errorMessage);
      throw Exception('Update Quantity Cart failed: $errorMessage');
    } else {
      // Handle other status codes if necessary
      throw Exception(
          'Failed to Update Quantity Cart: Unexpected status code ${data.statusCode}');
    }
  }
}
