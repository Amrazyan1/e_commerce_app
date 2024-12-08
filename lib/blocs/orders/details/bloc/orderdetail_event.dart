import 'package:equatable/equatable.dart';

abstract class OrderDetailEvent extends Equatable {
  const OrderDetailEvent();

  @override
  List<Object?> get props => [];
}

class FetchOrderDetail extends OrderDetailEvent {
  final String orderId;

  const FetchOrderDetail(this.orderId);

  @override
  List<Object?> get props => [orderId];
}

class CancelOrderEvent extends OrderDetailEvent {
  final String orderId;
  const CancelOrderEvent(this.orderId);
}
