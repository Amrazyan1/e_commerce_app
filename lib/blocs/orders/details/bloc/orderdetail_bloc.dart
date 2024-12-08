import 'dart:developer';

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
    on<CancelOrderEvent>(_onCancelOrderDetail);
  }
  Future<void> _onCancelOrderDetail(
      CancelOrderEvent event, Emitter<OrderDetailState> emit) async {
    emit(OrderDetailLoadingCancle((state as OrderDetailLoaded).orderDetail));
    try {
      final response = await apiService.cancelOrderById(event.orderId);
      if (response.statusCode == 200) {
        emit(const OrderDetailLoaded(null));
      }
    } catch (error) {
      log(error.toString());
      emit(OrderDetailError(error.toString()));
    }
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
