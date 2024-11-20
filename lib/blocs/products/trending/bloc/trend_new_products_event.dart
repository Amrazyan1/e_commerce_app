part of 'trend_new_products_bloc.dart';

sealed class TrendNewProductsEvent extends Equatable {
  const TrendNewProductsEvent();

  @override
  List<Object> get props => [];
}

class FetchTrendNewProductsEvent extends TrendNewProductsEvent {}
