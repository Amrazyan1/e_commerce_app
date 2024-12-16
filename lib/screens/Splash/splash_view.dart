import 'package:auto_route/auto_route.dart';
import 'package:e_commerce_app/components/checkout_modal.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/router/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';

@RoutePage()
class SplashViewScreen extends StatefulWidget {
  const SplashViewScreen({super.key});

  @override
  State<SplashViewScreen> createState() => _SplashViewScreenState();
}

class _SplashViewScreenState extends State<SplashViewScreen> {
  @override
  void initState() {
    super.initState();
    checkAutoLogin();
  }

  void checkAutoLogin() async {
    final status = await AppTrackingTransparency.requestTrackingAuthorization();
    final prefs = await SharedPreferences.getInstance();
    String? authToken = prefs.getString('auth_token');
    await Future.delayed(const Duration(seconds: 1));
    if (authToken != null && authToken.isNotEmpty) {
      AutoRouter.of(context).replaceAll([const EntryPoint()]);
    } else {
      AutoRouter.of(context).replace(const AuthorizationRoute());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0),
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              'assets/images/splash.png',
              fit: BoxFit.fill,
            ),
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.all(defaultPadding),
              child: SizedBox(child: CircularProgressIndicator()),
            ),
          ),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Gap(80),
              Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Text(
                  'Welcome to',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 48,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Text(
                  'Orig Inn',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 48,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
