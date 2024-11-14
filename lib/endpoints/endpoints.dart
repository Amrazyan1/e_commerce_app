// endpoints.dart

class Endpoints {
  // User addresses
  static const String userAddresses = '/users/addresses/?perPage={perPage}';
  static const String setDefaultAddress = '/users/addresses/{id}/set-default';
  static const String addAddress = '/users/addresses';
  static const String getAddressById = '/users/addresses/{id}';
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
}
