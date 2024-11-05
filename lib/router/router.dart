import 'package:auto_route/auto_route.dart';
import 'package:e_commerce_app/router/router.gr.dart';
import 'package:e_commerce_app/screens/profile/views/fake_proifle_screen.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        /// routes go here
        AutoRoute(page: EntryPoint.page, path: '/', initial: true, children: [
          AutoRoute(page: HomeRoute.page, path: 'home'),
          AutoRoute(page: DiscoverRoute.page, path: 'discover'),
          AutoRoute(page: FavoriteRoute.page, path: 'favorites'),
          AutoRoute(page: CartRoute.page, path: 'cart'),
          AutoRoute(page: EmptyRouter.page, path: 'profile', children: [
            AutoRoute(page: ProfileRoute.page, path: ''),
            AutoRoute(page: AboutUsRoute.page, path: 'about-us'),
            AutoRoute(page: CouponsRoute.page, path: 'couponsRoute'),
            AutoRoute(
                page: DeliveryAddressRoute.page, path: 'aeliveryAddressRoute'),
            AutoRoute(page: MydetailsRoute.page, path: 'mydetailsRoute'),
            AutoRoute(
                page: PaymentmethodsRoute.page, path: 'aaymentmethodsRoute'),
          ]),
        ]),

        AutoRoute(page: FakeProifleRoute.page, path: '/FakeProifleRoute'),

        AutoRoute(page: DiscoverDetailsRoute.page, path: '/discoverdetail'),
      ];
}
