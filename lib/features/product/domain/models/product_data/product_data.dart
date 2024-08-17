import 'package:hive/hive.dart';
import 'package:equatable/equatable.dart';
import 'package:nilelon/features/product/domain/models/add_product/add_product_model.dart';
part 'product_data.g.dart';

@HiveType(typeId: 20)
class ProductData extends Equatable {
  @HiveField(0)
  final AddProductModel product;
  @HiveField(1)
  final List<Map<String, bool>> isEditable;
  @HiveField(2)
  final String productPrice;

  const ProductData({
    required this.productPrice,
    required this.product,
    required this.isEditable,
  });

  @override
  List<Object?> get props => [product, isEditable, productPrice];
}
