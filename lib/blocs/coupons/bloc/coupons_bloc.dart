import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';

import '../../../endpoints/endpoints.dart';
import '../../../services/api_service.dart';

part 'coupons_event.dart';
part 'coupons_state.dart';

class CouponsBloc extends Bloc<CouponsEvent, CouponsState> {
  final ApiService _apiService = GetIt.I<ApiService>();

  CouponsBloc() : super(CouponsInitial()) {
    on<FetchCoupons>(_onFetchCoupons);
        on<AddCouponEvent>(_onCouponAdded);

  }

  Future<void> _onFetchCoupons(FetchCoupons event, Emitter<CouponsState> emit) async {
    emit(CouponsLoading());
    try {
      final  response = await _apiService.getCoupons();
      if (response.statusCode == 200) {
        emit(CouponsLoaded(response.data));
      } else {
        emit(CouponsError('Failed to load coupons. Status code: ${response.statusCode}'));
      }
    } catch (e) {
      emit(CouponsError('Failed to load coupons: $e'));
    }
  }
  Future<void> _onCouponAdded(AddCouponEvent event, Emitter<CouponsState> emit) async {
    emit(CouponsLoading());
    try {
      final  response = await _apiService.addCoupon(event.promoCode);
      if (response.statusCode == 200) {
        emit(CouponsLoaded(response.data));
      } else {
        emit(CouponsError('Failed to load coupons. Status code: ${response.statusCode}'));
      }
    } catch (e) {
      emit(CouponsError('Failed to load coupons: $e'));
    }
  }
}
