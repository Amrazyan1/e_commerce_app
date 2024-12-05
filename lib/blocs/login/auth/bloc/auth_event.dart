part of 'auth_bloc.dart';

abstract class AuthEvent {}

class SendPhoneEvent extends AuthEvent {
  final String phoneNumber;

  SendPhoneEvent(this.phoneNumber);
}

class VerifyOtpEvent extends AuthEvent {
  final String phoneNumber;
  final String otp;

  VerifyOtpEvent(this.phoneNumber, this.otp);
}
