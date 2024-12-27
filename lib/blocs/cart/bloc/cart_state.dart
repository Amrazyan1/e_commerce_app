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
  final OrderAble orderable;
  final DeliveryDetails deliveryDetails;
  final List<CartProductItem> cartItems;

  CartLoaded(this.cartItems, this.subtotal, this.discount, this.total,
      this.count, this.orderable, this.deliveryDetails);
}

class CartPlaceOrderStateLoading extends CartLoaded {
  CartPlaceOrderStateLoading(super.cartItems, super.subtotal, super.discount,
      super.total, super.count, super.orderable, super.deliveryDetails);
}

class CartPlaceOrderState extends CartLoaded {
  final ViewOrderData vieworder;
  CartPlaceOrderState(
      super.cartItems,
      super.subtotal,
      super.discount,
      super.total,
      super.count,
      super.orderable,
      super.deliveryDetails,
      this.vieworder);
}

class CartError extends CartState {
  final String message;

  CartError(this.message);
}
