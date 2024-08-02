import 'package:equatable/equatable.dart';

import 'product_model.dart';

class ProductsResponseModel extends Equatable {
  final num? statusCode;
  final bool? isSuccess;
  final List<dynamic>? errorMessages;
  final List<ProductModel>? result;

  const ProductsResponseModel({
    this.statusCode,
    this.isSuccess,
    this.errorMessages,
    this.result,
  });

  factory ProductsResponseModel.fromJson(Map<String, dynamic> json) {
    return ProductsResponseModel(
      statusCode: json['statusCode'] as num?,
      isSuccess: json['isSuccess'] as bool?,
      errorMessages: json['errorMessages'] as List<dynamic>?,
      result: (json['result'] as List<dynamic>?)
          ?.map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'statusCode': statusCode,
        'isSuccess': isSuccess,
        'errorMessages': errorMessages,
        'result': result?.map((e) => e.toJson()).toList(),
      };

  @override
  List<Object?> get props {
    return [
      statusCode,
      isSuccess,
      errorMessages,
      result,
    ];
  }
}
