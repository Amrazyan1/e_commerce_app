import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/models/Product/product_model.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';

import '../../../models/cart_products_response.dart';
import '../../../services/api_service.dart';
import '../../../services/products_service.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final ApiService _apiService = GetIt.I<ApiService>();
  final ProductsService _productsService = GetIt.I<ProductsService>();

  List<CartProductItem>? products;

  CartBloc() : super(CartInitial()) {
    on<LoadCart>((event, emit) async {
      try {
        emit(CartLoading());
        // Fetch cart data logic (if needed)
        final response = await _apiService.getCarts();
        CartResponseData responseData =
            cartProductsResponseFromJson(response.data).data!;
        products = responseData.list;
        _productsService.cartProducts = products ?? [];
        emit(CartLoaded(products ?? [], responseData.subtotal,
            responseData.discount, responseData.total, responseData.count));
      } catch (e) {
        emit(CartError(e.toString()));
      }
    });

    on<AddToCart>((event, emit) async {
      try {
        emit(CartLoading());
        final response =
            await _apiService.addToCart({"id": event.id, "count": 1});
        CartResponseData responseData =
            cartProductsResponseFromJson(response.data).data!;
        products = responseData.list;
        _productsService.cartProducts = products ?? [];
        emit(CartLoaded(products ?? [], responseData.subtotal,
            responseData.discount, responseData.total, responseData.count));
      } catch (e) {
        emit(CartError(e.toString()));
      }
    });

    on<ReduceFromCart>((event, emit) async {
      try {
        emit(CartLoading());
        final response =
            await _apiService.reduceCart({"id": event.id, "count": 1});
        CartResponseData responseData =
            cartProductsResponseFromJson(response.data).data!;
        products = responseData.list;
        _productsService.cartProducts = products ?? [];
        emit(CartLoaded(products ?? [], responseData.subtotal,
            responseData.discount, responseData.total, responseData.count));
      } catch (e) {
        emit(CartError(e.toString()));
      }
    });

    on<ChangeCountinCart>((event, emit) async {
      try {
        emit(CartLoading());
        final response = await _apiService
            .changeCart({"id": event.id, "count": event.count});
        CartResponseData responseData =
            cartProductsResponseFromJson(response.data).data!;
        products = responseData.list;
        _productsService.cartProducts = products ?? [];
        emit(CartLoaded(products ?? [], responseData.subtotal,
            responseData.discount, responseData.total, responseData.count));
      } catch (e) {
        emit(CartError(e.toString()));
      }
    });

    on<RemoveFromCart>((event, emit) async {
      try {
        emit(CartLoading());
        final response = await _apiService.deleteCartItemById(event.id);
        CartResponseData responseData =
            cartProductsResponseFromJson(response.data).data!;
        products = responseData.list;
        _productsService.cartProducts = products ?? [];
        emit(CartLoaded(products ?? [], responseData.subtotal,
            responseData.discount, responseData.total, responseData.count));
      } catch (e) {
        emit(CartError(e.toString()));
      }
    });

    on<ClearCart>((event, emit) async {
      try {
        emit(CartLoading());
        final response = await _apiService.deleteCarts();
        CartResponseData responseData =
            cartProductsResponseFromJson(response.data).data!;
        products = responseData.list;
        _productsService.cartProducts = products ?? [];
        emit(CartLoaded(products ?? [], responseData.subtotal,
            responseData.discount, responseData.total, responseData.count));
      } catch (e) {
        emit(CartError(e.toString()));
      }
    });
  }
}
