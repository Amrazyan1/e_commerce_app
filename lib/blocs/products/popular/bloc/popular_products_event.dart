part of 'popular_products_bloc.dart';

sealed class PopularProductsEvent extends Equatable {
  const PopularProductsEvent();

  @override
  List<Object> get props => [];
}

class FetchTrendPopularProductsEvent extends PopularProductsEvent {}
