class ShippingMethod {
  final String id;
  final String name;
  final String description;
  final String estimatedDelivery;
  final String carrier;
  final List<ShippingCost> shippingCosts;

  ShippingMethod({
    required this.id,
    required this.name,
    required this.description,
    required this.estimatedDelivery,
    required this.carrier,
    required this.shippingCosts,
  });

  factory ShippingMethod.fromJson(Map<String, dynamic> json) {
    return ShippingMethod(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      estimatedDelivery: json['estimatedDelivery'],
      carrier: json['carrier'],
      shippingCosts: (json['shippingCosts'] as List)
          .map((i) => ShippingCost.fromJson(i))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'estimatedDelivery': estimatedDelivery,
      'carrier': carrier,
      'shippingCosts': shippingCosts.map((i) => i.toJson()).toList(),
    };
  }
}

class ShippingCost {
  final String governate;
  final int price;

  ShippingCost({
    required this.governate,
    required this.price,
  });

  factory ShippingCost.fromJson(Map<String, dynamic> json) {
    return ShippingCost(
      governate: json['governate'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'governate': governate,
      'price': price,
    };
  }
}
