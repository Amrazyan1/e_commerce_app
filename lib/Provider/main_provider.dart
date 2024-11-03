import 'package:e_commerce_app/models/product_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MainProvider with ChangeNotifier, DiagnosticableTreeMixin {
  void fakeNotifyListener() {
    notifyListeners();
  }

  late ProductModel _currentProductModel;

  ProductModel get currentProductModel => _currentProductModel;

  set currentProductModel(ProductModel value) {
    _currentProductModel = value;
    _detialButtonPriceSum = value.price;
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

  void addToFavourites(ProductModel? model) {
    if (model == null) {}
    model = currentProductModel;

    model.isFavourite = !model.isFavourite;
    if (model.isFavourite) {
      favouriteProducts.add(model);
    } else {
      favouriteProducts.remove(model);
    }
    notifyListeners();
  }

  List<ProductModel> _favouriteProducts = [];

  List<ProductModel> get favouriteProducts => _favouriteProducts;

  set favouriteProducts(List<ProductModel> value) {
    _favouriteProducts = value;
  }

  /// Makes `categoryName` readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('categoryName', categoryName));
  }
}
