part of 'trend_new_products_bloc.dart';

sealed class TrendNewProductsState extends Equatable {
  const TrendNewProductsState();

  @override
  List<Object> get props => [];
}

class TrendNewProductsInitial extends TrendNewProductsState {}

class TrendNewProductsLoading extends TrendNewProductsState {}

class TrendNewProductsLoaded extends TrendNewProductsState {
  final List<Product> products; // Replace `Product` with your model
  TrendNewProductsLoaded(this.products);
}

class TrendNewProductsError extends TrendNewProductsState {
  final String message;
  TrendNewProductsError(this.message);
}
