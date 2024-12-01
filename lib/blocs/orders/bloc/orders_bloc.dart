import 'package:e_commerce_app/services/api_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../../models/user_orders_model.dart';
import 'orders_event.dart';
import 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final ApiService apiService = GetIt.I<ApiService>();

  OrdersBloc() : super(OrdersInitial()) {
    on<FetchOrders>(_onFetchOrders);
  }

  Future<void> _onFetchOrders(
      FetchOrders event, Emitter<OrdersState> emit) async {
    emit(OrdersLoading());
    try {
      final response = await apiService.getUserOrders();
      final userOrdersResponse = userOrdersResponseFromJson(response.data);
      emit(OrdersLoaded(userOrdersResponse));
    } catch (error) {
      emit(OrdersError(error.toString()));
    }
  }
}
