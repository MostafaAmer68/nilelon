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

  // search url
  static const String searchUrl = '/Search/Search';
  // return urls
  static const String getCustomerReturensUrl =
      '/ReturnedVariants/GetCustomerReturns';
  static const String getStoreReturensUrl = '/ReturnedVariants/GetStoreReturns';
  static const String getCustomerWrongItemDetailsUrl =
      '/ReturnedVariants/GetCustomerWrongItemDetails';
  static const String getCustomerMissingItemDetailsUrl =
      '/ReturnedVariants/GetCustomerMissingItemDetails';
  static const String getCustomerChangeMindItemDetailsUrl =
      '/ReturnedVariants/GetCustomerChangedMindItemDetails';
  static const String createReturnedWrongItem =
      '/ReturnedVariants/CreateReturnedWrongItem';
  static const String createReturnedMissingItem =
      '/ReturnedVariants/CreateReturnedMissingItem';
  static const String createReturnedChangeMindItem =
      '/ReturnedVariants/CreateReturnedChangeMindItem';

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
      '/Authentication/GoogleRegister';

  //todo Customer Cart Urls
  static const String getCartByCustomerIdUrl = '/Cart/GetCartByCustomerId';
  static const String deleteFromCartUrl = '/Cart/DeleteItemFromCart';
  static const String updateQuantityCartUrl = '/Cart/ChangeItemQuantity';
  static const String addToCartUrl = '/Cart/AddToCart';
  static const String emptyCartUrl = '/Cart/EmptyCart';

  //todo payment urls
  static const String getClientTokenUrl = '/PaymentService/OrderTransaction';
  static const String makeTransactionUrl = '/PaymentService/MakeTransaction';
  static const String makeTransactionWithPaymentUrl =
      '/PaymentService/MakeTransactionWithPayment';
  static const String refundTransactionUrl =
      '/PaymentService/RefundTransaction';
  static const String addPayment = '/PaymentService/AddPayment';
  static const String getPaymentMethods = '/PaymentService/GetPaymentMethods';

  //todo reviews urls
  static const String createReviewUrl = '/Review/CreateReview';
  static const String getReviewsForProductUrl = '/Review/GetReviewsForProduct';

  //todo shipping method
  static const String getShippingMethodUrl =
      '/ShippingMethod/GetShippingMethods';
  //todo order urls
  static const String getCustomerOrderUrl = '/Order/GetCustomerOrders';
  static const String getStoreOrderUrl = '/Order/GetStoreOrderes';
  static const String createOrderUlr = '/Order/CreateOrder';
  static const String changeOrderStateUrl = '/Order/ChangeOrderState';
  static const String getOrderDetailsByIdUrl = '/Order/GetOrderDetailsById';
  static const String getStoreOrderDetailsUrl = '/Order/GetStoreOrderDetails';
  static const String getStoreOderByDateUrl = '/Order/GetStoreOrderByDate';

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
  static const String getCustomersOffersUrl = '/Product/GetOffers';
  static const String getProductByCategory = '/Product/GetProductsByCategory';
  static const String getStoreOffersUrl = '/Product/GetOffersForStore';

  //todo Static Product Queries Urls
  static const String page = '&page=';
  static const String pageSize = '&pageSize=';
  static const String customerId = '&customerId=';

  //?*********************************************************************************

  //! Store Urls

  static const String updateStoreInfoUrl = '/Store/UpdateStoreInfo';
  static const String updateStoreUrl = '/Store/UpdateStore';
  static const String getStoresUrls = '/Store/GetStores';
  static const String getStoreByIdUrl = '/Store/GetStore';
  static const String getStoreForCustomer = '/Store/GetStoreForCustomer';
  //todo Authentication For Store Urls
  static const String storeRegisterUrl = '/Authentication/StoreRegister';

  //todo Dashboard For Store Urls
  static const String getDashboardDataUrl = '/Dashboard/GetDashboardData';
  static const String getChartDataUrl = '/Dashboard/GetChartData?storeId=';

  //todo Dashboard For Store Urls
  static const String getStartDateUrl = '&startDate=';
  static const String getEndDateUrl = '&endDate=';

  //?*********************************************************************************

  //! Shared Urls
  //todo Authentication Shared Urls
  static const String loginUrl = '/Authentication/Login';

  //todo Category Urls
  static const String getAllCategoriesUrl = '/Category/GetAllCategories';

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

  // promotion
  static const String getPromoCodeType = '/Promotion/GetPromoCodeType';
  static const String getOrderDiscount = '/Promotion/GetOrderDiscount';
  static const String getFreeShipping = '/Promotion/GetFreeShipping';
  static const String getStoreDiscount = '/Promotion/GetStoreDiscount';

  //todo Recommendation Urls
  static const String setRecommendationUrl =
      '/Customer/UpdateProductsChoice?customerId=';

  //?*********************************************************************************
}
