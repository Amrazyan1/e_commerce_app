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
          path: '/',
          // initial: true,
        ),
        AutoRoute(
          page: AuthorizationRoute.page,
          path: '/auth',
          // initial: true,
        ),
        AutoRoute(
          page: OtpRoute.page,
          path: '/otp',
        ),
        AutoRoute(
          page: LoginRoute.page,
          path: '/login',
        ),

        AutoRoute(
            page: EntryPoint.page,
            initial: true,
            path: '/entry',
            children: [
              AutoRoute(page: EmptyHomeRouter.page, path: 'home', children: [
                AutoRoute(page: HomeRoute.page, path: ''),
                AutoRoute(page: BonusCarRoute.page, path: 'bonuscard'),
                AutoRoute(
                    page: ProductDetailsRoute.page, path: 'productdetailspage'),
              ]),
              AutoRoute(
                  page: EmptyDiscoverRouter.page,
                  path: 'discover',
                  children: [
                    AutoRoute(
                        page: DiscoverRoute.page, initial: true, path: ''),
                    AutoRoute(
                        page: DiscoverDetailsRoute.page,
                        path: 'discoverdetail'),
                  ]),
              AutoRoute(page: FavoriteRoute.page, path: 'favorites'),
              AutoRoute(page: CartRoute.page, path: 'cart', children: [
                // AutoRoute(
                //     page: ProductDetailsRoute.page,
                //     path: 'productdetailspagediscover'),
              ]),
              AutoRoute(page: EmptyRouter.page, path: 'profile', children: [
                AutoRoute(page: ProfileRoute.page, path: ''),
                AutoRoute(page: AboutUsRoute.page, path: 'about-us'),
                AutoRoute(page: CouponsRoute.page, path: 'couponsRoute'),
                AutoRoute(
                    page: DeliveryAddresseRoute.page,
                    path: 'deliveryAddressRoute'),
                AutoRoute(
                    page: DeliveryAddressNew.page,
                    path: 'deliveryAddressNewRoute'),
                AutoRoute(
                    page: PaymentmethodsRoute.page,
                    path: 'paymentmethodsRoute'),
                AutoRoute(page: OrdersRoute.page, path: 'ordersRoute'),
                AutoRoute(page: OrderInfoRoute.page, path: 'ordersInfoRoute'),
                AutoRoute(page: MyDetailsRoute.page, path: 'mydetailsRoute'),
                AutoRoute(
                    page: DeliveryAddressInfoRoute.page, path: 'addressinfo'),
                AutoRoute(page: FakeProifleRoute.page, path: 'helproute'),
              ]),
            ]),
        AutoRoute(page: AboutUsRoute.page, path: '/abhgs'),
        AutoRoute(
            page: DeliveryAddressNew.page,
            path: '/deliveryAddressNewRouteFromLogin'),
        AutoRoute(page: FakeProifleRoute.page, path: '/FakeProifleRoute'),
      ];
}
