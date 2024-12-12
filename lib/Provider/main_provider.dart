import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:e_commerce_app/models/banner_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../components/Banners/M/banner_m_style_1.dart';
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

  bool _isLoadingMore = false;
  bool get isLoadingMore => _isLoadingMore;

  set isLoadingMore(bool value) {
    _isLoadingMore = value;
    log('isloading oreeee $_isLoadingMore');
    notifyListeners();
  }

  bool _isProcessOrder = false;
  bool get isProcessOrder => _isProcessOrder;

  set isProcessOrder(bool value) {
    _isProcessOrder = value;
    log('isloading oreeee $_isProcessOrder');
    notifyListeners();
  }

  bool _isAvailable = false;

  bool get isAvailable {
    return _isAvailable;
  }

  set isAvailable(bool value) {
    _isAvailable = value;
    notifyListeners();
  }

  String _categoryName = '';

  String get categoryName => _categoryName;

  set categoryName(String value) {
    _categoryName = value;
    notifyListeners();
  }
  late Timer _timer = Timer.periodic(const Duration(seconds: 4), (Timer timer) {
          if (selectedIndex < offers.length - 1) {
            selectedIndex++;
          } else {
            selectedIndex = 0;
          }

          pageController.animateToPage(
            selectedIndex,
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeOutCubic,
          );
        });

bool _forceUpdatebanners = false;

  bool get forceUpdatebanners {
    return _forceUpdatebanners;
  }
  set forceUpdatebanners(bool value) {
    _forceUpdatebanners = value;
    offers.clear();
    bannerFiveImage = '';
    bannerOneImage= '';
getOfferBanners('thirdBanner');
getOfferBannerss('secondBanner');
getOfferBannersCarousel();
  }
  void getOfferBanners(String bannername) async {
    final ApiService _apiService = GetIt.I<ApiService>();
    final response = await _apiService.getContentsByKeys(bannername);
    final data = bannerModelResponseFromJson(response.data);
    if (data.data != null && data.data!.isNotEmpty) {
        bannerFiveImage = data.data!.first.src;
    }
  }
  void getOfferBannerss(String bannername) async {
    final ApiService _apiService = GetIt.I<ApiService>();
    final response = await _apiService.getContentsByKeys(bannername);
    final data = bannerModelResponseFromJson(response.data);
    if (data.data != null && data.data!.isNotEmpty) {
        bannerOneImage = data.data!.first.src;
    }
  }
  List _offers = [];

  List get offers => _offers;

  set offers(List value) {
    _offers = value;
    notifyListeners();
  }
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  set selectedIndex(int value) {
    _selectedIndex = value;
    notifyListeners();
  }
  late PageController pageController =PageController(initialPage: 0);

void getOfferBannersCarousel() async {
    final ApiService _apiService = GetIt.I<ApiService>();
    final response = await _apiService.getContentsByKeys('firstBanner');
    final data = bannerModelResponseFromJson(response.data);
    if (data.data != null && data.data!.isNotEmpty) {
      offers.clear();
      for (var element in data.data!) {
          offers.add(BannerMStyle1(
            press: () {},
            text: element.description ?? '',
            image: element.src,
          ));
        }
        offers = offers; //fake call
        _timer.cancel();
         _timer = Timer.periodic(const Duration(seconds: 4), (Timer timer) {
          if (selectedIndex < offers.length - 1) {
            selectedIndex++;
          } else {
            selectedIndex = 0;
          }

          pageController.animateToPage(
            selectedIndex,
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeOutCubic,
          );
        });
    }    
  }
  String? _bannerFiveImage ='';

  String? get bannerFiveImage => _bannerFiveImage;

  set bannerFiveImage(String? value) {
    _bannerFiveImage = value;
    notifyListeners();

  }

  String? _bannerOneImage ='';

  String? get bannerOneImage => _bannerOneImage;

  set bannerOneImage(String? value) {
    _bannerOneImage = value;
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
        Map<String, dynamic> parsedJson = jsonDecode(response.data);
        int count = parsedJson['data']['count'];
        String total = parsedJson['data']['total'];
        CartProductItem cartProduct =
            CartProductItem(count: count, total: total);
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
      if (response.statusCode == 200) {
        Map<String, dynamic> parsedJson = jsonDecode(response.data);
        int count = parsedJson['data']['count'];
        String total = parsedJson['data']['total'];
        CartProductItem cartProduct =
            CartProductItem(count: count, total: total);
        print('aaaaaaaaaa' + cartProduct.toString());
        return cartProduct;
      } else {
        return null;
      }
    } catch (e) {
      log('Error on changeCountCartByProductId product ${e.toString()}');
      return null;
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
