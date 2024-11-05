import 'dart:developer';
import 'package:animations/animations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:e_commerce_app/router/router.gr.dart';
import 'package:e_commerce_app/screens/Cart/views/cart_screen.dart';
import 'package:e_commerce_app/screens/Discover/views/discover_screen.dart';
import 'package:e_commerce_app/screens/Favorites/views/favorite_screen.dart';
import 'package:e_commerce_app/screens/Home/views/home_screen.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/screens/profile/views/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage()
class EntryPoint extends StatelessWidget {
  const EntryPoint({super.key});

  @override
  Widget build(BuildContext context) {
    SvgPicture svgIcon(String src, {Color? color}) {
      return SvgPicture.asset(
        src,
        height: 18,
        colorFilter: ColorFilter.mode(
            color ??
                Theme.of(context).iconTheme.color!.withOpacity(
                    Theme.of(context).brightness == Brightness.dark ? 0.3 : 1),
            BlendMode.srcIn),
      );
    }

    return AutoTabsRouter(
      routes: const [
        HomeRoute(),
        DiscoverRoute(),
        CartRoute(),
        FavoriteRoute(),
        ProfileRoute(),
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);

        return Scaffold(
          body: child,
          bottomNavigationBar: Container(
            padding: const EdgeInsets.only(top: defaultPadding / 2),
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.white
                : const Color(0xFF101015),
            child: BottomNavigationBar(
              currentIndex: tabsRouter.activeIndex,
              onTap: (index) {
                if (index != tabsRouter.activeIndex) {
                  tabsRouter.setActiveIndex(index);
                }
              },
              backgroundColor: Theme.of(context).brightness == Brightness.light
                  ? Colors.white
                  : const Color(0xFF101015),
              type: BottomNavigationBarType.fixed,
              selectedFontSize: 14,
              selectedItemColor: kprimaryColor,
              unselectedItemColor: Colors.transparent,
              items: [
                BottomNavigationBarItem(
                  icon: svgIcon("assets/icons/shop_my.svg"),
                  activeIcon:
                      svgIcon("assets/icons/shop_my.svg", color: kprimaryColor),
                  label: "Shop",
                ),
                BottomNavigationBarItem(
                  icon: svgIcon("assets/icons/explore_my.svg"),
                  activeIcon: svgIcon("assets/icons/explore_my.svg",
                      color: kprimaryColor),
                  label: "Discover",
                ),
                BottomNavigationBarItem(
                  icon: svgIcon("assets/icons/cart_my.svg"),
                  activeIcon:
                      svgIcon("assets/icons/cart_my.svg", color: kprimaryColor),
                  label: "Cart",
                ),
                BottomNavigationBarItem(
                  icon: svgIcon("assets/icons/fav_my.svg"),
                  activeIcon:
                      svgIcon("assets/icons/fav_my.svg", color: kprimaryColor),
                  label: "Favorites",
                ),
                BottomNavigationBarItem(
                  icon: svgIcon("assets/icons/profile_my.svg"),
                  activeIcon: svgIcon("assets/icons/profile_my.svg",
                      color: kprimaryColor),
                  label: "Profile",
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
