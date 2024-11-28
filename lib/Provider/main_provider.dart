import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../models/Product/product_model.dart';
import '../models/cart_products_response.dart';
import '../services/api_service.dart';
import '../services/products_service.dart';

class MainProvider with ChangeNotifier, DiagnosticableTreeMixin {
  final ApiService _apiService = GetIt.I<ApiService>();
  final ProductsService _productsService = GetIt.I<ProductsService>();

  void fakeNotifyListener() {
    notifyListeners();
  }

  late Product _currentProductModel;

  Product get currentProductModel => _currentProductModel;

  set currentProductModel(Product value) {
    _currentProductModel = value;
    // _detialButtonPriceSum = value.price;
    notifyListeners();
  }

  String _categoryName = '';

  String get categoryName => _categoryName;

  set categoryName(String value) {
    _categoryName = value;
    notifyListeners();
  }

  void addToFavourites(Product? model) {
    model ??= currentProductModel;

    // model.isFavourite = !model.isFavourite;
    // if (model.isFavourite) {
    //   favouriteProducts.add(model);
    // } else {
    //   favouriteProducts.remove(model);
    // }
    // notifyListeners();
  }

  Future<CartProductItem?> addToCartById(String id) async {
    try {
      var response = await _apiService.addToCart({"id": id, "count": 1});
      // _productsService.cartProducts.add(model);
      if (response.statusCode == 200) {
        var cartProduct = CartProductItem.fromJson(response.data);
        notifyListeners();
        return cartProduct;
      }
    } catch (e) {
      log('Error on addToCart product ${e.toString()}');
      return null;
    }
    return null;
  }

  Future<CartProductItem?> changeCountCartByProductId(
      String id, int count) async {
    try {
      var response = await _apiService.changeCart({"id": id, "count": count});
      // _productsService.cartProducts.add(model);
      if (response.statusCode == 200) {
        var cartProduct = CartProductItem.fromJson(response.data);
        notifyListeners();
        return cartProduct;
      }
    } catch (e) {
      log('Error on addToCart product ${e.toString()}');
      return null;
    }
    return null;
  }

  void addToCart(Product model) async {
    try {
      var response = await _apiService.addToCart({"id": model.id, "count": 1});

      // _productsService.cartProducts.add(model);
      notifyListeners();
    } catch (e) {
      log('Error on addToCart product ${e.toString()}');
    }
  }

  void removefromCart(Product model) async {
    try {
      var response = await _apiService.deleteCartItemById(model.id);

      _productsService.cartProducts.remove(model);

      notifyListeners();
    } catch (e) {
      log('Error on removefromCart product ${e.toString()}');
    }
  }

  List<Product> _favouriteProducts = [];

  List<Product> get favouriteProducts => _favouriteProducts;

  set favouriteProducts(List<Product> value) {
    _favouriteProducts = value;
  }

  /// Makes `categoryName` readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('categoryName', categoryName));
  }
}
