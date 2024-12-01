import 'dart:developer';

import 'package:e_commerce_app/models/category_model_real.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/Product/product_model.dart';
import '../../../models/productby_categoryid.dart';
import '../../../services/api_service.dart';
import 'categories_event.dart';
import 'categories_state.dart';
import 'package:get_it/get_it.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final ApiService _apiService = GetIt.I<ApiService>();

  CategoriesBloc() : super(CategoriesInitial()) {
    on<FetchCategoriesEvent>((event, emit) async {
      emit(CategoriesLoading());
      try {
        final response = await _apiService.getCategories(perPage: 30);
        log('$response');
        if (response.statusCode == 200) {
          emit(CategoriesLoaded(
              categories: categoryModelFromJson(response.data).data!));
        } else {
          emit(CategoriesError('Failed to fetch categories'));
        }
      } catch (e) {
        emit(CategoriesError(e.toString()));
      }
    });

    on<FetchSubcategories>((event, emit) async {
      emit(CategoriesLoading());
      try {
        final subcategories = event.parentCategory.subcategories ?? [];
        emit(CategoriesLoaded(categories: subcategories));

        // if (subcategories.isEmpty) {
        //   if (event.parentCategory.productsCount! > 0) {
        //     final response = await _apiService
        //         .getProductsByCategory(event.parentCategory.id!);

        //     var sgaag = productsByCategroyIdResponseFromJson(response.data);
        //     var products = sgaag.data!.products!;

        //     emit(CategoriesLoaded(
        //       categories: [],
        //       products: products.data!,
        //     ));
        //   } else {
        //     emit(CategoriesLoaded(
        //       categories: [],
        //     ));
        //   }
        // } else {
        // }
      } catch (e) {
        emit(CategoriesError(e.toString()));
      }
    });
  }
}
