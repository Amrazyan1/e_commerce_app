import 'package:e_commerce_app/models/Product/product_model.dart';
import 'package:e_commerce_app/models/category_model_real.dart';
import 'package:equatable/equatable.dart';

sealed class CategoriesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CategoriesInitial extends CategoriesState {}

class CategoriesLoading extends CategoriesState {}

class CategoriesLoaded extends CategoriesState {
  final List<Category> categories;
  final List<Product> products;
  CategoriesLoaded({required this.categories, this.products = const []});

  @override
  List<Object?> get props => [categories, products];
}

class CategoriesError extends CategoriesState {
  final String error;

  CategoriesError(this.error);

  @override
  List<Object?> get props => [error];
}
