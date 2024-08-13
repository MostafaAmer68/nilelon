class EndPoint {
  //?*********************************************************************************

  //! Base Url
  static const String baseUrl = 'http://nilelon.somee.com/api';

  //?*********************************************************************************

  //! Customer Urls
  static const String setCustomerAddressUrl = '/Customer/SetCustomerAddress';
  static const String updateCustomerUrl = '/Customer/UpdateCustomer';
  static const String updateProductChoiceUrl = '/Customer/UpdateProductChoice';
  static const String getCustomerAddressUrl = '/Customer/GetCustomerAddress';
  static const String follow = '/Customer/Follow';

  //todo Authentication For Customer Urls
  static const String customerRegisterUrl = '/Authentication/CustomerRegister';
  static const String validateOTP = '/Authentication/ValidateOTP';
  static const String confirmRegiseration =
      '/Authentication/ConfirmRegiseration';
  static const String resetPasswordEmailUrl =
      '/Authentication/ResetPasswordEmail';
  static const String resetPasswordPhoneUrl =
      '/Authentication/ResetPasswordPhone';
  static const String forgotPasswordUrl = '/Authentication/ForgotPassword';
  static const String changePasswordUrl = '/Authentication/ChangePassword';
  static const String resetEmailUrl = '/Authentication/ResetEmail';
  static const String resetPhoneUrl = '/Authentication/ResetPhone';
  static const String resetEmailDetailUrl = '/Authentication/ResetEmailDetails';
  static const String resetPhoneDetailsUrl =
      '/Authentication/ResetPhoneDetails';
  static const String customerGoogleRegisterUrl =
      '/Authentication/ExternalRegister';

  //todo Customer Cart Urls
  static const String getCartByCustomerIdUrl = '/Cart/GetCartByCustomerId';
  static const String deleteFromCartUrl = '/Cart/DeleteItemFromCart';
  static const String updateQuantityCartUrl = '/Cart/ChangeItemQuantity';
  static const String addToCartUrl = '/Cart/AddToCart';
  static const String emptyCartUrl = '/Cart/EmptyCart';

  //order urls
  static const String getCustomerOrderUrl = 'Order/GetCustomerOrders';
  static const String getStoreOrderUrl = 'Order/GetStoreOrder';
  static const String createOrderUlr = 'Order/CreateOrder';
  static const String changeOrderStateUrl = 'Order/ChangeOrderState';
  static const String getStoreOderByDateUrl = 'Order/GetStoreOrderByDate';

  //todo Customer Closet Urls
  static const String createClosetUrl = '/Closet/CreateCloset';
  static const String addProductToClosetUrl = '/Closet/AddProductToCloset';
  static const String deleteProductFromCloset = '/Closet/DeleteFromCloset';
  static const String deleteClosetUrl = '/Closet/DeleteCloset';
  static const String emptyClosetUrl = '/Closet/EmptyCloset';
  static const String addProductToDefaultClosetUrl =
      '/Closet/AddProductToDefaultCloset';
  static const String getCustomerClosetUrl = '/Closet/GetCustomerClosets';
  static const String getClosetItemsUrl = '/Closet/GetClosetItems';

  //todo Customer Products Urls
  static const String getFollowedProductsUrl = '/Product/GetFollowedProducts';
  static const String getNewProductsUrl = '/Product/GetNewNProducts';
  static const String getRandomProductsUrl = '/Product/GetRandomProducts';
  static const String getNewProductsGuestUrl = '/Product/GetNewNProductsGuest';
  static const String getRandomProductsGuestUrl =
      '/Product/GetRandomProductsGuest';

  //todo Static Product Queries Urls
  static const String page = '&page=';
  static const String pageSize = '&pageSize=';
  static const String customerId = '&customerId=';

  //?*********************************************************************************

  //! Store Urls

  static const String updateStoreInfoUrl = '/Store/UpdateStoreInfo';
  static const String updateStoreUrl = '/Store/UpdateStore';
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
  static const String getStoreProductsUrl = '/Product/GetStoreProducts';
  static const String createProductUrl = '/Product/CreateProduct';
  static const String createProductVariantUrl = '/Product/CreateProductVariant';
  static const String createProductImagesUrl = '/Product/CreateProductImages';
  static const String updateProductUrl = '/Product/UpdateProduct';
  static const String deleteProductUrl = '/Product/DeleteProduct';
  static const String changeProductVariantPriceQuantityUrl =
      '/Product/ChangeProductVariantPriceQuantity';
  static const String deleteProductVariantUrl = '/Product/DeleteProductVariant';
  static const String deleteProductImageUrl = '/Product/DeleteProductImage';

  //?*********************************************************************************
}
