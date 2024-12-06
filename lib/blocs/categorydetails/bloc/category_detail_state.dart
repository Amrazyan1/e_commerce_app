import '../../../models/Product/product_model.dart';

abstract class CategoryDetailState {}

class CategoryDetailInitial extends CategoryDetailState {}

class CategoryDetailLoading extends CategoryDetailState {}

class CategoryDetailLoaded extends CategoryDetailState {
  final List<Product> products;
  final Map<String, dynamic>? filters; // Add filters here

  CategoryDetailLoaded({
    required this.products,
    this.filters,
  });
}

class CategoryDetailError extends CategoryDetailState {
  final String message;

  CategoryDetailError(this.message);
}

class CategoryDetailNoProducts extends CategoryDetailState {}
