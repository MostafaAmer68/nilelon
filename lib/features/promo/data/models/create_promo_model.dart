// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:intl/intl.dart';

class CreatePromo {
  final DateTime startDate;
  final DateTime endDate;
  final double discountRate;
  final List<String> productIds;

  CreatePromo({
    required this.startDate,
    required this.endDate,
    required this.discountRate,
    required this.productIds,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'startDate': DateFormat("yyyy-MM-ddTHH:mm:ss.SSS'Z'").format(startDate),
      'endDate': DateFormat("yyyy-MM-ddTHH:mm:ss.SSS'Z'").format(endDate),
      'discountRate': discountRate / 100,
      'productIds': productIds,
    };
  }
}
