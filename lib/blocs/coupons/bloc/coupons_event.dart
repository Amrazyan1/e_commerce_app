part of 'coupons_bloc.dart';

sealed class CouponsEvent extends Equatable {
  const CouponsEvent();

  @override
  List<Object> get props => [];
}
class FetchCoupons extends CouponsEvent {}