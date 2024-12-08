import 'dart:developer';
import 'package:auto_route/auto_route.dart';
import 'package:e_commerce_app/blocs/cart/bloc/cart_bloc.dart';
import 'package:e_commerce_app/blocs/categories/bloc/categories_bloc.dart';
import 'package:e_commerce_app/blocs/categories/bloc/categories_event.dart';
import 'package:e_commerce_app/blocs/categorydetails/bloc/category_detail_bloc.dart';
import 'package:e_commerce_app/blocs/categorydetails/bloc/category_detail_event.dart';
import 'package:e_commerce_app/blocs/favourites/bloc/favourites_bloc.dart';
import 'package:e_commerce_app/blocs/settings/bloc/settings_bloc.dart';
import 'package:e_commerce_app/blocs/settings/bloc/settings_event.dart';
import 'package:e_commerce_app/router/router.gr.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'blocs/products/discounts/bloc/discounted_bloc.dart';
import 'blocs/products/popular/bloc/popular_products_bloc.dart';
import 'blocs/products/trending/bloc/trend_new_products_bloc.dart';

final GlobalKey<AutoTabsRouterState> autoTabsRouterKey =
    GlobalKey<AutoTabsRouterState>();

@RoutePage()
class EntryPoint extends StatefulWidget {
  const EntryPoint({super.key});

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint> {
  @override
  void initState() {
    super.initState();
    context.read<TrendNewProductsBloc>().add(FetchTrendNewProductsEvent());
    context.read<DiscountedBloc>().add(FetchDiscountedProductsEvent());
    context.read<PopularProductsBloc>().add(FetchTrendPopularProductsEvent());
  }

  DateTime timeBackPressed = DateTime.now();
  var tabsRouter;
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

    return WillPopScope(
      onWillPop: () async {
        log('WillPopScope');
        if (tabsRouter.activeIndex == 0) {
          final difference = DateTime.now().difference(timeBackPressed);
          final isExitWarning = difference >= const Duration(seconds: 1);

          timeBackPressed = DateTime.now();

          if (isExitWarning) {
            const toastMessage = "Press again to exit";
            Fluttertoast.showToast(msg: toastMessage, fontSize: 18);
            return false;
          } else {
            log('WillPopScope EXIT');

            Fluttertoast.cancel();
            return true; // Return false to block the back navigation
          }
        }
        return Future.value(tabsRouter.activeIndex != 0);
      },
      child: AutoTabsRouter(
        key: autoTabsRouterKey,
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
          tabsRouter = AutoTabsRouter.of(context);

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
                    label: "shop".tr(),
                  ),
                  BottomNavigationBarItem(
                    icon: svgIcon("assets/icons/explore_my.svg"),
                    activeIcon: svgIcon("assets/icons/explore_my.svg",
                        color: kprimaryColor),
                    label: "discover".tr(),
                  ),
                  BottomNavigationBarItem(
                    icon: svgIcon("assets/icons/cart_my.svg"),
                    activeIcon: svgIcon("assets/icons/cart_my.svg",
                        color: kprimaryColor),
                    label: "cart".tr(),
                  ),
                  BottomNavigationBarItem(
                    icon: svgIcon("assets/icons/fav_my.svg"),
                    activeIcon: svgIcon("assets/icons/fav_my.svg",
                        color: kprimaryColor),
                    label: "favorite".tr(),
                  ),
                  BottomNavigationBarItem(
                    icon: svgIcon("assets/icons/profile_my.svg"),
                    activeIcon: svgIcon("assets/icons/profile_my.svg",
                        color: kprimaryColor),
                    label: "profile".tr(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _onPageChange(int index, TabsRouter tabsRouter) async {
    if (index != tabsRouter.activeIndex) {
      tabsRouter.setActiveIndex(index);

      switch (index) {
        case 0:
          // context
          //     .read<TrendNewProductsBloc>()
          //     .add(FetchTrendNewProductsEvent());
          // context.read<DiscountedBloc>().add(FetchDiscountedProductsEvent());
          // context
          //     .read<PopularProductsBloc>()
          //     .add(FetchTrendPopularProductsEvent());
          break;
        case 1:
          context.read<CategoriesBloc>().add(FetchCategoriesEvent());
          context.read<CategoryDetailBloc>().cancelLoadProducts();
          context
              .read<CategoryDetailBloc>()
              .add(FetchCategoryProductsEvent(id: '', page: 0));

          break;
        case 2:
          context.read<CartBloc>().add(LoadCart());

          break;
        case 3:
          context.read<FavouritesBloc>().add(FetchFavouritesEvent());

          break;
        case 4:
          final prefs = await SharedPreferences.getInstance();
          final asgas = prefs.getString('auth_token');
          log('$asgas');
          context.read<SettingsBloc>().add(FetchUserSettingsEvent());
          break;

        default:
      }
    }
  }
}
