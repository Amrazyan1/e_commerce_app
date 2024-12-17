import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';

import '../../../models/global_search.dart';
import '../../../services/api_service.dart';

part 'global_search_event.dart';
part 'global_search_state.dart';

class GlobalSearchBloc extends Bloc<GlobalSearchEvent, GlobalSearchState> {
  final ApiService _apiService = GetIt.I<ApiService>();

  GlobalSearchBloc() : super(GlobalSearchInitial()) {
    on<PerformGlobalSearch>((event, emit) async {
      emit(GlobalSearchLoading());
      try {
        // Make the API call
        final response = await _apiService.searchCatalog(
          event.keyword,
          event.perPage,
        );

        if (response.statusCode == 200) {
          // Deserialize response
          final searchResults = globalSearchResponseFromJson(response.data);

          emit(GlobalSearchLoaded(results: searchResults));
        } else {
          emit(GlobalSearchError(message: 'Failed to perform search'));
        }
      } catch (e) {
        log('Error during search: $e');
        emit(GlobalSearchError(message: e.toString()));
      }
    });
    on<SetSearchInitialEvent>((event, emit) async {
      emit(GlobalSearchInitial());
    });
  }
}
