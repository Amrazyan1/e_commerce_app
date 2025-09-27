import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/models/product_detail_model.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';

import '../../models/Product/product_model.dart';
import '../../services/api_service.dart';

part 'product_detail_event.dart';
part 'product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  final ApiService _apiService = GetIt.I<ApiService>();

  ProductDetailBloc() : super(ProductDetailInitial()) {
    on<FetchProductDetail>((event, emit) async {
      emit(ProductDetailLoading());
      try {
        final response = await _apiService.getProductById(event.id);
        final data = productDetailModelFromJson(response.data);

        emit(ProductDetailLoaded(data.data!));
      } catch (error) {
        emit(ProductDetailError(error.toString()));
      }
    });
  }
}
