import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import '../../../../models/Product/product_model.dart';
import '../../../../services/api_service.dart';
part 'popular_products_event.dart';
part 'popular_products_state.dart';

class PopularProductsBloc
    extends Bloc<PopularProductsEvent, PopularProductsState> {
  final ApiService _apiService = GetIt.I<ApiService>();
  List<Product>? products;

  PopularProductsBloc() : super(PopularProductsInitial()) {
    on<FetchTrendPopularProductsEvent>(_onFetchTrendNewProducts);
  }
  Future<void> _onFetchTrendNewProducts(
    FetchTrendPopularProductsEvent event,
    Emitter<PopularProductsState> emit,
  ) async {
    emit(PopularProductsLoading());
    try {
      final response = await _apiService.getTrendPopularProducts();
      if (response.statusCode == 200) {
        products = productModelFromJson(response.data).data!;
        emit(PopularProductsLoaded(products!));
      } else {
        emit(PopularProductsError('Failed to fetch trends'));
      }
    } catch (error) {
      emit(PopularProductsError(error.toString()));
    }
  }
}
