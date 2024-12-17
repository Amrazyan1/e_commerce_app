part of 'global_search_bloc.dart';

abstract class GlobalSearchEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class PerformGlobalSearch extends GlobalSearchEvent {
  final String keyword;
  final int perPage;

  PerformGlobalSearch({required this.keyword, required this.perPage});

  @override
  List<Object?> get props => [keyword, perPage];
}

class SetSearchInitialEvent extends GlobalSearchEvent {}
