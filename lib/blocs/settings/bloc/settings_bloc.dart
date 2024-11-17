import 'dart:convert';
import 'dart:developer';

import 'package:e_commerce_app/blocs/settings/bloc/settings_event.dart';
import 'package:e_commerce_app/blocs/settings/bloc/settings_state.dart';
import 'package:e_commerce_app/models/Settings/settings_model.dart';
import 'package:e_commerce_app/services/api_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final ApiService _apiService = GetIt.I<ApiService>();

  SettingsBloc() : super(SettingsInitial()) {
    on<FetchUserSettingsEvent>((event, emit) async {
      emit(SettingsLoading());
      try {
        final response = await _apiService.getUserSettings();

        log('${response.data}');
        // log('${json.encode(response.data['data'])}');
        if (response.statusCode == 200) {
          final settings = settingsModelFromJson(response.data);
          emit(SettingsLoaded(settings));
        } else {
          emit(SettingsError('Failed to fetch settings'));
        }
      } catch (e) {
        emit(SettingsError(e.toString()));
      }
    });
  }
}
