class EndPoint {
  //?*********************************************************************************

  //! Base Url
  static const String baseUrl = 'http://nilelon.somee.com/api';

  //?*********************************************************************************

  //! Customer Urls
  //todo Authentication For Customer Urls
  static const String customerRegisterUrl = '/Authentication/CustomerRegister';
  static const String validateOTP = '/Authentication/ValidateOTP';
  static const String confirmRegiseration =
      '/Authentication/ConfirmRegiseration';
  static const String customerGoogleLoginUrl = '/Authentication/ExternalLogin';
  static const String customerGoogleRegisterUrl =
      '/Authentication/ExternalRegister';

  //todo categories urls
  static const String categoriesUrl = '/Category/GetAllCategoreis';

  //todo Customer Cart Urls
  static const String getCartByCustomerIdUrl = '/Cart/GetCartByCustomerId?id=';
  static const String deleteFromCartUrl = '/Cart/DeleteItemFromCart';
  static const String updateQuantityCartUrl = '/Cart/ChangeItemQuantity';

  //todo Customer Closet Urls
  static const String getClosetUrl = '/Closet/GetCustomerClosets?customerId=';

  //todo Customer Products Urls
  static const String getFollowedProductsUrl =
      '/Product/GetFollowedProducts?CustomerId=';
  static const String getNewProductsUrl =
      '/Product/GetNewNProducts?CustomerId=';
  static const String getRandomProductsUrl =
      '/Product/GetRandomProducts?CustomerId=';

  //todo Static Product Queries Urls
  static const String page = '&page=';
  static const String pageSize = '&pageSize=';
  static const String customerId = '&customerId=';

  //?*********************************************************************************

  //! Store Urls
  //todo Authentication For Store Urls
  static const String storeRegisterUrl = '/Authentication/StoreRegister';

  //todo Dashboard For Store Urls
  static const String noOfItemsSold = '/Dashboard/NumberOdItemsSold?storId=';
  static const String noOfOrdersSold = '/Dashboard/NumberOfOrders?storId=';
  static const String totalIncomeSold = '/Dashboard/TotalIncome?storId=';
  static const String noOfFollowersSold =
      '/Dashboard/NumberOfFollowers?storId=';
  static const String noOfNotificationSold =
      '/Dashboard/NumberOfNotifications?storId=';

  //?*********************************************************************************

  //! Shared Urls
  //todo Authentication Shared Urls
  static const String loginUrl = '/Authentication/Login';

  //todo Category Urls
  static const String getAllCategoriesUrl = '/Category/GetAllCategoreis';

  //todo Products Urls
  static const String getStoreProductsUrl =
      '/Product/GetStoreProducts?soterId=';

  //?*********************************************************************************
}
