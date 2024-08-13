// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 5;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      token: fields[0] as String,
      role: fields[1] as String,
      userData: fields[2] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.token)
      ..writeByte(1)
      ..write(obj.role)
      ..writeByte(2)
      ..write(obj.userData);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class BaseUserDataAdapter extends TypeAdapter<BaseUserData> {
  @override
  final int typeId = 6;

  @override
  BaseUserData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BaseUserData(
      name: fields[0] as String,
      email: fields[1] as String,
      phoneNumber: fields[2] as String,
      profilePic: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, BaseUserData obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.phoneNumber)
      ..writeByte(3)
      ..write(obj.profilePic);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BaseUserDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class StoreModelAdapter extends TypeAdapter<StoreModel> {
  @override
  final int typeId = 7;

  @override
  StoreModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StoreModel(
      name: fields[0] as String,
      email: fields[1] as String,
      phoneNumber: fields[2] as String,
      repName: fields[5] as String,
      storeSlogan: fields[6] as String,
      repPhone: fields[7] as String,
      warehouseAddress: fields[8] as String,
      profilePic: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, StoreModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(5)
      ..write(obj.repName)
      ..writeByte(6)
      ..write(obj.storeSlogan)
      ..writeByte(7)
      ..write(obj.repPhone)
      ..writeByte(8)
      ..write(obj.warehouseAddress)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.phoneNumber)
      ..writeByte(3)
      ..write(obj.profilePic);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StoreModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CustomerModelAdapter extends TypeAdapter<CustomerModel> {
  @override
  final int typeId = 8;

  @override
  CustomerModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CustomerModel(
      name: fields[0] as String,
      email: fields[1] as String,
      phoneNumber: fields[2] as String,
      dateOfBirth: fields[9] as String,
      gender: fields[10] as String,
      productsChoice: fields[11] as String,
      profilePic: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CustomerModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(9)
      ..write(obj.dateOfBirth)
      ..writeByte(10)
      ..write(obj.gender)
      ..writeByte(11)
      ..write(obj.productsChoice)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.phoneNumber)
      ..writeByte(3)
      ..write(obj.profilePic);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CustomerModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
