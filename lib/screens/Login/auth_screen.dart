import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:e_commerce_app/blocs/login/auth/bloc/auth_bloc.dart';
import 'package:e_commerce_app/components/checkout_modal.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/router/router.gr.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:super_cupertino_navigation_bar/super_cupertino_navigation_bar.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';
import 'dart:ui' as ui;

@RoutePage()
class AuthorizationScreen extends StatefulWidget {
  @override
  State<AuthorizationScreen> createState() => _AuthorizationScreenState();
}

class _AuthorizationScreenState extends State<AuthorizationScreen> {
  final TextEditingController _phoneController = TextEditingController();

  String dropdownvalue = '+374';

  @override
  Widget build(BuildContext context) {
    void _changeLanguage(Locale locale) {
      context.setLocale(locale);
    }

    return BlocProvider(
      create: (_) => AuthBloc(),
      child: KeyboardVisibilityBuilder(
        builder: (context, isKeyboardVisible) {
          return Directionality(
            textDirection: context.locale.languageCode == 'fa'
                ? ui.TextDirection.rtl
                : ui.TextDirection.ltr,
            child: Scaffold(
              body: SuperScaffold(
                          transitionBetweenRoutes: false,

                appBar: SuperAppBar(
                  automaticallyImplyLeading: false,
                  title: Text(
                    'Authorization'.tr(),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  actions: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      PopupMenuButton<Locale>(
                        icon: const Icon(Icons.language_sharp),
                        onSelected: (locale) => _changeLanguage(locale),
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: Locale('en'),
                            child: Text('English'),
                          ),
                          const PopupMenuItem(
                            value: Locale('fa'),
                            child: Text('فارسی'),
                          ),
                          const PopupMenuItem(
                            value: Locale('hy'),
                            child: Text('Հայերեն'),
                          ),
                          const PopupMenuItem(
                            value: Locale('ru'),
                            child: Text('Русский'),
                          ),
                        ],
                      ),
                    ],
                  ),
                  searchBar: SuperSearchBar(
                    enabled: false,
                    scrollBehavior: SearchBarScrollBehavior.pinned,
                    resultBehavior: SearchBarResultBehavior.neverVisible,
                  ),
                  largeTitle: SuperLargeTitle(
                    largeTitle: 'Authorization'.tr(),
                    textStyle:
                        Theme.of(context).textTheme.labelMedium!.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 24,
                              letterSpacing: 0,
                            ),
                  ),
                ),
                body: BlocListener<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is AuthPhoneSent) {
                      AutoRouter.of(context)
                          .push(OtpRoute(phoneNumber: state.phoneNumber));
                    } else if (state is AuthError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            duration: const Duration(seconds: 5),
                            content: Text(state.message)),
                      );
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: isKeyboardVisible
                          ? MainAxisAlignment.start
                          : MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: SizedBox(height: 90,width: 300, child: SvgPicture.asset("assets/images/Logo.svg")),
                  ),
                ],
              ),Text('welcome',textAlign: TextAlign.center,).tr(),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            DropdownButton<String>(
                              value: dropdownvalue,
                              onChanged: (val) {
                                log(val!);
                                setState(() {
                                  dropdownvalue = val;
                                  log(dropdownvalue);
                                });
                              },
                              underline: const SizedBox(),
                              items: ['+374'].map((code) {
                                return DropdownMenuItem(
                                  value: code,
                                  child: Text(code),
                                );
                              }).toList(),
                            ),
                            const SizedBox(
                                width:
                                    10), // Space between Dropdown and TextField
                            Expanded(
                              child: TextField(
                                controller: _phoneController,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  labelText: 'Phone Number'.tr(),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide:
                                        const BorderSide(color: kprimaryColor),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Gap(30),
                        BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, state) {
                            if (state is AuthLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            return SizedBox(
                                height: 50,
                                child: ButtonMainWidget(
                                  text: 'Next'.tr(),
                                  callback: () {
                                    final phoneNumber = _phoneController.text;
                                    if (phoneNumber.isNotEmpty) {
                                      BlocProvider.of<AuthBloc>(context).add(
                                          SendPhoneEvent(
                                              '$dropdownvalue$phoneNumber'));
                                    }
                                  },
                                ));
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Center(
                                    child: Text.rich(
                                      TextSpan(
                                        text: '',
                                        style: TextStyle(fontSize: 12),
                                        children: [
                                          TextSpan(
                                            text: 'about'.tr(),
                                            style: const TextStyle(
                                              color: kprimaryColor,
                                              decoration: TextDecoration.underline,
                                            ),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                            AutoRouter.of(context).push(const AboutUsRoute());
                            
                                              },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Text.rich(
                                      TextSpan(
                                        text: '',
                                        style: TextStyle(fontSize: 12),
                                        children: [
                                          TextSpan(
                                            text: 'help'.tr(),
                                            style: const TextStyle(
                                              color: kprimaryColor,
                                              decoration: TextDecoration.underline,
                                            ),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                            AutoRouter.of(context).push( FakeProifleRoute(pageName: ''));
                            
                                              },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                          ],
                        ),
    
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
