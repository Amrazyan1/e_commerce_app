part of 'add_card_bloc_bloc.dart';

sealed class AddCardBlocEvent extends Equatable {
  const AddCardBlocEvent();

  @override
  List<Object> get props => [];
}

class AddCardEvent extends AddCardBlocEvent {
  final String cardNumber;
  final String cardHolder;
  final String expiryDate;
  final String cvv;

  const AddCardEvent({
    required this.cardNumber,
    required this.cardHolder,
    required this.expiryDate,
    required this.cvv,
  });

  @override
  List<Object> get props => [cardNumber, cardHolder, expiryDate, cvv];
}
