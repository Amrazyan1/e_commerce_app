import '../../../models/category_model_real.dart';

abstract class CategoryDetailEvent {}

class FetchCategoryProductsEvent extends CategoryDetailEvent {
  final String id;
  final int page;

  FetchCategoryProductsEvent({required this.id, required this.page});
}
