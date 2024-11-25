import '../../../models/Product/product_model.dart';

abstract class CategoryDetailState {}

class CategoryDetailInitial extends CategoryDetailState {}

class CategoryDetailLoading extends CategoryDetailState {}

class CategoryDetailLoaded extends CategoryDetailState {
  final List<ProductModel> subcategories;

  CategoryDetailLoaded({required this.subcategories});
}

class CategoryDetailError extends CategoryDetailState {
  final String message;

  CategoryDetailError(this.message);
}

class CategoryDetailNoProducts extends CategoryDetailState {}
