part of 'favourites_bloc.dart';

abstract class FavouritesState extends Equatable {
  const FavouritesState();

  @override
  List<Object?> get props => [];
}

class FavouritesInitial extends FavouritesState {}

class FavouritesLoading extends FavouritesState {}

class FavouritesLoaded extends FavouritesState {
  final List<Product> favouriteProducts;

  const FavouritesLoaded(this.favouriteProducts);

  @override
  List<Object?> get props => [favouriteProducts];
}

class FavouritesError extends FavouritesState {
  final String message;

  const FavouritesError(this.message);

  @override
  List<Object?> get props => [message];
}
