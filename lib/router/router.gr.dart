// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i9;
import 'package:e_commerce_app/entry_point.dart' as _i4;
import 'package:e_commerce_app/screens/Cart/views/cart_screen.dart' as _i1;
import 'package:e_commerce_app/screens/Discover/views/discover_details_screen.dart'
    as _i2;
import 'package:e_commerce_app/screens/Discover/views/discover_screen.dart'
    as _i3;
import 'package:e_commerce_app/screens/Favorites/views/favorite_screen.dart'
    as _i6;
import 'package:e_commerce_app/screens/Home/views/home_screen.dart' as _i7;
import 'package:e_commerce_app/screens/profile/views/fake_proifle_screen.dart'
    as _i5;
import 'package:e_commerce_app/screens/profile/views/profile_screen.dart'
    as _i8;
import 'package:flutter/material.dart' as _i10;

/// generated route for
/// [_i1.CartScreen]
class CartRoute extends _i9.PageRouteInfo<void> {
  const CartRoute({List<_i9.PageRouteInfo>? children})
      : super(
          CartRoute.name,
          initialChildren: children,
        );

  static const String name = 'CartRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i1.CartScreen();
    },
  );
}

/// generated route for
/// [_i2.DiscoverDetailsScreen]
class DiscoverDetailsRoute extends _i9.PageRouteInfo<void> {
  const DiscoverDetailsRoute({List<_i9.PageRouteInfo>? children})
      : super(
          DiscoverDetailsRoute.name,
          initialChildren: children,
        );

  static const String name = 'DiscoverDetailsRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i2.DiscoverDetailsScreen();
    },
  );
}

/// generated route for
/// [_i3.DiscoverScreen]
class DiscoverRoute extends _i9.PageRouteInfo<void> {
  const DiscoverRoute({List<_i9.PageRouteInfo>? children})
      : super(
          DiscoverRoute.name,
          initialChildren: children,
        );

  static const String name = 'DiscoverRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i3.DiscoverScreen();
    },
  );
}

/// generated route for
/// [_i4.EntryPoint]
class EntryPoint extends _i9.PageRouteInfo<void> {
  const EntryPoint({List<_i9.PageRouteInfo>? children})
      : super(
          EntryPoint.name,
          initialChildren: children,
        );

  static const String name = 'EntryPoint';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i4.EntryPoint();
    },
  );
}

/// generated route for
/// [_i5.FakeProifleScreen]
class FakeProifleRoute extends _i9.PageRouteInfo<FakeProifleRouteArgs> {
  FakeProifleRoute({
    _i10.Key? key,
    required String pageName,
    List<_i9.PageRouteInfo>? children,
  }) : super(
          FakeProifleRoute.name,
          args: FakeProifleRouteArgs(
            key: key,
            pageName: pageName,
          ),
          initialChildren: children,
        );

  static const String name = 'FakeProifleRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<FakeProifleRouteArgs>();
      return _i5.FakeProifleScreen(
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

  final _i10.Key? key;

  final String pageName;

  @override
  String toString() {
    return 'FakeProifleRouteArgs{key: $key, pageName: $pageName}';
  }
}

/// generated route for
/// [_i6.FavoriteScreen]
class FavoriteRoute extends _i9.PageRouteInfo<void> {
  const FavoriteRoute({List<_i9.PageRouteInfo>? children})
      : super(
          FavoriteRoute.name,
          initialChildren: children,
        );

  static const String name = 'FavoriteRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i6.FavoriteScreen();
    },
  );
}

/// generated route for
/// [_i7.HomeScreen]
class HomeRoute extends _i9.PageRouteInfo<void> {
  const HomeRoute({List<_i9.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i7.HomeScreen();
    },
  );
}

/// generated route for
/// [_i8.ProfileScreen]
class ProfileRoute extends _i9.PageRouteInfo<void> {
  const ProfileRoute({List<_i9.PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i8.ProfileScreen();
    },
  );
}
