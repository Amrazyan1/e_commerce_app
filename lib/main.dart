import 'dart:async';

import 'package:e_commerce_app/Provider/main_provider.dart';
import 'package:e_commerce_app/blocs/bloc/product_detail_bloc.dart';
import 'package:e_commerce_app/blocs/categories/bloc/categories_bloc.dart';
import 'package:e_commerce_app/blocs/categorydetails/bloc/copy/bloc/category_detail_copy_bloc.dart';
import 'package:e_commerce_app/blocs/coupons/bloc/coupons_bloc.dart';
import 'package:e_commerce_app/blocs/login/bloc/login_bloc.dart';
import 'package:e_commerce_app/blocs/orders/bloc/orders_bloc.dart';
import 'package:e_commerce_app/blocs/orders/details/bloc/orderdetail_bloc.dart';
import 'package:e_commerce_app/blocs/settings/bloc/settings_bloc.dart';
import 'package:e_commerce_app/injector.dart';
import 'package:e_commerce_app/router/router.dart';
import 'package:e_commerce_app/services/api_service.dart';
import 'package:e_commerce_app/services/dio_client.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/cart/bloc/cart_bloc.dart';
import 'blocs/categorydetails/bloc/category_detail_bloc.dart';
import 'blocs/favourites/bloc/favourites_bloc.dart';
import 'blocs/products/discounts/bloc/discounted_bloc.dart';
import 'blocs/products/popular/bloc/popular_products_bloc.dart';
import 'blocs/products/trending/bloc/trend_new_products_bloc.dart';
import 'blocs/search/bloc/global_search_bloc.dart'; // Import flutter_bloc
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final appRouter = AppRouter(); // Initialize the AppRouter
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  injectGetItServices();

  final GoogleMapsFlutterPlatform mapsImplementation =
      GoogleMapsFlutterPlatform.instance;
  if (mapsImplementation is GoogleMapsFlutterAndroid) {
    initializeMapRenderer();
  }
  EasyLocalization.logger.enableLevels = [EasyLocalization.logger.defaultLevel];

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('hy'),
        Locale('fa'),
        Locale('ru')
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      // assetLoader: SmartNetworkAssetLoader(
      //     // token: 'clcbI7yVPTF2ijzmK76oOEvQYr4IHOBi',
      //     assetsPath: 'assets/translations',
      //     localCacheDuration: const Duration(minutes: 1),
      //     localeUrl: (String localeName) =>
      //         "https://localise.biz/api/export/locale/",
      //     timeout: const Duration(seconds: 15)),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => MainProvider()),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => LoginBloc(),
            ),
            BlocProvider(
              create: (context) => SettingsBloc(),
            ),
            BlocProvider(
              create: (context) => CategoriesBloc(),
            ),
            BlocProvider(
              create: (_) => TrendNewProductsBloc(),
            ),
            BlocProvider(
              create: (_) => DiscountedBloc(),
            ),
            BlocProvider(
              create: (_) => PopularProductsBloc(),
            ),
            BlocProvider(
              create: (_) => CartBloc(),
            ),
            BlocProvider(
              create: (_) => FavouritesBloc(),
            ),
            BlocProvider(
              create: (_) => CategoryDetailBloc(),
            ),
            BlocProvider(
              create: (_) => GlobalSearchBloc(),
            ),
            BlocProvider(
              create: (_) => OrdersBloc(),
            ),
            BlocProvider(
              create: (_) => OrderDetailBloc(),
            ),
            BlocProvider(
              create: (_) => CategoryDetailCopyBloc(),
            ),
            BlocProvider(
              create: (_) => CouponsBloc(),
            ),
            BlocProvider(
              create: (_) => ProductDetailBloc(),
            ),
          ],
          child: const MainApp(),
        ),
      ),
    ),
  );
}

Completer<AndroidMapRenderer?>? _initializedRendererCompleter;

/// Initializes map renderer to the `latest` renderer type for Android platform.
///
/// The renderer must be requested before creating GoogleMap instances,
/// as the renderer can be initialized only once per application context.
Future<AndroidMapRenderer?> initializeMapRenderer() async {
  if (_initializedRendererCompleter != null) {
    return _initializedRendererCompleter!.future;
  }

  final Completer<AndroidMapRenderer?> completer =
      Completer<AndroidMapRenderer?>();
  _initializedRendererCompleter = completer;

  WidgetsFlutterBinding.ensureInitialized();

  final GoogleMapsFlutterPlatform mapsImplementation =
      GoogleMapsFlutterPlatform.instance;
  if (mapsImplementation is GoogleMapsFlutterAndroid) {
    unawaited(mapsImplementation
        .initializeWithRenderer(AndroidMapRenderer.latest)
        .then((AndroidMapRenderer initializedRenderer) =>
            completer.complete(initializedRenderer)));
  } else {
    completer.complete(null);
  }

  return completer.future;
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      fontSizeResolver: (fontSize, instance) =>
          FontSizeResolvers.width(fontSize, instance),
      builder: (context, child) {
        return MaterialApp.router(
          key: navigatorKey,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          title: 'Orig Inn',
          themeMode: ThemeMode.light,
          routerDelegate: appRouter.delegate(),
          routeInformationParser: appRouter.defaultRouteParser(),
        );
      },
    );
  }
}
