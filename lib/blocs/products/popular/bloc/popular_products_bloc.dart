import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'popular_products_event.dart';
part 'popular_products_state.dart';

class PopularProductsBloc extends Bloc<PopularProductsEvent, PopularProductsState> {
  PopularProductsBloc() : super(PopularProductsInitial()) {
    on<PopularProductsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
