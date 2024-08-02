// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_product_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AddProductModelAdapter extends TypeAdapter<AddProductModel> {
  @override
  final int typeId = 0;

  @override
  AddProductModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AddProductModel(
      sizeGuideImage: fields[4] as String,
      categoryName: fields[0] as String,
      productName: fields[1] as String,
      type: fields[2] as String,
      productDescription: fields[3] as String,
      varieantsList: (fields[5] as List).cast<dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, AddProductModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.categoryName)
      ..writeByte(1)
      ..write(obj.productName)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.productDescription)
      ..writeByte(4)
      ..write(obj.sizeGuideImage)
      ..writeByte(5)
      ..write(obj.varieantsList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddProductModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ProductVarieantsAdapter extends TypeAdapter<ProductVarieants> {
  @override
  final int typeId = 1;

  @override
  ProductVarieants read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductVarieants(
      color: fields[0] as String,
      imagesList: (fields[1] as List).cast<String>(),
      allSizesList: (fields[2] as List).cast<AllSizes>(),
    );
  }

  @override
  void write(BinaryWriter writer, ProductVarieants obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.color)
      ..writeByte(1)
      ..write(obj.imagesList)
      ..writeByte(2)
      ..write(obj.allSizesList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductVarieantsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AllSizesAdapter extends TypeAdapter<AllSizes> {
  @override
  final int typeId = 2;

  @override
  AllSizes read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AllSizes(
      size: fields[0] as String,
      amount: fields[2] as String,
      price: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AllSizes obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.size)
      ..writeByte(1)
      ..write(obj.price)
      ..writeByte(2)
      ..write(obj.amount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AllSizesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
