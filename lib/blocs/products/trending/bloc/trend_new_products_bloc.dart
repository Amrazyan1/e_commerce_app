import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';

import '../../../../models/Product/product_model.dart';
import '../../../../services/api_service.dart';

part 'trend_new_products_event.dart';
part 'trend_new_products_state.dart';

class TrendNewProductsBloc
    extends Bloc<TrendNewProductsEvent, TrendNewProductsState> {
  final ApiService _apiService = GetIt.I<ApiService>();
  List<Product>? products;
  TrendNewProductsBloc() : super(TrendNewProductsInitial()) {
    on<FetchTrendNewProductsEvent>(_onFetchTrendNewProducts);
  }

  Future<void> _onFetchTrendNewProducts(
    FetchTrendNewProductsEvent event,
    Emitter<TrendNewProductsState> emit,
  ) async {
    if (products != null) {
      return;
    }
    emit(TrendNewProductsLoading());
    try {
      final response = await _apiService.getTrendNewestProducts();
      if (response.statusCode == 200) {
        products = productModelFromJson(response.data).data!;
        emit(TrendNewProductsLoaded(products!));
      } else {
        emit(TrendNewProductsError('Failed to fetch trends'));
      }
    } catch (error) {
      emit(TrendNewProductsError(error.toString()));
    }
  }
}
