import 'dart:developer';

import 'package:e_commerce_app/services/api_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final ApiService _apiService = GetIt.I<ApiService>();

  LoginBloc() : super(LoginInitial()) {
    on<LoginSubmitted>((event, emit) async {
      emit(LoginLoading());
      try {
        final response =
            await _apiService.loginUser(event.username, event.password);
        log(response.data);
        if (response.statusCode == 200) {
          emit(LoginSuccess());
        } else {
          emit(LoginFailure(error: 'Invalid credentials'));
        }
      } catch (e) {
        print(e);
        emit(LoginFailure(error: e.toString()));
      }
    });
  }
}
