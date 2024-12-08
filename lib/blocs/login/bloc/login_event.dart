import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginSubmitted extends LoginEvent {
  final String username;
  final String email;
  final String phone;
  final String password;
  final String birthDate;

  LoginSubmitted(
      {required this.username,
      required this.email,
      required this.phone,
      required this.password,
      required this.birthDate});

  @override
  List<Object?> get props => [username, password];
}
