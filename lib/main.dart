import 'package:e_commerce_app/Provider/main_provider.dart';
import 'package:e_commerce_app/blocs/categories/bloc/categories_bloc.dart';
import 'package:e_commerce_app/blocs/login/bloc/login_bloc.dart';
import 'package:e_commerce_app/blocs/settings/bloc/settings_bloc.dart';
import 'package:e_commerce_app/injector.dart';
import 'package:e_commerce_app/router/router.dart';
import 'package:e_commerce_app/services/api_service.dart';
import 'package:e_commerce_app/services/dio_client.dart';
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

final _appRouter = AppRouter(); // Initialize the AppRouter

void main() {
  injectGetItServices();
  runApp(
    MultiProvider(
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
        ],
        child: const MainApp(),
      ),
    ),
  );
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
          debugShowCheckedModeBanner: false,
          title: 'Shop Template by The Flutter Way',
          themeMode: ThemeMode.light,
          routerDelegate: _appRouter.delegate(),
          routeInformationParser: _appRouter.defaultRouteParser(),
        );
      },
    );
  }
}
