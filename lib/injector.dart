import 'package:e_commerce_app/services/api_service.dart';
import 'package:e_commerce_app/services/dio_client.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void injectGetItServices() {
  // Register DioClient
  getIt.registerLazySingleton<DioClient>(() => DioClient());

  // Register ApiService
  getIt.registerLazySingleton<ApiService>(() => ApiService(getIt<DioClient>()));
}
