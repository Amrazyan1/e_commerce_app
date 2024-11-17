import 'package:e_commerce_app/services/api_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final ApiService apiService;

  LoginBloc({required this.apiService}) : super(LoginInitial()) {
    on<LoginSubmitted>((event, emit) async {
      emit(LoginLoading());
      try {
        final response =
            await apiService.loginUser(event.username, event.password);
        if (response.statusCode == 200) {
          emit(LoginSuccess());
        } else {
          emit(LoginFailure(error: 'Invalid credentials'));
        }
      } catch (e) {
        print(e);
        emit(LoginFailure(error: e.toString()));
      }
    });
  }
}
