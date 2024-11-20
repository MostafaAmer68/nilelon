// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:nilelon/features/product/domain/models/product_model.dart';

class ProductResponse extends Equatable {
  final MetaDataProducts metaData;
  final List<ProductModel> data;
  const ProductResponse({
    required this.metaData,
    required this.data,
  });

  @override
  List<Object> get props => [metaData, data];

  factory ProductResponse.fromMap(Map<String, dynamic> map) {
    return ProductResponse(
      metaData: MetaDataProducts.fromMap(map['metaData'] as Map<String, dynamic>),
      data: List<ProductModel>.from(
        (map['data'] as List).map<ProductModel>(
          (x) => ProductModel.fromJson(x as Map<String, dynamic>),
        ),
      ),
    );
  }
  factory ProductResponse.empty() => ProductResponse(
        metaData: MetaDataProducts.ampty(),
        data: const [],
      );

  ProductResponse copyWith({
    MetaDataProducts? metaData,
    List<ProductModel>? data,
  }) {
    return ProductResponse(
      metaData: metaData ?? this.metaData,
      data: data ?? this.data,
    );
  }
}

class MetaDataProducts extends Equatable {
  final num currentPage;
  final num totalPages;
  final num pageSize;
  final num totalCount;
  final bool hasPrevious;
  final bool hasNext;
  const MetaDataProducts({
    required this.currentPage,
    required this.totalPages,
    required this.pageSize,
    required this.totalCount,
    required this.hasPrevious,
    required this.hasNext,
  });

  factory MetaDataProducts.ampty() => const MetaDataProducts(
      currentPage: 0,
      totalPages: 0,
      pageSize: 0,
      totalCount: 0,
      hasPrevious: false,
      hasNext: false);

  @override
  List<Object> get props {
    return [
      currentPage,
      totalPages,
      pageSize,
      totalCount,
      hasPrevious,
      hasNext,
    ];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'currentPage': currentPage,
      'totalPages': totalPages,
      'pageSize': pageSize,
      'totalCount': totalCount,
      'hasPrevious': hasPrevious,
      'hasNext': hasNext,
    };
  }

  factory MetaDataProducts.fromMap(Map<String, dynamic> map) {
    return MetaDataProducts(
      currentPage: map['currentPage'] as num,
      totalPages: map['totalPages'] as num,
      pageSize: map['pageSize'] as num,
      totalCount: map['totalCount'] as num,
      hasPrevious: map['hasPrevious'] as bool,
      hasNext: map['hasNext'] as bool,
    );
  }
}
