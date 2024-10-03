class DashboardModel {
  final int storeFollowers;
  final String storeBestseller;
  final int storeNumberOfItemsSold;
  final int storeNumberOfNotifications;
  final int storeOrdersNumber;
  final int storeTotalIncome;
  final int storeRate;

  DashboardModel({
    required this.storeFollowers,
    required this.storeBestseller,
    required this.storeNumberOfItemsSold,
    required this.storeNumberOfNotifications,
    required this.storeOrdersNumber,
    required this.storeTotalIncome,
    required this.storeRate,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      storeFollowers: json['storeFollowers'],
      storeBestseller: json['storeBestseller'] ?? '',
      storeNumberOfItemsSold: json['storeNumberOfItemsSold'],
      storeNumberOfNotifications: json['storeNumberOfNotifications'],
      storeOrdersNumber: json['storeOrdersNumber'],
      storeTotalIncome: json['storeTotalIncome'],
      storeRate: json['storeRate'],
    );
  }
  factory DashboardModel.empty() {
    return DashboardModel(
        storeFollowers: 0,
        storeBestseller: '',
        storeNumberOfItemsSold: 0,
        storeNumberOfNotifications: 0,
        storeOrdersNumber: 0,
        storeTotalIncome: 0,
        storeRate: 0);
  }

  Map<String, dynamic> toJson() {
    return {
      'storeFollowers': storeFollowers,
      'storeBestseller': storeBestseller,
      'storeNumberOfItemsSold': storeNumberOfItemsSold,
      'storeNumberOfNotifications': storeNumberOfNotifications,
      'storeOrdersNumber': storeOrdersNumber,
      'storeTotalIncome': storeTotalIncome,
      'storeRate': storeRate,
    };
  }
}
