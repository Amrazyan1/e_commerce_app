// api_service.dart
import 'package:e_commerce_app/endpoints/endpoints.dart';

import 'dio_client.dart';
import 'package:dio/dio.dart';

class ApiService {
  final DioClient _dioClient;

  ApiService(this._dioClient);

  // User Addresses
  Future<Response> getUserAddresses(int perPage) async {
    try {
      return await _dioClient.dio.get(
        Endpoints.userAddresses.replaceFirst('{perPage}', perPage.toString()),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> setDefaultAddress(String id) async {
    try {
      return await _dioClient.dio.post(
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

  Future<Response> getAddressById(String id) async {
    try {
      return await _dioClient.dio.get(
        Endpoints.getAddressById.replaceFirst('{id}', id),
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
  Future<Response> loginUser(String email, String password) async {
    try {
      return await _dioClient.dio.post(
        Endpoints.userLogin,
        data: {'email': email, 'password': password},
      );
    } catch (e) {
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

  Future<Response> getSubscriptionById(String id) async {
    try {
      return await _dioClient.dio.get(
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

  Future<Response> getCartById(String id) async {
    try {
      return await _dioClient.dio.get(
        Endpoints.cartById.replaceFirst('{id}', id),
      );
    } catch (e) {
      rethrow;
    }
  }
}
