import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/Product/product_model.dart';
import '../../../models/productby_categoryid.dart';
import '../../../services/api_service.dart';
import 'category_detail_event.dart';
import 'category_detail_state.dart';
import 'package:get_it/get_it.dart';

class CategoryDetailBloc
    extends Bloc<CategoryDetailEvent, CategoryDetailState> {
  final ApiService _apiService = GetIt.I<ApiService>();

  CategoryDetailBloc() : super(CategoryDetailInitial()) {
    on<FetchCategoryProductsEvent>((event, emit) async {
      emit(CategoryDetailLoading());
      try {
        {
          final response = await _apiService.getProductsByCategory(event.id!);

          if (response.statusCode == 200) {
            var sgaag = productsByCategroyIdResponseFromJson(response.data);
            var products = sgaag.data!.products!;
            emit(CategoryDetailLoaded(products: products.data!));
          } else {
            emit(CategoryDetailError('Failed to fetch subcategories'));
          }
        }
      } catch (e) {
        log(e.toString());
        emit(CategoryDetailError(e.toString()));
      }
    });
  }
}
