part of 'add_card_bloc_bloc.dart';

sealed class AddCardBlocState extends Equatable {
  const AddCardBlocState();

  @override
  List<Object> get props => [];
}

class AddCardInitial extends AddCardBlocState {}

class AddCardLoading extends AddCardBlocState {}

class AddCardSuccess extends AddCardBlocState {}

class AddCardError extends AddCardBlocState {
  final String message;

  const AddCardError(this.message);

  @override
  List<Object> get props => [message];
}
