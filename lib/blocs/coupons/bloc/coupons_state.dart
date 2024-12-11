part of 'coupons_bloc.dart';

sealed class CouponsState extends Equatable {
  const CouponsState();
  
  @override
  List<Object> get props => [];
}

final class CouponsInitial extends CouponsState {}
class CouponsLoading extends CouponsState {}

class CouponsLoaded extends CouponsState {
  final List<CouponData> coupons;

  CouponsLoaded(this.coupons);
}

class CouponsError extends CouponsLoaded {
  final String message;
  final List<CouponData> coupons;

  CouponsError(this.message,this.coupons) : super(coupons);
}