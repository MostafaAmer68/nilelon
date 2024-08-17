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
      name: fields[0] as String,
      description: fields[1] as String,
      type: fields[2] as String,
      storeId: fields[3] as String,
      categoryID: fields[4] as String,
      sizeguide: fields[5] as String,
      variants: (fields[6] as List).cast<Variant>(),
    );
  }

  @override
  void write(BinaryWriter writer, AddProductModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.storeId)
      ..writeByte(4)
      ..write(obj.categoryID)
      ..writeByte(5)
      ..write(obj.sizeguide)
      ..writeByte(6)
      ..write(obj.variants);
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

class VariantAdapter extends TypeAdapter<Variant> {
  @override
  final int typeId = 1;

  @override
  Variant read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Variant(
      color: fields[0] as int,
      images: (fields[1] as List).cast<String>(),
      sizes: (fields[2] as List).cast<SizeModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, Variant obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.color)
      ..writeByte(1)
      ..write(obj.images)
      ..writeByte(2)
      ..write(obj.sizes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VariantAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SizeModelAdapter extends TypeAdapter<SizeModel> {
  @override
  final int typeId = 2;

  @override
  SizeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SizeModel(
      size: fields[0] as String,
      price: fields[1] as num,
      quantity: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, SizeModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.size)
      ..writeByte(1)
      ..write(obj.price)
      ..writeByte(2)
      ..write(obj.quantity);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SizeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
