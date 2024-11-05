import 'package:auto_route/auto_route.dart';
import 'package:e_commerce_app/components/checkout_modal.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/router/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

@RoutePage()
class SplashViewScreen extends StatelessWidget {
  const SplashViewScreen({super.key});

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
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.all(defaultPadding),
              child: SizedBox(
                  height: 55,
                  child: ButtonMainWidget(
                    text: 'Get Started',
                    callback: () {
                      AutoRouter.of(context).replace(EntryPoint());
                    },
                  )),
            ),
          ),
          Column(
            children: [
              Gap(80),
              Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Text(
                  'Welcome to our store',
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
