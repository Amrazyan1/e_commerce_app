part of 'discounted_bloc.dart';

sealed class DiscountedBlocEvent extends Equatable {
  const DiscountedBlocEvent();

  @override
  List<Object> get props => [];
}

class FetchDiscountedProductsEvent extends DiscountedBlocEvent {}
