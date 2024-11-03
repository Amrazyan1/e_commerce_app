import 'package:e_commerce_app/Provider/main_provider.dart';
import 'package:e_commerce_app/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

final _appRouter = AppRouter(); // Initialize the AppRouter

void main() {
  runApp(
    /// Providers are above [MyApp] instead of inside it, so that tests
    /// can use [MyApp] while mocking the providers
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MainProvider()),
      ],
      child: const MainApp(),
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
