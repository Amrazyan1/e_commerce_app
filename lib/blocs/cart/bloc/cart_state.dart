part of 'cart_bloc.dart';

sealed class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final String? subtotal;
  final String? discount;
  final String? total;
  final int? count;
  final List<CartProductItem> cartItems;

  CartLoaded(
      this.cartItems, this.subtotal, this.discount, this.total, this.count);
}

class CartError extends CartState {
  final String message;

  CartError(this.message);
}
