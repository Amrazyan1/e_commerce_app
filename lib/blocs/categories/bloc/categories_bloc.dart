import 'dart:developer';

import 'package:e_commerce_app/models/category_model_real.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        final response = await _apiService.getCategories(perPage: 10);
        log('$response');
        if (response.statusCode == 200) {
          emit(CategoriesLoaded(categoryModelFromJson(response.data).data!));
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
        if (subcategories.isEmpty) {
          emit(CategoriesLoaded([])); // No subcategories
        } else {
          emit(CategoriesLoaded(subcategories));
        }
      } catch (e) {
        emit(CategoriesError(e.toString()));
      }
    });
  }
}
