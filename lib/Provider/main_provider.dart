import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../models/Product/product_model.dart';
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

  double _detialButtonPriceSum = 0;

  double get detailButtonPriceSum => _detialButtonPriceSum;

  set detailButtonPriceSum(double value) {
    _detialButtonPriceSum = value;
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

  void addToCartById(String id) async {
    try {
      var response = await _apiService.addToCart({"id": id, "count": 1});

      // _productsService.cartProducts.add(model);
      notifyListeners();
    } catch (e) {
      log('Error on addToCart product ${e.toString()}');
    }
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
      var response = await _apiService.reduceCart({"id": model.id, "count": 1});

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
