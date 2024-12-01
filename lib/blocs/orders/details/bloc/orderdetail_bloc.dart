import 'package:e_commerce_app/blocs/orders/details/bloc/orderdetail_event.dart';
import 'package:e_commerce_app/blocs/orders/details/bloc/orderdetail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/services/api_service.dart'; // Replace with your ApiService import
import 'package:get_it/get_it.dart';

import '../../../../models/vieworderresponse_model.dart';

class OrderDetailBloc extends Bloc<OrderDetailEvent, OrderDetailState> {
  final ApiService apiService = GetIt.I<ApiService>();

  OrderDetailBloc() : super(OrderDetailInitial()) {
    on<FetchOrderDetail>(_onFetchOrderDetail);
  }

  Future<void> _onFetchOrderDetail(
      FetchOrderDetail event, Emitter<OrderDetailState> emit) async {
    emit(OrderDetailLoading());
    try {
      final response = await apiService.getOrderById(event.orderId);

      final viewOrderData = viewOrderResponseFromJson(response.data);

      emit(OrderDetailLoaded(viewOrderData));
    } catch (error) {
      emit(OrderDetailError(error.toString()));
    }
  }
}
