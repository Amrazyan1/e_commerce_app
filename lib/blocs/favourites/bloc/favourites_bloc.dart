import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import '../../../../models/Product/product_model.dart';
import '../../../../services/api_service.dart';

part 'favourites_event.dart';
part 'favourites_state.dart';

class FavouritesBloc extends Bloc<FavouritesEvent, FavouritesState> {
  final ApiService _apiService = GetIt.I<ApiService>();
  List<Product>? favouriteProducts;

  FavouritesBloc() : super(FavouritesInitial()) {
    on<FetchFavouritesEvent>(_onFetchFavourites);
  }

  Future<void> _onFetchFavourites(
    FetchFavouritesEvent event,
    Emitter<FavouritesState> emit,
  ) async {
    emit(FavouritesLoading());
    try {
      final response = await _apiService.getFavoriteProducts();
      if (response.statusCode == 200) {
        favouriteProducts = productModelFromJson(response.data).data!;
        emit(FavouritesLoaded(favouriteProducts!));
      } else {
        emit(FavouritesError('Failed to fetch favourite products'));
      }
    } catch (error) {
      emit(FavouritesError(error.toString()));
    }
  }
}
