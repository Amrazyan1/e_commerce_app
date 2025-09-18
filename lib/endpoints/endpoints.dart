// endpoints.dart

class Endpoints {
  //coupons/
  static const String coupons = '/coupons';
  static const String couponsActivate = '/coupons/activate';

  // User addresses
  static const String userAddresses = '/users/addresses';
  static const String setDefaultAddress = '/users/addresses/{id}/set-default';
  static const String addAddress = '/users/addresses';
  static const String updateAddressById = '/users/addresses/{id}';
  static const String deleteAddressById = '/users/addresses/{id}';

  // Articles
  static const String articles = '/articles/?perPage={perPage}';
  static const String articleById = '/articles/{id}';

  // Authentication
  static const String userLogin = '/auth/login/user';
  static const String userSignUp = '/auth/sign-up';
  static const String subscription = '/auth/subscription';
  static const String subscriptionById = '/auth/subscription/{id}';
  static const String verifyUser = '/auth/verification/verify';

  // Branches
  static const String branches = '/branches';
  static const String branchDevices = '/branches/{id}/devices';

  // Brands
  static const String brands = '/brandes';

  // Cart
  static const String carts = '/carts';
  static const String addCart = '/carts/add';
  static const String reduceCart = '/carts/reduce';
  static const String changeCart = '/carts/change';
  static const String cartById = '/carts/{id}';

  // Categories
  static const String getCategories = '/categories?perPage={perPage}&with-subcategories=true';
  static const String getSubcategoriesById = '/categories/{id}?perPage={perPage}';
  // static const String getCategoryBreadcrumbs = '/categories/{id}/breadcrumbs';
  static const String getProductsByCategory =
      '/categories/{id}/products?perPage={perPage}&page={page}';
  static const String getProductsByCategoryWithQuery = '/categories/{id}/products';
  // Contents
  static const String getContentsByKey = '/contents?keys[]={key}';

  // Customer
  static const String subscribeCustomer = '/customers';

  // Orders
  static const String getOrderById = '/orders/{id}';
  static const String cancelOrderById = '/orders/{id}/cancel';
  static const String createOrder = '/orders';
  static const String processOrder = '/orders/{id}/process';
  static const String payOrder = '/orders/{id}/pay/{method}';
  static const String notifyOrder = '/orders/{id}/notify';

  // Partners
  static const String getPartnersUsers = '/partners/users';
  static const String createPartnerForUser = '/partners/users';
  static const String createPartner = '/partners';
  static const String certificatePartner = '/partners/certificate';

  // Products

  static const String getProductById = '/products/{id}';
  static const String getProductRatings = '/products/{product:id}/ratings';
  static const String addProductRating = '/products/{product:id}/ratings';
  static const String getFavoriteProducts = '/products/favorites';
  static const String addProductToFavorites = '/products/favorites';
  static const String removeProductFromFavorites = '/products/favorites/{id}';
  static const String getTrendProducts = '/products/trends/{trend}?perPage={perPage}';
  static const String getTrendNewestProduct = '/products/trends/newest';
  static const String getTrendPopularProduct = '/products/trends/popular?perPage=12';
  static const String getTrendDiscountProduct = '/products/trends/discounted';

  // Professions
  static const String getProfessions = '/professions';

  // Regions
  static const String getRegions = '/regions/?perPage={perPage}';

  // Search
  static const String searchCatalog = '/search/{keyword}?perPage={perPage}';

  // Sessions
  static const String clearSession = '/sessions/clear';

  // Spheres
  static const String getSpheres = '/spheres';

  // User
  static const String getUserOrders = '/users/orders';
  static const String getUserSettings = '/users/settings';
  static const String deleteUser = '/users';
  static const String updateUserSettings = '/users/settings';
  static const String updateUserPassword = '/users/settings/password';
  static const String addCard = '/users/addCard/addCard';
}
