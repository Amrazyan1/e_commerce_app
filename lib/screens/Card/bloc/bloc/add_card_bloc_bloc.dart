import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';

import '../../../../services/api_service.dart';

part 'add_card_bloc_event.dart';
part 'add_card_bloc_state.dart';

class AddCardBlocBloc extends Bloc<AddCardBlocEvent, AddCardBlocState> {
  AddCardBlocBloc() : super(AddCardInitial()) {
    final ApiService _apiService = GetIt.I<ApiService>();

    on<AddCardEvent>((event, emit) async {
      log('register provider call');

      emit(AddCardLoading());
      try {
        final response = await _apiService.addCard({
          "card_data": event.cardHolder,
          "card_data": event.cardNumber,
          "card_data": event.expiryDate,
          "card_data": event.cvv
        });

        emit(AddCardSuccess());
      } catch (error) {
        emit(AddCardError(error.toString()));
      }

      // if (response!.statusCode == 200) {
      // } else {
      //   ErrorAddCard errorAddCard = errorAddCardDataFromJson(response.body);

      //   String errorMsg = 'Cant add card';
      //   if (errorAddCard.data != null) {
      //     if (errorAddCard.data!.errors!.cvc!.isNotEmpty) {
      //       errorMsg = errorAddCard.data!.errors!.cvc![0];
      //     }
      //     if (errorAddCard.data!.errors!.expYear!.isNotEmpty) {
      //       errorMsg = errorAddCard.data!.errors!.expYear![0];
      //     }
      //     if (errorAddCard.data!.errors!.cardHolder!.isNotEmpty) {
      //       errorMsg = errorAddCard.data!.errors!.cardHolder![0];
      //     }
      //     if (errorAddCard.data!.errors!.cardNumber!.isNotEmpty) {
      //       errorMsg = errorAddCard.data!.errors!.cardNumber![0];
      //     }
      //   } else {
      //     errorMsg = errorAddCard.message!;
      //   }
      // }
    });
  }
}
