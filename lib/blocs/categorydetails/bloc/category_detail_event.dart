import '../../../models/category_model_real.dart';

abstract class CategoryDetailEvent {}

class FetchCategoryProductsEvent extends CategoryDetailEvent {
  final String id;

  FetchCategoryProductsEvent({required this.id});
}
