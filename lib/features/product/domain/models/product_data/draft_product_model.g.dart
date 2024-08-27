// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'draft_product_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DraftProductModelAdapter extends TypeAdapter<DraftProductModel> {
  @override
  final int typeId = 20;

  @override
  DraftProductModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DraftProductModel(
      productPrice: fields[2] as String,
      product: fields[0] as AddProductModel,
      isEditable: (fields[1] as List)
          .map((dynamic e) => (e as Map).cast<String, bool>())
          .toList(),
    );
  }

  @override
  void write(BinaryWriter writer, DraftProductModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.product)
      ..writeByte(1)
      ..write(obj.isEditable)
      ..writeByte(2)
      ..write(obj.productPrice);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DraftProductModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
