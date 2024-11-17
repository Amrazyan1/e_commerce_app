import 'package:e_commerce_app/models/Settings/settings_model.dart';
import 'package:equatable/equatable.dart';

abstract class SettingsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SettingsInitial extends SettingsState {}

class SettingsLoading extends SettingsState {}

class SettingsLoaded extends SettingsState {
  final SettingsModel settings;

  SettingsLoaded(this.settings);

  @override
  List<Object?> get props => [settings];
}

class SettingsError extends SettingsState {
  final String error;

  SettingsError(this.error);

  @override
  List<Object?> get props => [error];
}
