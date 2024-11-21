part of 'popular_products_bloc.dart';

sealed class PopularProductsState extends Equatable {
  const PopularProductsState();

  @override
  List<Object> get props => [];
}

final class PopularProductsInitial extends PopularProductsState {}

class PopularProductsLoading extends PopularProductsState {}

class PopularProductsLoaded extends PopularProductsState {
  final List<Product> products; // Replace `Product` with your model
  PopularProductsLoaded(this.products);
}

class PopularProductsError extends PopularProductsState {
  final String message;
  PopularProductsError(this.message);
}
