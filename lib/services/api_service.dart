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
    final response = await _dioClient.dio
        .post('/auth/verification/send', data: {'phone': phoneNumber});
    if (response.statusCode != 200) {
      throw Exception('Failed to send phone number');
    }
  }

  Future<Response> verifyOtp(String phoneNumber, String otp) async {
    final response = await _dioClient.dio.post('/auth/verification/verify',
        data: {'phone': phoneNumber, 'code': otp});
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
    final response = await _dioClient.dio.get(Endpoints.userAddresses,
        options: Options(contentType: "application/json"));
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
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> addAddress(Map<String, dynamic> addressData) async {
    try {
      return await _dioClient.dio.post(
        Endpoints.addAddress,
        data: addressData,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> updateAddressById(String id) async {
    try {
      return await _dioClient.dio.put(
        Endpoints.updateAddressById.replaceFirst('{id}', id),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> deleteAddressById(String id) async {
    try {
      return await _dioClient.dio.delete(
        Endpoints.deleteAddressById.replaceFirst('{id}', id),
      );
    } catch (e) {
      rethrow;
    }
  }

 Future<Response> getCoupons() async {
    try {
      return await _dioClient.dio.get(
        Endpoints.coupons,
      );
    } catch (e) {
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
    } catch (e) {
      rethrow;
    }
  }
  // Articles
  Future<Response> getArticles(int perPage) async {
    try {
      return await _dioClient.dio.get(
        Endpoints.articles.replaceFirst('{perPage}', perPage.toString()),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getArticleById(String id) async {
    try {
      return await _dioClient.dio.get(
        Endpoints.articleById.replaceFirst('{id}', id),
      );
    } catch (e) {
      rethrow;
    }
  }

  // Authentication
  Future<Response> registeruser(String fullname, String email, String password,
      String birthDate, String phone,String gender) async {
    try {
      final response = await _dioClient.dio.post(
        Endpoints.userSignUp,
        data: {
          'fullName': fullname,
          'email': email,
          'birthday': birthDate,
          'phone': phone,
          'gender' : gender,
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
    } catch (e) {
      log('error $e');
      rethrow;
    }
  }

  Future<Response> signUpUser(Map<String, dynamic> userData) async {
    try {
      return await _dioClient.dio.post(
        Endpoints.userSignUp,
        data: userData,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> subscribe(Map<String, dynamic> subscriptionData) async {
    try {
      return await _dioClient.dio.post(
        Endpoints.subscription,
        data: subscriptionData,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> deleteSubscriptionById(String id) async {
    try {
      return await _dioClient.dio.delete(
        Endpoints.subscriptionById.replaceFirst('{id}', id),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> verifyUser(Map<String, dynamic> verificationData) async {
    try {
      return await _dioClient.dio.post(
        Endpoints.verifyUser,
        data: verificationData,
      );
    } catch (e) {
      rethrow;
    }
  }

  // Branches
  Future<Response> getBranches() async {
    try {
      return await _dioClient.dio.get(Endpoints.branches);
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getBranchDevices(String branchId) async {
    try {
      return await _dioClient.dio.get(
        Endpoints.branchDevices.replaceFirst('{id}', branchId),
      );
    } catch (e) {
      rethrow;
    }
  }

  // Brands
  Future<Response> getBrands() async {
    try {
      return await _dioClient.dio.get(Endpoints.brands);
    } catch (e) {
      rethrow;
    }
  }

  // Cart
  Future<Response> getCarts() async {
    try {
      return await _dioClient.dio.get(Endpoints.carts);
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> deleteCarts() async {
    try {
      return await _dioClient.dio.delete(Endpoints.carts);
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> addToCart(Map<String, dynamic> cartData) async {
    try {
      return await _dioClient.dio.post(
        Endpoints.addCart,
        data: cartData,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> reduceCart(Map<String, dynamic> cartData) async {
    try {
      return await _dioClient.dio.post(
        Endpoints.reduceCart,
        data: cartData,
      );
    } catch (e) {
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
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> deleteCartItemById(String id) async {
    try {
      return await _dioClient.dio.delete(
        Endpoints.cartById.replaceFirst('{id}', id),
      );
    } catch (e) {
      rethrow;
    }
  }

  // Categories
  Future<Response> getCategories({int perPage = 20}) async {
    try {
      return await _dioClient.dio.get(
        Endpoints.getCategories.replaceFirst('{perPage}', perPage.toString()),
      );
    } catch (e) {
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
    } catch (e) {
      rethrow;
    }
  }

  // Contents
  Future<Response> getContentsByKeys(String keys) async {
    try {
      return await _dioClient.dio.get(
        Endpoints.getContentsByKey.replaceFirst('{key}', keys),
      );
    } catch (e) {
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
    } catch (e) {
      rethrow;
    }
  }

  // Orders
  Future<Response> getOrderById(String id) async {
    try {
      return await _dioClient.dio.get(
        Endpoints.getOrderById.replaceFirst('{id}', id),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> cancelOrderById(String id) async {
    try {
      return await _dioClient.dio.patch(
        Endpoints.cancelOrderById.replaceFirst('{id}', id),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> createOrder(Map<String, dynamic> data) async {
    try {
      return await _dioClient.dio.post(
        Endpoints.createOrder,
        data: data,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> processOrder(String id, Map<String, dynamic> data) async {
    try {
      return await _dioClient.dio.put(
        Endpoints.processOrder.replaceFirst('{id}', id),
        data: data,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> payOrder(
    String id,
    String method,
  ) async {
    try {
      return await _dioClient.dio.post(
        Endpoints.payOrder
            .replaceFirst('{id}', id)
            .replaceFirst('{method}', method),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> notifyOrder(String id, Map<String, dynamic> data) async {
    try {
      return await _dioClient.dio.post(
        Endpoints.notifyOrder.replaceFirst('{id}', id),
        data: data,
      );
    } catch (e) {
      rethrow;
    }
  }

  // Partners
  Future<Response> getPartnersUsers() async {
    try {
      return await _dioClient.dio.get(Endpoints.getPartnersUsers);
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> createPartnerForUser(Map<String, dynamic> data) async {
    try {
      return await _dioClient.dio.post(
        Endpoints.createPartnerForUser,
        data: data,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> createPartner(Map<String, dynamic> data) async {
    try {
      return await _dioClient.dio.post(
        Endpoints.createPartner,
        data: data,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> certificatePartner(Map<String, dynamic> data) async {
    try {
      return await _dioClient.dio.post(
        Endpoints.certificatePartner,
        data: data,
      );
    } catch (e) {
      rethrow;
    }
  }

  // Products
  Future<Response> getProductsByCategory(
      String id, int perPage, CancelToken cancelToken) async {
    try {
      return await _dioClient.dio.get(
          Endpoints.getProductsByCategory
              .replaceFirst('{id}', id)
              .replaceFirst('{perPage}', 20.toString())
              .replaceFirst('{page}', perPage.toString()),
          cancelToken: cancelToken);
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getProductsByCategoryWithQuery(String id,
      Map<String, dynamic> queryParams, CancelToken cancelToken) async {
    try {
      return await _dioClient.dio.get(
          Endpoints.getProductsByCategoryWithQuery.replaceFirst('{id}', id),
          queryParameters: queryParams,
          cancelToken: cancelToken);
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getProductById(String id) async {
    try {
      return await _dioClient.dio.get(
        Endpoints.getProductById
            .replaceFirst('{id}', id)
            ,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getProductRatings(String productId) async {
    try {
      return await _dioClient.dio.get(
        Endpoints.getProductRatings.replaceFirst('{product:id}', productId),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> addProductRating(
      String productId, Map<String, dynamic> data) async {
    try {
      return await _dioClient.dio.post(
        Endpoints.addProductRating.replaceFirst('{product:id}', productId),
        data: data,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getFavoriteProducts() async {
    try {
      return await _dioClient.dio.get(Endpoints.getFavoriteProducts);
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> addProductToFavorites(Map<String, dynamic> data) async {
    try {
      return await _dioClient.dio.post(
        Endpoints.addProductToFavorites,
        data: data,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> removeProductFromFavorites(String id) async {
    try {
      return await _dioClient.dio.delete(
        Endpoints.removeProductFromFavorites.replaceFirst('{id}', id),
      );
    } catch (e) {
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
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getTrendNewestProducts() async {
    try {
      return await _dioClient.dio.get(
        Endpoints.getTrendNewestProduct,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getTrendPopularProducts() async {
    try {
      return await _dioClient.dio.get(
        Endpoints.getTrendPopularProduct,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getDiscountedProducts() async {
    try {
      return await _dioClient.dio.get(
        Endpoints.getTrendDiscountProduct,
      );
    } catch (e) {
      rethrow;
    }
  }

  // Professions
  Future<Response> getProfessions() async {
    try {
      return await _dioClient.dio.get(Endpoints.getProfessions);
    } catch (e) {
      rethrow;
    }
  }

  // Regions
  Future<Response> getRegions(int perPage) async {
    try {
      return await _dioClient.dio.get(
        Endpoints.getRegions.replaceFirst('{perPage}', perPage.toString()),
      );
    } catch (e) {
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
    } catch (e) {
      rethrow;
    }
  }

  // Sessions
  Future<Response> clearSession() async {
    try {
      return await _dioClient.dio.post(Endpoints.clearSession);
    } catch (e) {
      rethrow;
    }
  }

  // Spheres
  Future<Response> getSpheres() async {
    try {
      return await _dioClient.dio.get(Endpoints.getSpheres);
    } catch (e) {
      rethrow;
    }
  }

  // User
  Future<Response> getUserOrders() async {
    try {
      return await _dioClient.dio.get(
        Endpoints.getUserOrders,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getUserSettings() async {
    log('getUserSettings');
    try {
      return await _dioClient.dio.get(
        Endpoints.getUserSettings,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> deleteUser() async {
    try {
      return await _dioClient.dio.delete(Endpoints.deleteUser);
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> updateUserSettings(Map<String, dynamic> data) async {
    try {
      return await _dioClient.dio.put(
        Endpoints.updateUserSettings,
        data: data,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> updateUserPassword(Map<String, dynamic> data) async {
    try {
      return await _dioClient.dio.put(
        Endpoints.updateUserPassword,
        data: data,
      );
    } catch (e) {
      rethrow;
    }
  }
}
