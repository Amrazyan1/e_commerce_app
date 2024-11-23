import '../models/Product/product_model.dart';
import '../models/cart_products_response.dart';

class ProductsService {
  List<CartProductItem> _cartProducts = [];

  List<CartProductItem> get cartProducts => _cartProducts;

  set cartProducts(List<CartProductItem> value) {
    _cartProducts = value;
  }
}
