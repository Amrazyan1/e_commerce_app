part of 'coupons_bloc.dart';

sealed class CouponsState extends Equatable {
  const CouponsState();
  
  @override
  List<Object> get props => [];
}

final class CouponsInitial extends CouponsState {}
class CouponsLoading extends CouponsState {}

class CouponsLoaded extends CouponsState {
  final List<dynamic> coupons;

  CouponsLoaded(this.coupons);
}

class CouponsError extends CouponsState {
  final String message;

  CouponsError(this.message);
}