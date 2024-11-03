import 'dart:developer';

import 'package:animations/animations.dart';
import 'package:auto_route/annotations.dart';
import 'package:e_commerce_app/screens/Cart/views/cart_screen.dart';
import 'package:e_commerce_app/screens/Discover/views/discover_screen.dart';
import 'package:e_commerce_app/screens/Favorites/views/favorite_screen.dart';
import 'package:e_commerce_app/screens/Home/views/home_screen.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/screens/profile/views/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage()
class EntryPoint extends StatefulWidget {
  const EntryPoint({super.key});

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint> {
  final List _pages = const [
    HomeScreen(),
    DiscoverScreen(),
    // BookmarkScreen(),
    // // EmptyCartScreen(), // if Cart is empty
    CartScreen(),
    FavoriteScreen(),
    ProfileScreen(),
  ];
  int _currentIndex = 0;

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

    return PopScope(
      canPop: _currentIndex == 0, // Allows pop if not on the first screen
      onPopInvoked: (popInvoked) async {
        log('pop $_currentIndex');
        if (_currentIndex != 0) {
          setState(() {
            _currentIndex = 0; // Go back to the first screen
          });
          return; // Return without invoking pop
        } else
          popInvoked; // Allow the pop to proceed if on the first screen
      },
      child: Scaffold(
        body: PageTransitionSwitcher(
          duration: defaultDuration,
          transitionBuilder: (child, animation, secondAnimation) {
            return FadeThroughTransition(
              animation: animation,
              secondaryAnimation: secondAnimation,
              child: child,
            );
          },
          child: _pages[_currentIndex],
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.only(top: defaultPadding / 2),
          color: Theme.of(context).brightness == Brightness.light
              ? Colors.white
              : const Color(0xFF101015),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              if (index != _currentIndex) {
                setState(() {
                  _currentIndex = index;
                });
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
                icon: svgIcon(
                  "assets/icons/fav_my.svg",
                ),
                activeIcon:
                    svgIcon("assets/icons/fav_my.svg", color: kprimaryColor),
                label: "Favourites",
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
      ),
    );
  }
}
