// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

class AddressModel extends Equatable {
  final String addressLine1;
  final String addressLine2;
  final String city;
  final String unitNumber;
  final String streetNumber;
  final String nearestLandMark;
  const AddressModel({
    required this.addressLine1,
    required this.addressLine2,
    required this.city,
    required this.unitNumber,
    required this.streetNumber,
    required this.nearestLandMark,
  });

  @override
  List<Object> get props {
    return [
      addressLine1,
      addressLine2,
      city,
      unitNumber,
      streetNumber,
      nearestLandMark,
    ];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'addressLine1': addressLine1,
      'addressLine2': addressLine2,
      'city': city,
      'unitNumber': unitNumber,
      'streetNumber': streetNumber,
      'nearestLandMark': nearestLandMark,
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      addressLine1: map['addressLine1'] as String,
      addressLine2: map['addressLine2'] as String,
      city: map['city'] as String,
      unitNumber: map['unitNumber'] as String,
      streetNumber: map['streetNumber'] as String,
      nearestLandMark: map['nearestLandMark'] as String,
    );
  }
}
