import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/screens/Card/models/card_model.dart';
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
        final response = await _apiService.addCard();

        emit(AddCardSuccess(data: response.data));
      } catch (error) {
        emit(AddCardError(error.toString()));
      }
    });

    on<GetAllCards>((event, emit) async {
      log('get all cards call');

      emit(AddCardLoading());
      try {
        final response = await _apiService.getAllCards();
        log("All cards: ${response.data}");
        final cardsResponse = CardsResponse.fromJson(jsonDecode(response.data));
        List<CardModel> cards = cardsResponse.data;
        emit(GetAllCardsState(data: cards));
      } catch (error) {
        emit(AddCardError(error.toString()));
      }
    });
  }
}
