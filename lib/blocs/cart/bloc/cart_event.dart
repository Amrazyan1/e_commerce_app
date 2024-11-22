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

class RemoveFromCart extends CartEvent {
  final String id;

  RemoveFromCart({required this.id});
}
