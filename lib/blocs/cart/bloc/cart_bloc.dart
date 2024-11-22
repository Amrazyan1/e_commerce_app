import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/models/Product/product_model.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';

import '../../../services/api_service.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final ApiService _apiService = GetIt.I<ApiService>();

  CartBloc() : super(CartInitial()) {
    on<LoadCart>((event, emit) async {
      try {
        emit(CartLoading());
        // Fetch cart data logic (if needed)
        List<Product> cartItems = []; // Replace with fetched data
        emit(CartLoaded(cartItems));
      } catch (e) {
        emit(CartError(e.toString()));
      }
    });

    on<AddToCart>((event, emit) async {
      try {
        emit(CartLoading());
        await _apiService.addToCart({"id": event.id, "count": 1});
        List<Product> cartItems = []; // Replace with fetched data
        emit(CartLoaded(cartItems));
      } catch (e) {
        emit(CartError(e.toString()));
      }
    });

    on<RemoveFromCart>((event, emit) async {
      try {
        emit(CartLoading());
        await _apiService.reduceCart({"id": event.id, "count": 1});
        // Re-fetch cart data
        emit(CartLoaded([])); // Replace with fetched data
      } catch (e) {
        emit(CartError(e.toString()));
      }
    });
  }
}
