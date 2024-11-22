import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models/Product/product_model.dart';

class MainProvider with ChangeNotifier, DiagnosticableTreeMixin {
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

  void addToCart(Product model) {
    cartProducts.add(model);

    notifyListeners();
  }

  void removefromCart(Product model) {
    cartProducts.remove(model);

    notifyListeners();
  }

  List<Product> _cartProducts = [];

  List<Product> get cartProducts => _cartProducts;

  set cartProducts(List<Product> value) {
    _cartProducts = value;
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
