import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/services/api_service.dart';
import 'package:equatable/equatable.dart';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../../models/Product/product_model.dart';
import '../../../../../models/productby_categoryid.dart';
part 'category_detail_copy_event.dart';
part 'category_detail_copy_state.dart';

class CategoryDetailCopyBloc
    extends Bloc<CategoryDetailCopyEvent, CategoryDetailCopyState> {
  final ApiService _apiService = GetIt.I<ApiService>();

  int pagination = 1;
  String categoryId = '';
  List<Product> allProducts = [];
  CancelToken? _cancelToken =
      CancelToken(); // CancelToken for HTTP cancellation
  CategoryDetailCopyBloc() : super(CategoryDetailCopyInitial()) {
    on<FetchCategoryProductsEventCopy>((event, emit) async {
      log('Start loadddd FetchCategoryProductsEvent');
      emit(CategoryDetailCopyLoading());
      try {
        {
          cancelLoadProducts();
          if (event.page == 0) {
            pagination = 1;
            allProducts.clear();
            // emit(CategoryDetailCopyLoaded(products: allProducts));
          }
          final response = await _apiService.getProductsByCategory(
              event.id!, pagination, _cancelToken!);

          if (response.statusCode == 200) {
            pagination++;

            var sgaag = productsByCategroyIdResponseFromJson(response.data);
            var products = sgaag.data!.products!;

            allProducts.addAll(products.data!);

            emit(CategoryDetailCopyLoaded(products: allProducts));
          } else {
            emit(CategoryDetailCopyError('Failed to fetch subcategories'));
          }
        }
      } catch (e) {
        log(e.toString());
        emit(CategoryDetailCopyError(e.toString()));
      }
    });
  }
  void cancelLoadProducts() {
    _cancelToken?.cancel();
    _cancelToken = CancelToken();
  }
}
