import 'package:e_commerce_app/models/category_model_real.dart';
import 'package:equatable/equatable.dart';

sealed class CategoriesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchCategoriesEvent extends CategoriesEvent {}

class FetchSubcategories extends CategoriesEvent {
  final Category parentCategory;

  FetchSubcategories(this.parentCategory);

  @override
  List<Object?> get props => [parentCategory];
}
