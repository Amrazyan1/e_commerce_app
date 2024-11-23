part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class LoadCart extends CartEvent {}

class AddToCart extends CartEvent {
  final String id;

  AddToCart({required this.id});
}

class ReduceFromCart extends CartEvent {
  final String id;

  ReduceFromCart({required this.id});
}

class ChangeCountinCart extends CartEvent {
  final String id;
  final String count;
  ChangeCountinCart({required this.id, required this.count});
}

class RemoveFromCart extends CartEvent {
  final String id;

  RemoveFromCart({required this.id});
}

class ClearCart extends CartEvent {
  ClearCart();
}
