import 'package:auto_route/auto_route.dart';
import 'package:e_commerce_app/router/router.dart';
import 'package:flutter/material.dart';

final router = AppRouter();

final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();

extension NavigationHelper on AppRouter {
  Future<void> pushAndPopAll(PageRouteInfo page) async {
    await replaceAll([page]);
  }
}
