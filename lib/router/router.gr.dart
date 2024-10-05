// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:e_commerce_app/entry_point.dart' as _i3;
import 'package:e_commerce_app/screens/Cart/views/cart_screen.dart' as _i1;
import 'package:e_commerce_app/screens/Discover/views/discover_screen.dart'
    as _i2;
import 'package:e_commerce_app/screens/Favorites/views/favorite_screen.dart'
    as _i4;
import 'package:e_commerce_app/screens/Home/views/home_screen.dart' as _i5;
import 'package:e_commerce_app/screens/profile/views/profile_screen.dart'
    as _i6;

/// generated route for
/// [_i1.CartScreen]
class CartRoute extends _i7.PageRouteInfo<void> {
  const CartRoute({List<_i7.PageRouteInfo>? children})
      : super(
          CartRoute.name,
          initialChildren: children,
        );

  static const String name = 'CartRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i1.CartScreen();
    },
  );
}

/// generated route for
/// [_i2.DiscoverScreen]
class DiscoverRoute extends _i7.PageRouteInfo<void> {
  const DiscoverRoute({List<_i7.PageRouteInfo>? children})
      : super(
          DiscoverRoute.name,
          initialChildren: children,
        );

  static const String name = 'DiscoverRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i2.DiscoverScreen();
    },
  );
}

/// generated route for
/// [_i3.EntryPoint]
class EntryPoint extends _i7.PageRouteInfo<void> {
  const EntryPoint({List<_i7.PageRouteInfo>? children})
      : super(
          EntryPoint.name,
          initialChildren: children,
        );

  static const String name = 'EntryPoint';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i3.EntryPoint();
    },
  );
}

/// generated route for
/// [_i4.FavoriteScreen]
class FavoriteRoute extends _i7.PageRouteInfo<void> {
  const FavoriteRoute({List<_i7.PageRouteInfo>? children})
      : super(
          FavoriteRoute.name,
          initialChildren: children,
        );

  static const String name = 'FavoriteRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i4.FavoriteScreen();
    },
  );
}

/// generated route for
/// [_i5.HomeScreen]
class HomeRoute extends _i7.PageRouteInfo<void> {
  const HomeRoute({List<_i7.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i5.HomeScreen();
    },
  );
}

/// generated route for
/// [_i6.ProfileScreen]
class ProfileRoute extends _i7.PageRouteInfo<void> {
  const ProfileRoute({List<_i7.PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i6.ProfileScreen();
    },
  );
}
