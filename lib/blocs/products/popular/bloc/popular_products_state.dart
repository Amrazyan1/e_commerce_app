part of 'popular_products_bloc.dart';

sealed class PopularProductsState extends Equatable {
  const PopularProductsState();
  
  @override
  List<Object> get props => [];
}

final class PopularProductsInitial extends PopularProductsState {}
