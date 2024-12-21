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
  Map<String, dynamic>? currentFilters;

  CancelToken? _cancelToken =
      CancelToken(); // CancelToken for HTTP cancellation
  CategoryDetailCopyBloc() : super(CategoryDetailCopyInitial()) {
    on<FetchCategoryProductsEventCopy>((event, emit) async {
      log('Start loadddd FetchCategoryProductsEvent');

      try {
        {
          var page = event.page;
          if (categoryId.isNotEmpty && categoryId != event.id) {
            page = 0;
          }
          categoryId = event.id;
          cancelLoadProducts();
          if (page == 0) {
            pagination = 1;
            allProducts.clear();
            emit(CategoryDetailCopyLoaded(products: allProducts));
            // return;
          }
          if (event.id.isEmpty) {
            return;
          }
          if (pagination == 1) {
            emit(CategoryDetailCopyLoading());
          }
          Map<String, dynamic> queryParameters = {
            'perPage': 20.toString(),
            'page': pagination.toString(),
          };
          if (event.filters != null && event.filters!.isNotEmpty) {
            event.filters!.forEach((key, value) {
              if (key == 'price' && value is Map<String, String>) {
                // Add price ranges explicitly
                value.forEach((rangeKey, rangeValue) {
                  queryParameters['price[$rangeKey]'] = rangeValue;
                });
              } else if (value is List) {
                // Handle dynamic list-based filters
                queryParameters[key] = value;
              }
            });
          }

          final response = await _apiService.getProductsByCategoryWithQuery(
              event.id, queryParameters, _cancelToken!);

          if (response.statusCode == 200) {
            pagination++;

            var responseData =
                productsByCategroyIdResponseFromJson(response.data);
            var products = responseData.data!.products;
            print(responseData.data!.filters);
            allProducts.addAll(products.data!);

            emit(CategoryDetailCopyLoaded(
                products: allProducts, filters: responseData.data!.filters));
          } else {
            emit(CategoryDetailCopyError('Failed to fetch subcategories'));
          }
        }
      } catch (e) {
        log(e.toString());
        emit(CategoryDetailCopyError(e.toString()));
      }
    });

    on<UpdateFiltersEventCopy>((event, emit) async {
      // Update current filters with the new filters
      currentFilters = event.filters;

      // Recall FetchCategoryProductsEventCopy with updated filters
      add(FetchCategoryProductsEventCopy(
        id: categoryId,
        page: 0,
        filters: currentFilters,
      ));
    });
  }
  void cancelLoadProducts() {
    _cancelToken?.cancel();
    _cancelToken = CancelToken();
  }
}
