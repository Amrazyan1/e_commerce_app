import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../models/otp_response_model.dart';
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
        if (e is DioException && e.response?.statusCode == 422) {
          // Show a specific error message for 422
          emit(AuthError("Invalid phone number format."));
        } else {
          emit(AuthError(e.toString()));
        }
      }
    });

    on<VerifyOtpEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final response =
            await _apiService.verifyOtp(event.phoneNumber, event.otp);
        final respData = otpModelResponseFromJson(response.data);
        if (respData.data?.user != null) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString(
              'auth_token', respData.data!.token!.plainTextToken!);
          await prefs.setString(
              'bonus_code', respData.data!.user?.bonus_code ?? '');
          emit(AuthApproved());
        } else {
          emit(AuthVerified());
        }
      } catch (e) {
        emit(AuthError('OTP verification failed'));
      }
    });
  }
}
