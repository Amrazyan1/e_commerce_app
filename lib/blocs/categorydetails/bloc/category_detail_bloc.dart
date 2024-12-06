import 'dart:developer';
import 'package:dio/dio.dart';
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

  int pagination = 1;
  String categoryId = '';
  List<Product> allProducts = [];
  CancelToken? _cancelToken =
      CancelToken(); // CancelToken for HTTP cancellation

  CategoryDetailBloc() : super(CategoryDetailInitial()) {
    on<FetchCategoryProductsEvent>((event, emit) async {
      log('Start loadddd FetchCategoryProductsEvent');
      // emit(CategoryDetailLoading());
      try {
        {
          cancelLoadProducts();
          if (event.page == 0) {
            pagination = 1;

            allProducts.clear();
            log('CLEAR CategoryDetailLoaded');
            emit(CategoryDetailLoaded(products: allProducts));
            return;
          }
          if (event.id.isEmpty) {
            return;
          }
          final response = await _apiService.getProductsByCategory(
              event.id!, pagination, _cancelToken!);

          if (response.statusCode == 200) {
            pagination++;

            var responseData =
                productsByCategroyIdResponseFromJson(response.data);
            var products = responseData.data!.products;
            print(responseData.data!.filters);
            allProducts.addAll(products.data!);

            emit(CategoryDetailLoaded(
                products: allProducts, filters: responseData.data!.filters));
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

  void cancelLoadProducts() {
    _cancelToken?.cancel();
    _cancelToken = CancelToken();
  }
}
