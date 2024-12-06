import 'package:auto_route/auto_route.dart';
import 'package:e_commerce_app/router/router.gr.dart';
import 'package:e_commerce_app/screens/profile/views/fake_proifle_screen.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        /// routes go here
        ///
        AutoRoute(
          page: SplashViewRoute.page,
          path: '/ssss',
          // initial: true,
        ),
        AutoRoute(
          page: AuthorizationRoute.page,
          path: '/as',
        ),
        AutoRoute(
          page: OtpRoute.page,
          path: '/otp',
        ),
        AutoRoute(
          page: LoginRoute.page,
          path: '/',
          initial: true,
        ),

        AutoRoute(page: EntryPoint.page, path: '/entry', children: [
          AutoRoute(page: EmptyHomeRouter.page, path: 'home', children: [
            AutoRoute(page: HomeRoute.page, path: ''),
            AutoRoute(page: BonusCarRoute.page, path: 'bonuscard'),
          ]),
          AutoRoute(page: DiscoverRoute.page, path: 'discover'),
          AutoRoute(page: FavoriteRoute.page, path: 'favorites'),
          AutoRoute(page: CartRoute.page, path: 'cart'),
          AutoRoute(page: EmptyRouter.page, path: 'profile', children: [
            AutoRoute(page: ProfileRoute.page, path: ''),
            AutoRoute(page: AboutUsRoute.page, path: 'about-us'),
            AutoRoute(page: CouponsRoute.page, path: 'couponsRoute'),
            AutoRoute(
                page: DeliveryAddresseRoute.page, path: 'deliveryAddressRoute'),
            AutoRoute(
                page: DeliveryAddressNew.page, path: 'deliveryAddressNewRoute'),
            AutoRoute(
                page: PaymentmethodsRoute.page, path: 'paymentmethodsRoute'),
            AutoRoute(page: OrdersRoute.page, path: 'ordersRoute'),
            AutoRoute(page: OrderInfoRoute.page, path: 'ordersInfoRoute'),
            AutoRoute(page: MyDetailsRoute.page, path: 'mydetailsRoute'),
            AutoRoute(page: DeliveryAddressInfoRoute.page, path: 'addressinfo'),
          ]),
        ]),
        AutoRoute(page: DiscoverDetailsRoute.page, path: '/discoverdetail'),

        AutoRoute(page: FakeProifleRoute.page, path: '/FakeProifleRoute'),
      ];
}
