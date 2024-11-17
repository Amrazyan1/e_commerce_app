import 'dart:developer';
import 'package:auto_route/auto_route.dart';
import 'package:e_commerce_app/blocs/settings/bloc/settings_bloc.dart';
import 'package:e_commerce_app/blocs/settings/bloc/settings_event.dart';
import 'package:e_commerce_app/router/router.gr.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage()
class EntryPoint extends StatefulWidget {
  const EntryPoint({super.key});

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint> {
  @override
  Widget build(BuildContext context) {
    SvgPicture svgIcon(String src, {Color? color}) {
      return SvgPicture.asset(
        src,
        height: 18,
        colorFilter: ColorFilter.mode(
          color ??
              Theme.of(context).iconTheme.color!.withOpacity(
                    Theme.of(context).brightness == Brightness.dark ? 0.3 : 1,
                  ),
          BlendMode.srcIn,
        ),
      );
    }

    return AutoTabsRouter(
      routes: const [
        EmptyHomeRouter(children: [
          HomeRoute(), // Default child of home tab
        ]),
        DiscoverRoute(),
        CartRoute(),
        FavoriteRoute(),
        ProfileRoute(),
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);

        return WillPopScope(
          onWillPop: () async {
            if (tabsRouter.activeIndex != 0) {
              // Navigate back to the first tab (Home tab)
              tabsRouter.setActiveIndex(0);
              log('Navigated back to Home tab.');
              return false; // Prevent system back pop
            }
            return true; // Allow system back pop (exit app)
          },
          child: Scaffold(
            body: child,
            bottomNavigationBar: Container(
              padding: const EdgeInsets.only(top: defaultPadding / 2),
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.white
                  : const Color(0xFF101015),
              child: BottomNavigationBar(
                currentIndex: tabsRouter.activeIndex,
                onTap: (index) {
                  _onPageChange(index, tabsRouter);
                },
                type: BottomNavigationBarType.fixed,
                selectedFontSize: 14,
                selectedItemColor: kprimaryColor,
                unselectedItemColor: Colors.transparent,
                items: [
                  BottomNavigationBarItem(
                    icon: svgIcon("assets/icons/shop_my.svg"),
                    activeIcon: svgIcon("assets/icons/shop_my.svg",
                        color: kprimaryColor),
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
                    activeIcon: svgIcon("assets/icons/cart_my.svg",
                        color: kprimaryColor),
                    label: "Cart",
                  ),
                  BottomNavigationBarItem(
                    icon: svgIcon("assets/icons/fav_my.svg"),
                    activeIcon: svgIcon("assets/icons/fav_my.svg",
                        color: kprimaryColor),
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
          ),
        );
      },
    );
  }

  void _onPageChange(int index, TabsRouter tabsRouter) {
    if (index != tabsRouter.activeIndex) {
      tabsRouter.setActiveIndex(index);

      switch (index) {
        case 4:
          context.read<SettingsBloc>().add(FetchUserSettingsEvent());
          break;
        default:
      }
    }
  }
}
