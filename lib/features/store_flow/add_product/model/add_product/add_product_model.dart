import 'package:hive/hive.dart';
import 'package:equatable/equatable.dart';
part 'add_product_model.g.dart';

@HiveType(typeId: 0)
class AddProductModel extends Equatable {
  @HiveField(0)
  final String categoryName;
  @HiveField(1)
  final String productName;
  @HiveField(2)
  final String type;
  @HiveField(3)
  final String productDescription;
  @HiveField(4)
  final String sizeGuideImage;
  @HiveField(5)
  final List varieantsList;

  const AddProductModel({
    required this.sizeGuideImage,
    required this.categoryName,
    required this.productName,
    required this.type,
    required this.productDescription,
    required this.varieantsList,
  });

  @override
  List<Object?> get props => [
        categoryName,
        productName,
        type,
        productDescription,
        varieantsList,
      ];
}

@HiveType(typeId: 1)
class ProductVarieants extends Equatable {
  @HiveField(0)
  final String color;
  @HiveField(1)
  final List<String> imagesList; // Store file paths instead of File objects
  @HiveField(2)
  final List<AllSizes> allSizesList;

  const ProductVarieants({
    required this.color,
    required this.imagesList,
    required this.allSizesList,
  });

  @override
  List<Object?> get props => [color, imagesList, allSizesList];
}

@HiveType(typeId: 2)
class AllSizes extends Equatable {
  @HiveField(0)
  final String size;
  @HiveField(1)
  final String price;
  @HiveField(2)
  final String amount;

  const AllSizes({
    required this.size,
    required this.amount,
    required this.price,
  });

  @override
  List<Object?> get props => [size, price, amount];
}
