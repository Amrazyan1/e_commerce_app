part of 'add_card_bloc_bloc.dart';

sealed class AddCardBlocEvent extends Equatable {
  const AddCardBlocEvent();

  @override
  List<Object> get props => [];
}

class AddCardEvent extends AddCardBlocEvent {}

class GetAllCards extends AddCardBlocEvent {}
