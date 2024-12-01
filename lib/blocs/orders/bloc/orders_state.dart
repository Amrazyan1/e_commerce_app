import 'package:equatable/equatable.dart';
import '../../../models/user_orders_model.dart';

abstract class OrdersState extends Equatable {
  const OrdersState();

  @override
  List<Object?> get props => [];
}

class OrdersInitial extends OrdersState {}

class OrdersLoading extends OrdersState {}

class OrdersLoaded extends OrdersState {
  final UserOrdersResponse ordersResponse;

  const OrdersLoaded(this.ordersResponse);

  @override
  List<Object?> get props => [ordersResponse];
}

class OrdersError extends OrdersState {
  final String error;

  const OrdersError(this.error);

  @override
  List<Object?> get props => [error];
}
