part of 'category_detail_copy_bloc.dart';

sealed class CategoryDetailCopyState extends Equatable {
  const CategoryDetailCopyState();

  @override
  List<Object> get props => [];
}

final class CategoryDetailCopyInitial extends CategoryDetailCopyState {}

class CategoryDetailCopyLoading extends CategoryDetailCopyState {}

class CategoryDetailCopyLoaded extends CategoryDetailCopyState {
  final List<Product> products;
  final Map<String, dynamic>? filters; // Add filters here

  CategoryDetailCopyLoaded({
    required this.products,
    this.filters,
  });
}

class CategoryDetailCopyError extends CategoryDetailCopyState {
  final String message;

  CategoryDetailCopyError(this.message);
}

class CategoryDetailCopyNoProducts extends CategoryDetailCopyState {}
