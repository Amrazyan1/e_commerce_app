// api_service.dart
import 'dart:convert';
import 'dart:developer';

import 'package:e_commerce_app/endpoints/endpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/delivery_addreses_model.dart';
import '../models/reverse_geocode_model.dart';
import 'dio_client.dart';
import 'package:dio/dio.dart';

class ApiService {
  final DioClient _dioClient;

  ApiService(this._dioClient);

  Future<void> sendPhoneNumber(String phoneNumber) async {
    final prefs = await SharedPreferences.getInstance();
    final fcmToken = prefs.getString('fcm_token');
    final response = await _dioClient.dio.post(
      '/auth/verification/send',
      data: {
        'phone': phoneNumber,
        'fcm': fcmToken,
      },
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to send phone number');
    }
  }

  Future<Response> verifyOtp(String phoneNumber, String otp) async {
    final prefs = await SharedPreferences.getInstance();
    final fcmToken = prefs.getString('fcm_token');
    final response = await _dioClient.dio.post('/auth/verification/verify', data: {
      'phone': phoneNumber,
      'code': otp,
      'fcm': fcmToken,
    });
    if (response.statusCode != 200) {
      throw Exception('OTP verification failed');
    }
    return response;
  }

  Future<ReverseGeocodeResponse> reverseGeocode(double lat, double lon) async {
    final response = await _dioClient.dio.get(
      'https://nominatim.openstreetmap.org/reverse',
      queryParameters: {
        'format': 'json',
        'lat': lat.toString(),
        'lon': lon.toString(),
        'zoom': '18',
        'addressdetails': '1',
      },
    );

    if (response.statusCode == 200) {
      return reverseGeocodeResponseFromJson(response.data);
    } else {
      throw Exception('Failed to fetch reverse geocode data');
    }
  }

  // User Addresses
  Future<DeliveryAddressesResponse> getUserAddresses(int perPage) async {
    final response = await _dioClient.dio
        .get(Endpoints.userAddresses, options: Options(contentType: "application/json"));
    if (response.statusCode == 200) {
      return deliveryAddressesResponseFromJson(response.data);
    } else {
      throw Exception('Failed to fetch reverse geocode data');
    }
  }

  Future<Response> setDefaultAddress(String id) async {
    try {
      return await _dioClient.dio.put(
        Endpoints.setDefaultAddress.replaceFirst('{id}', id),
      );
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<Response> addAddress(Map<String, dynamic> addressData) async {
    try {
      return await _dioClient.dio.post(
        Endpoints.addAddress,
        data: addressData,
      );
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<Response> updateAddressById(String id) async {
    try {
      return await _dioClient.dio.put(
        Endpoints.updateAddressById.replaceFirst('{id}', id),
      );
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<Response> deleteAddressById(String id) async {
    try {
      return await _dioClient.dio.delete(
        Endpoints.deleteAddressById.replaceFirst('{id}', id),
      );
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<Response> getCoupons() async {
    try {
      return await _dioClient.dio.get(
        Endpoints.coupons,
      );
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<Response> addCoupon(String promocode) async {
    try {
      return await _dioClient.dio.patch(
        Endpoints.couponsActivate,
        data: {
          'promoCode': promocode,
        },
      );
    } on DioException catch (e) {
      rethrow;
    }
  }

  // Articles
  Future<Response> getArticles(int perPage) async {
    try {
      return await _dioClient.dio.get(
        Endpoints.articles.replaceFirst('{perPage}', perPage.toString()),
      );
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<Response> getArticleById(String id) async {
    try {
      return await _dioClient.dio.get(
        Endpoints.articleById.replaceFirst('{id}', id),
      );
    } on DioException catch (e) {
      rethrow;
    }
  }

  // Authentication
  Future<Response> registeruser(String fullname, String email, String password, String birthDate,
      String phone, String gender) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final fcmToken = prefs.getString('fcm_token');
      final response = await _dioClient.dio.post(
        Endpoints.userSignUp,
        data: {
          'fullName': fullname,
          'email': email,
          'birthday': birthDate,
          'phone': phone,
          'sex': gender,
          'fcm': fcmToken,
        },
      );
      log(response.data);
      Map<String, dynamic> decodedJson = json.decode(response.data);
      if (decodedJson['errors'] == false) {
        log('errors');

        final token = decodedJson['data']['token'];
        log(token);

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', token); // Store token securely
      }
      return response;
    } on DioException catch (e) {
      log('error ${e.error}');
      rethrow;
    }
  }

  Future<Response> signUpUser(Map<String, dynamic> userData) async {
    try {
      return await _dioClient.dio.post(
        Endpoints.userSignUp,
        data: userData,
      );
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<Response> subscribe(Map<String, dynamic> subscriptionData) async {
    try {
      return await _dioClient.dio.post(
        Endpoints.subscription,
        data: subscriptionData,
      );
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<Response> deleteSubscriptionById(String id) async {
    try {
      return await _dioClient.dio.delete(
        Endpoints.subscriptionById.replaceFirst('{id}', id),
      );
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<Response> verifyUser(Map<String, dynamic> verificationData) async {
    try {
      return await _dioClient.dio.post(
        Endpoints.verifyUser,
        data: verificationData,
      );
    } on DioException catch (e) {
      rethrow;
    }
  }

  // Branches
  Future<Response> getBranches() async {
    try {
      return await _dioClient.dio.get(Endpoints.branches);
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<Response> getBranchDevices(String branchId) async {
    try {
      return await _dioClient.dio.get(
        Endpoints.branchDevices.replaceFirst('{id}', branchId),
      );
    } on DioException catch (e) {
      rethrow;
    }
  }

  // Brands
  Future<Response> getBrands() async {
    try {
      return await _dioClient.dio.get(Endpoints.brands);
    } on DioException catch (e) {
      rethrow;
    }
  }

  // Cart
  Future<Response> getCarts() async {
    try {
      return await _dioClient.dio.get(Endpoints.carts);
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<Response> deleteCarts() async {
    try {
      return await _dioClient.dio.delete(Endpoints.carts);
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<Response> addToCart(Map<String, dynamic> cartData) async {
    try {
      return await _dioClient.dio.post(
        Endpoints.addCart,
        data: cartData,
      );
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<Response> reduceCart(Map<String, dynamic> cartData) async {
    try {
      return await _dioClient.dio.post(
        Endpoints.reduceCart,
        data: cartData,
      );
    } on DioException catch (e) {
      log('Error reduceCart ${e.toString()}');
      rethrow;
    }
  }

  Future<Response> changeCart(Map<String, dynamic> cartData) async {
    try {
      return await _dioClient.dio.post(
        Endpoints.changeCart,
        data: cartData,
      );
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<Response> deleteCartItemById(String id) async {
    try {
      return await _dioClient.dio.delete(
        Endpoints.cartById.replaceFirst('{id}', id),
      );
    } on DioException catch (e) {
      rethrow;
    }
  }

  // Categories
  Future<Response> getCategories({int perPage = 20}) async {
    try {
      return await _dioClient.dio.get(
        Endpoints.getCategories.replaceFirst('{perPage}', perPage.toString()),
      );
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<Response> getSubcategoriesById(String id, int perPage) async {
    try {
      return await _dioClient.dio.get(
        Endpoints.getSubcategoriesById
            .replaceFirst('{id}', id)
            .replaceFirst('{perPage}', perPage.toString()),
      );
    } on DioException catch (e) {
      rethrow;
    }
  }

  // Contents
  Future<Response> getContentsByKeys(String keys) async {
    try {
      return await _dioClient.dio.get(
        Endpoints.getContentsByKey.replaceFirst('{key}', keys),
      );
    } on DioException catch (e) {
      rethrow;
    }
  }

  // Customer
  Future<Response> subscribeCustomer(Map<String, dynamic> data) async {
    try {
      return await _dioClient.dio.post(
        Endpoints.subscribeCustomer,
        data: data,
      );
    } on DioException catch (e) {
      rethrow;
    }
  }

  // Orders
  Future<Response> getOrderById(String id) async {
    try {
      return await _dioClient.dio.get(
        Endpoints.getOrderById.replaceFirst('{id}', id),
      );
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<Response> cancelOrderById(String id) async {
    try {
      return await _dioClient.dio.patch(
        Endpoints.cancelOrderById.replaceFirst('{id}', id),
      );
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<Response> createOrder(Map<String, dynamic> data) async {
    try {
      return await _dioClient.dio.post(
        Endpoints.createOrder,
        data: data,
      );
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<Response> processOrder(String id, Map<String, dynamic> data) async {
    try {
      return await _dioClient.dio.put(
        Endpoints.processOrder.replaceFirst('{id}', id),
        data: data,
      );
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<Response> payOrder(
    String id,
    String method,
  ) async {
    try {
      return await _dioClient.dio.post(
        Endpoints.payOrder.replaceFirst('{id}', id).replaceFirst('{method}', method),
      );
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<Response> notifyOrder(String id, Map<String, dynamic> data) async {
    try {
      return await _dioClient.dio.post(
        Endpoints.notifyOrder.replaceFirst('{id}', id),
        data: data,
      );
    } on DioException catch (e) {
      rethrow;
    }
  }

  // Partners
  Future<Response> getPartnersUsers() async {
    try {
      return await _dioClient.dio.get(Endpoints.getPartnersUsers);
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<Response> createPartnerForUser(Map<String, dynamic> data) async {
    try {
      return await _dioClient.dio.post(
        Endpoints.createPartnerForUser,
        data: data,
      );
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<Response> createPartner(Map<String, dynamic> data) async {
    try {
      return await _dioClient.dio.post(
        Endpoints.createPartner,
        data: data,
      );
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<Response> certificatePartner(Map<String, dynamic> data) async {
    try {
      return await _dioClient.dio.post(
        Endpoints.certificatePartner,
        data: data,
      );
    } on DioException catch (e) {
      rethrow;
    }
  }

  // Products
  Future<Response> getProductsByCategory(String id, int perPage, CancelToken cancelToken) async {
    try {
      return await _dioClient.dio.get(
          Endpoints.getProductsByCategory
              .replaceFirst('{id}', id)
              .replaceFirst('{perPage}', 20.toString())
              .replaceFirst('{page}', perPage.toString()),
          cancelToken: cancelToken);
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<Response> getProductsByCategoryWithQuery(
      String id, Map<String, dynamic> queryParams, CancelToken cancelToken) async {
    try {
      return await _dioClient.dio.get(
          Endpoints.getProductsByCategoryWithQuery.replaceFirst('{id}', id),
          queryParameters: queryParams,
          cancelToken: cancelToken);
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<Response> getProductById(String id) async {
    try {
      return await _dioClient.dio.get(
        Endpoints.getProductById.replaceFirst('{id}', id),
      );
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<Response> getProductRatings(String productId) async {
    try {
      return await _dioClient.dio.get(
        Endpoints.getProductRatings.replaceFirst('{product:id}', productId),
      );
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<Response> addProductRating(String productId, Map<String, dynamic> data) async {
    try {
      return await _dioClient.dio.post(
        Endpoints.addProductRating.replaceFirst('{product:id}', productId),
        data: data,
      );
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<Response> getFavoriteProducts() async {
    try {
      return await _dioClient.dio.get(Endpoints.getFavoriteProducts);
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<Response> addProductToFavorites(Map<String, dynamic> data) async {
    try {
      return await _dioClient.dio.post(
        Endpoints.addProductToFavorites,
        data: data,
      );
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<Response> removeProductFromFavorites(String id) async {
    try {
      return await _dioClient.dio.delete(
        Endpoints.removeProductFromFavorites.replaceFirst('{id}', id),
      );
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<Response> getTrendProducts(String trend, int perPage) async {
    try {
      return await _dioClient.dio.get(
        Endpoints.getTrendProducts
            .replaceFirst('{trend}', trend)
            .replaceFirst('{perPage}', perPage.toString()),
      );
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<Response> getTrendNewestProducts() async {
    try {
      return await _dioClient.dio.get(
        Endpoints.getTrendNewestProduct,
      );
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<Response> getTrendPopularProducts() async {
    try {
      return await _dioClient.dio.get(
        Endpoints.getTrendPopularProduct,
      );
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<Response> getDiscountedProducts() async {
    try {
      return await _dioClient.dio.get(
        Endpoints.getTrendDiscountProduct,
      );
    } on DioException catch (e) {
      rethrow;
    }
  }

  // Professions
  Future<Response> getProfessions() async {
    try {
      return await _dioClient.dio.get(Endpoints.getProfessions);
    } on DioException catch (e) {
      rethrow;
    }
  }

  // Regions
  Future<Response> getRegions(int perPage) async {
    try {
      return await _dioClient.dio.get(
        Endpoints.getRegions.replaceFirst('{perPage}', perPage.toString()),
      );
    } on DioException catch (e) {
      rethrow;
    }
  }

  // Search
  Future<Response> searchCatalog(String keyword, int perPage) async {
    try {
      return await _dioClient.dio.get(
        Endpoints.searchCatalog
            .replaceFirst('{keyword}', keyword)
            .replaceFirst('{perPage}', perPage.toString()),
      );
    } on DioException catch (e) {
      rethrow;
    }
  }

  // Sessions
  Future<Response> clearSession() async {
    try {
      return await _dioClient.dio.post(Endpoints.clearSession);
    } on DioException catch (e) {
      rethrow;
    }
  }

  // Spheres
  Future<Response> getSpheres() async {
    try {
      return await _dioClient.dio.get(Endpoints.getSpheres);
    } on DioException catch (e) {
      rethrow;
    }
  }

  // User
  Future<Response> getUserOrders() async {
    try {
      return await _dioClient.dio.get(
        Endpoints.getUserOrders,
      );
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<Response> getUserSettings() async {
    log('getUserSettings');
    try {
      return await _dioClient.dio.get(
        Endpoints.getUserSettings,
      );
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<Response> deleteUser() async {
    try {
      return await _dioClient.dio.delete(Endpoints.deleteUser);
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<Response> updateUserSettings(Map<String, dynamic> data) async {
    try {
      return await _dioClient.dio.put(
        Endpoints.updateUserSettings,
        data: data,
      );
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<Response> updateUserPassword(Map<String, dynamic> data) async {
    try {
      return await _dioClient.dio.put(
        Endpoints.updateUserPassword,
        data: data,
      );
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<Response> addCard() async {
    try {
      return await _dioClient.dio.post(
        Endpoints.addCard,
      );
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<Response> getAllCards() async {
    try {
      return await _dioClient.dio.get(
        Endpoints.cards,
      );
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<Response> editCard(String id, Map<String, dynamic> data) async {
    try {
      return await _dioClient.dio.put(
        Endpoints.cardsWithId.replaceFirst('{id}', id),
        data: data,
      );
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<Response> deleteCard(String id) async {
    try {
      return await _dioClient.dio.delete(
        Endpoints.cardsWithId.replaceFirst('{id}', id),
      );
    } on DioException catch (e) {
      rethrow;
    }
  }
}
