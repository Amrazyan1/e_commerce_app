part of 'category_detail_copy_bloc.dart';

sealed class CategoryDetailCopyEvent extends Equatable {
  const CategoryDetailCopyEvent();

  @override
  List<Object?> get props => [];
}

class FetchCategoryProductsEventCopy extends CategoryDetailCopyEvent {
  final String id;
  final int page;
  Map<String, dynamic>? filters;

  FetchCategoryProductsEventCopy(
      {required this.id, required this.page, this.filters});

  @override
  List<Object?> get props => [id, page, filters];
}

class UpdateFiltersEventCopy extends CategoryDetailCopyEvent {
  final Map<String, dynamic> filters;

  const UpdateFiltersEventCopy({required this.filters});

  @override
  List<Object?> get props => [filters];
}
