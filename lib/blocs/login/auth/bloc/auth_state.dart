part of 'auth_bloc.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthPhoneSent extends AuthState {
  final String phoneNumber;

  AuthPhoneSent(this.phoneNumber);
}

class AuthVerified extends AuthState {}

class AuthApproved extends AuthState {}

class AuthError extends AuthState {
  final String message;

  AuthError(this.message);
}
