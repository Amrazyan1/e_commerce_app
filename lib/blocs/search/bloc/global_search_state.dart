part of 'global_search_bloc.dart';

abstract class GlobalSearchState extends Equatable {
  @override
  List<Object?> get props => [];
}

class GlobalSearchInitial extends GlobalSearchState {}

class GlobalSearchLoading extends GlobalSearchState {}

class GlobalSearchLoaded extends GlobalSearchState {
  final GlobalSearchResponse results;

  GlobalSearchLoaded({required this.results});

  @override
  List<Object?> get props => [results];
}

class GlobalSearchError extends GlobalSearchState {
  final String message;

  GlobalSearchError({required this.message});

  @override
  List<Object?> get props => [message];
}
