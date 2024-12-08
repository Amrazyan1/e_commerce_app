import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import '../../../../models/Product/product_model.dart';
import '../../../../services/api_service.dart';
part 'discounted_event.dart';
part 'discounted_state.dart';

class DiscountedBloc extends Bloc<DiscountedBlocEvent, DiscountedBlocState> {
  final ApiService _apiService = GetIt.I<ApiService>();
  List<Product>? discountedProducts;

  DiscountedBloc() : super(DiscountedBlocInitial()) {
    on<FetchDiscountedProductsEvent>(_onFetchDiscountedProducts);
  }

  Future<void> _onFetchDiscountedProducts(
    FetchDiscountedProductsEvent event,
    Emitter<DiscountedBlocState> emit,
  ) async {
    emit(DiscountedBlocLoading());
    try {
      final response = await _apiService.getDiscountedProducts();
      if (response.statusCode == 200) {
        discountedProducts = productModelFromJson(response.data).data!;
        emit(DiscountedBlocLoaded(discountedProducts!));
      } else {
        emit(DiscountedBlocError('Failed to fetch discounted products'));
      }
    } catch (error) {
      emit(DiscountedBlocError(error.toString()));
    }
  }
}
