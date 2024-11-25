part of 'favourites_bloc.dart';

abstract class FavouritesEvent extends Equatable {
  const FavouritesEvent();

  @override
  List<Object> get props => [];
}

class FetchFavouritesEvent extends FavouritesEvent {}

class AddToFavouritesEvent extends FavouritesEvent {
  final String productId;

  AddToFavouritesEvent(this.productId);
}
