import 'package:auto_route/auto_route.dart';
import 'package:e_commerce_app/router/router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        /// routes go here
        AutoRoute(page: EntryPoint.page, path: '/'),
        AutoRoute(page: HomeRoute.page, path: '/home'),
      ];
}
