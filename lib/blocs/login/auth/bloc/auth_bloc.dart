import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../services/api_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final ApiService _apiService = GetIt.I<ApiService>();

  AuthBloc() : super(AuthInitial()) {
    on<SendPhoneEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        await _apiService.sendPhoneNumber(event.phoneNumber);
        emit(AuthPhoneSent(event.phoneNumber));
      } catch (e) {
        emit(AuthError('Failed to send phone number'));
      }
    });

    on<VerifyOtpEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final response =
            await _apiService.verifyOtp(event.phoneNumber, event.otp);
        log(response.data);
        emit(AuthVerified());
      } catch (e) {
        emit(AuthError('OTP verification failed'));
      }
    });
  }
}
