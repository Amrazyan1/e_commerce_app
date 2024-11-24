import 'package:equatable/equatable.dart';

abstract class SettingsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchUserSettingsEvent extends SettingsEvent {}

class SettingsUpdate extends SettingsEvent {
  final String name;
  final String email;
  final String phone;

  SettingsUpdate(
      {required this.name, required this.email, required this.phone});
}
