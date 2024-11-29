import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import '../../../../models/Product/product_model.dart';
import '../../../../services/api_service.dart';
import '../../../models/favourites_response.dart';

part 'favourites_event.dart';
part 'favourites_state.dart';

class FavouritesBloc extends Bloc<FavouritesEvent, FavouritesState> {
  final ApiService _apiService = GetIt.I<ApiService>();
  List<Product>? favouriteProducts;

  FavouritesBloc() : super(FavouritesInitial()) {
    on<FetchFavouritesEvent>(_onFetchFavourites);
    on<AddToFavouritesEvent>(_onFavAdded);
    on<RemoveFavouritesEvent>(_onFavRemoved);
  }
  Future<void> _onFavRemoved(
    RemoveFavouritesEvent event,
    Emitter<FavouritesState> emit,
  ) async {
    try {
      final response =
          await _apiService.removeProductFromFavorites(event.productId);
      if (response.statusCode == 200) {
        log('favourites removed');
        add(FetchFavouritesEvent());
        // favouriteProducts = productModelFromJson(response.data).data!;
      } else {}
    } catch (error) {
      log('add fav error $error');
    }
  }

  Future<void> _onFavAdded(
    AddToFavouritesEvent event,
    Emitter<FavouritesState> emit,
  ) async {
    try {
      final response = await _apiService.addProductToFavorites({
        'products': ['${event.productId}']
      });
      if (response.statusCode == 200) {
        favouriteProducts = productModelFromJson(response.data).data!;
      } else {}
    } catch (error) {
      log('add fav error $error');
    }
  }

  Future<void> _onFetchFavourites(
    FetchFavouritesEvent event,
    Emitter<FavouritesState> emit,
  ) async {
    emit(FavouritesLoading());
    try {
      final response = await _apiService.getFavoriteProducts();
      if (response.statusCode == 200) {
        favouriteProducts =
            favoritesResponseFromJson(response.data).data!.favorites;
        emit(FavouritesLoaded(favouriteProducts!));
      } else {
        emit(FavouritesError('Failed to fetch favourite products'));
      }
    } catch (error) {
      emit(FavouritesError(error.toString()));
    }
  }
}
