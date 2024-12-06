part of 'category_detail_copy_bloc.dart';

sealed class CategoryDetailCopyEvent extends Equatable {
  const CategoryDetailCopyEvent();

  @override
  List<Object> get props => [];
}

class FetchCategoryProductsEventCopy extends CategoryDetailCopyEvent {
  final String id;
  final int page;

  FetchCategoryProductsEventCopy({required this.id, required this.page});
}
