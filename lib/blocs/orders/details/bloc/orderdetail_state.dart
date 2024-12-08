import 'package:equatable/equatable.dart';

import '../../../../models/vieworderresponse_model.dart'; // Replace with the path to your model

abstract class OrderDetailState extends Equatable {
  const OrderDetailState();

  @override
  List<Object?> get props => [];
}

class OrderDetailInitial extends OrderDetailState {}

class OrderDetailLoading extends OrderDetailState {}

class OrderDetailLoadingCancle extends OrderDetailLoaded {
  OrderDetailLoadingCancle(super.orderDetail);
}

class OrderDetailLoaded extends OrderDetailState {
  final ViewOrderResponse? orderDetail;

  const OrderDetailLoaded(this.orderDetail);

  @override
  List<Object?> get props => [orderDetail];
}

class OrderDetailError extends OrderDetailState {
  final String error;

  const OrderDetailError(this.error);

  @override
  List<Object?> get props => [error];
}
