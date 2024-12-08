// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i25;
import 'package:e_commerce_app/entry_point.dart' as _i13;
import 'package:e_commerce_app/router/EmptyForHomePage.dart' as _i11;
import 'package:e_commerce_app/router/EmptyRouterPage.dart' as _i12;
import 'package:e_commerce_app/screens/bonuscard_screen.dart' as _i3;
import 'package:e_commerce_app/screens/Cart/views/cart_screen.dart' as _i4;
import 'package:e_commerce_app/screens/delivery_address_info.dart' as _i6;
import 'package:e_commerce_app/screens/Discover/views/discover_details_screen.dart'
    as _i9;
import 'package:e_commerce_app/screens/Discover/views/discover_screen.dart'
    as _i10;
import 'package:e_commerce_app/screens/Favorites/views/favorite_screen.dart'
    as _i15;
import 'package:e_commerce_app/screens/Home/views/home_screen.dart' as _i16;
import 'package:e_commerce_app/screens/Login/auth_screen.dart' as _i2;
import 'package:e_commerce_app/screens/Login/login_screen.dart' as _i17;
import 'package:e_commerce_app/screens/Login/otp_screen.dart' as _i21;
import 'package:e_commerce_app/screens/order_info_screen.dart' as _i19;
import 'package:e_commerce_app/screens/orders_screen.dart' as _i20;
import 'package:e_commerce_app/screens/profile/views/about_screen.dart' as _i1;
import 'package:e_commerce_app/screens/profile/views/coupons_screen.dart'
    as _i5;
import 'package:e_commerce_app/screens/profile/views/delivery_address_new.dart'
    as _i7;
import 'package:e_commerce_app/screens/profile/views/delivery_address_screen.dart'
    as _i8;
import 'package:e_commerce_app/screens/profile/views/fake_proifle_screen.dart'
    as _i14;
import 'package:e_commerce_app/screens/profile/views/mydetails_screen.dart'
    as _i18;
import 'package:e_commerce_app/screens/profile/views/paymentmethods_screen.dart'
    as _i22;
import 'package:e_commerce_app/screens/profile/views/profile_screen.dart'
    as _i23;
import 'package:e_commerce_app/screens/Splash/splash_view.dart' as _i24;
import 'package:flutter/material.dart' as _i26;

/// generated route for
/// [_i1.AboutUsScreen]
class AboutUsRoute extends _i25.PageRouteInfo<void> {
  const AboutUsRoute({List<_i25.PageRouteInfo>? children})
      : super(
          AboutUsRoute.name,
          initialChildren: children,
        );

  static const String name = 'AboutUsRoute';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      return const _i1.AboutUsScreen();
    },
  );
}

/// generated route for
/// [_i2.AuthorizationScreen]
class AuthorizationRoute extends _i25.PageRouteInfo<void> {
  const AuthorizationRoute({List<_i25.PageRouteInfo>? children})
      : super(
          AuthorizationRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthorizationRoute';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      return _i2.AuthorizationScreen();
    },
  );
}

/// generated route for
/// [_i3.BonusCarScreen]
class BonusCarRoute extends _i25.PageRouteInfo<void> {
  const BonusCarRoute({List<_i25.PageRouteInfo>? children})
      : super(
          BonusCarRoute.name,
          initialChildren: children,
        );

  static const String name = 'BonusCarRoute';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      return const _i3.BonusCarScreen();
    },
  );
}

/// generated route for
/// [_i4.CartScreen]
class CartRoute extends _i25.PageRouteInfo<void> {
  const CartRoute({List<_i25.PageRouteInfo>? children})
      : super(
          CartRoute.name,
          initialChildren: children,
        );

  static const String name = 'CartRoute';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      return const _i4.CartScreen();
    },
  );
}

/// generated route for
/// [_i5.CouponsScreen]
class CouponsRoute extends _i25.PageRouteInfo<void> {
  const CouponsRoute({List<_i25.PageRouteInfo>? children})
      : super(
          CouponsRoute.name,
          initialChildren: children,
        );

  static const String name = 'CouponsRoute';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      return const _i5.CouponsScreen();
    },
  );
}

/// generated route for
/// [_i6.DeliveryAddressInfoScreen]
class DeliveryAddressInfoRoute extends _i25.PageRouteInfo<void> {
  const DeliveryAddressInfoRoute({List<_i25.PageRouteInfo>? children})
      : super(
          DeliveryAddressInfoRoute.name,
          initialChildren: children,
        );

  static const String name = 'DeliveryAddressInfoRoute';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      return const _i6.DeliveryAddressInfoScreen();
    },
  );
}

/// generated route for
/// [_i7.DeliveryAddressNew]
class DeliveryAddressNew extends _i25.PageRouteInfo<DeliveryAddressNewArgs> {
  DeliveryAddressNew({
    _i26.Key? key,
    bool fromLogin = false,
    List<_i25.PageRouteInfo>? children,
  }) : super(
          DeliveryAddressNew.name,
          args: DeliveryAddressNewArgs(
            key: key,
            fromLogin: fromLogin,
          ),
          initialChildren: children,
        );

  static const String name = 'DeliveryAddressNew';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<DeliveryAddressNewArgs>(
          orElse: () => const DeliveryAddressNewArgs());
      return _i7.DeliveryAddressNew(
        key: args.key,
        fromLogin: args.fromLogin,
      );
    },
  );
}

class DeliveryAddressNewArgs {
  const DeliveryAddressNewArgs({
    this.key,
    this.fromLogin = false,
  });

  final _i26.Key? key;

  final bool fromLogin;

  @override
  String toString() {
    return 'DeliveryAddressNewArgs{key: $key, fromLogin: $fromLogin}';
  }
}

/// generated route for
/// [_i8.DeliveryAddresseScreen]
class DeliveryAddresseRoute extends _i25.PageRouteInfo<void> {
  const DeliveryAddresseRoute({List<_i25.PageRouteInfo>? children})
      : super(
          DeliveryAddresseRoute.name,
          initialChildren: children,
        );

  static const String name = 'DeliveryAddresseRoute';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      return const _i8.DeliveryAddresseScreen();
    },
  );
}

/// generated route for
/// [_i9.DiscoverDetailsScreen]
class DiscoverDetailsRoute extends _i25.PageRouteInfo<void> {
  const DiscoverDetailsRoute({List<_i25.PageRouteInfo>? children})
      : super(
          DiscoverDetailsRoute.name,
          initialChildren: children,
        );

  static const String name = 'DiscoverDetailsRoute';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      return const _i9.DiscoverDetailsScreen();
    },
  );
}

/// generated route for
/// [_i10.DiscoverScreen]
class DiscoverRoute extends _i25.PageRouteInfo<void> {
  const DiscoverRoute({List<_i25.PageRouteInfo>? children})
      : super(
          DiscoverRoute.name,
          initialChildren: children,
        );

  static const String name = 'DiscoverRoute';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      return const _i10.DiscoverScreen();
    },
  );
}

/// generated route for
/// [_i11.EmptyHomeRouterPage]
class EmptyHomeRouter extends _i25.PageRouteInfo<void> {
  const EmptyHomeRouter({List<_i25.PageRouteInfo>? children})
      : super(
          EmptyHomeRouter.name,
          initialChildren: children,
        );

  static const String name = 'EmptyHomeRouter';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      return const _i11.EmptyHomeRouterPage();
    },
  );
}

/// generated route for
/// [_i12.EmptyRouterPage]
class EmptyRouter extends _i25.PageRouteInfo<void> {
  const EmptyRouter({List<_i25.PageRouteInfo>? children})
      : super(
          EmptyRouter.name,
          initialChildren: children,
        );

  static const String name = 'EmptyRouter';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      return const _i12.EmptyRouterPage();
    },
  );
}

/// generated route for
/// [_i13.EntryPoint]
class EntryPoint extends _i25.PageRouteInfo<void> {
  const EntryPoint({List<_i25.PageRouteInfo>? children})
      : super(
          EntryPoint.name,
          initialChildren: children,
        );

  static const String name = 'EntryPoint';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      return const _i13.EntryPoint();
    },
  );
}

/// generated route for
/// [_i14.FakeProifleScreen]
class FakeProifleRoute extends _i25.PageRouteInfo<FakeProifleRouteArgs> {
  FakeProifleRoute({
    _i26.Key? key,
    required String pageName,
    List<_i25.PageRouteInfo>? children,
  }) : super(
          FakeProifleRoute.name,
          args: FakeProifleRouteArgs(
            key: key,
            pageName: pageName,
          ),
          initialChildren: children,
        );

  static const String name = 'FakeProifleRoute';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<FakeProifleRouteArgs>();
      return _i14.FakeProifleScreen(
        key: args.key,
        pageName: args.pageName,
      );
    },
  );
}

class FakeProifleRouteArgs {
  const FakeProifleRouteArgs({
    this.key,
    required this.pageName,
  });

  final _i26.Key? key;

  final String pageName;

  @override
  String toString() {
    return 'FakeProifleRouteArgs{key: $key, pageName: $pageName}';
  }
}

/// generated route for
/// [_i15.FavoriteScreen]
class FavoriteRoute extends _i25.PageRouteInfo<void> {
  const FavoriteRoute({List<_i25.PageRouteInfo>? children})
      : super(
          FavoriteRoute.name,
          initialChildren: children,
        );

  static const String name = 'FavoriteRoute';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      return const _i15.FavoriteScreen();
    },
  );
}

/// generated route for
/// [_i16.HomeScreen]
class HomeRoute extends _i25.PageRouteInfo<void> {
  const HomeRoute({List<_i25.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      return const _i16.HomeScreen();
    },
  );
}

/// generated route for
/// [_i17.LoginPage]
class LoginRoute extends _i25.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({
    required String phoneNumber,
    List<_i25.PageRouteInfo>? children,
  }) : super(
          LoginRoute.name,
          args: LoginRouteArgs(phoneNumber: phoneNumber),
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<LoginRouteArgs>();
      return _i17.LoginPage(phoneNumber: args.phoneNumber);
    },
  );
}

class LoginRouteArgs {
  const LoginRouteArgs({required this.phoneNumber});

  final String phoneNumber;

  @override
  String toString() {
    return 'LoginRouteArgs{phoneNumber: $phoneNumber}';
  }
}

/// generated route for
/// [_i18.MyDetailsScreen]
class MyDetailsRoute extends _i25.PageRouteInfo<void> {
  const MyDetailsRoute({List<_i25.PageRouteInfo>? children})
      : super(
          MyDetailsRoute.name,
          initialChildren: children,
        );

  static const String name = 'MyDetailsRoute';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      return const _i18.MyDetailsScreen();
    },
  );
}

/// generated route for
/// [_i19.OrderInfoScreen]
class OrderInfoRoute extends _i25.PageRouteInfo<void> {
  const OrderInfoRoute({List<_i25.PageRouteInfo>? children})
      : super(
          OrderInfoRoute.name,
          initialChildren: children,
        );

  static const String name = 'OrderInfoRoute';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      return const _i19.OrderInfoScreen();
    },
  );
}

/// generated route for
/// [_i20.OrdersScreen]
class OrdersRoute extends _i25.PageRouteInfo<void> {
  const OrdersRoute({List<_i25.PageRouteInfo>? children})
      : super(
          OrdersRoute.name,
          initialChildren: children,
        );

  static const String name = 'OrdersRoute';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      return const _i20.OrdersScreen();
    },
  );
}

/// generated route for
/// [_i21.OtpScreen]
class OtpRoute extends _i25.PageRouteInfo<OtpRouteArgs> {
  OtpRoute({
    required String phoneNumber,
    List<_i25.PageRouteInfo>? children,
  }) : super(
          OtpRoute.name,
          args: OtpRouteArgs(phoneNumber: phoneNumber),
          initialChildren: children,
        );

  static const String name = 'OtpRoute';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<OtpRouteArgs>();
      return _i21.OtpScreen(phoneNumber: args.phoneNumber);
    },
  );
}

class OtpRouteArgs {
  const OtpRouteArgs({required this.phoneNumber});

  final String phoneNumber;

  @override
  String toString() {
    return 'OtpRouteArgs{phoneNumber: $phoneNumber}';
  }
}

/// generated route for
/// [_i22.PaymentmethodsScreen]
class PaymentmethodsRoute extends _i25.PageRouteInfo<void> {
  const PaymentmethodsRoute({List<_i25.PageRouteInfo>? children})
      : super(
          PaymentmethodsRoute.name,
          initialChildren: children,
        );

  static const String name = 'PaymentmethodsRoute';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      return const _i22.PaymentmethodsScreen();
    },
  );
}

/// generated route for
/// [_i23.ProfileScreen]
class ProfileRoute extends _i25.PageRouteInfo<void> {
  const ProfileRoute({List<_i25.PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      return const _i23.ProfileScreen();
    },
  );
}

/// generated route for
/// [_i24.SplashViewScreen]
class SplashViewRoute extends _i25.PageRouteInfo<void> {
  const SplashViewRoute({List<_i25.PageRouteInfo>? children})
      : super(
          SplashViewRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashViewRoute';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      return const _i24.SplashViewScreen();
    },
  );
}
