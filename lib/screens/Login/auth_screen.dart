import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:e_commerce_app/blocs/login/auth/bloc/auth_bloc.dart';
import 'package:e_commerce_app/components/checkout_modal.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/router/router.gr.dart';
import 'package:easy_localization/easy_localization.dart';
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
            textDirection: context.locale.languageCode == 'pr'
                ? ui.TextDirection.rtl
                : ui.TextDirection.ltr,
            child: Scaffold(
              body: SuperScaffold(
                appBar: SuperAppBar(
                  automaticallyImplyLeading: false,
                  title: Text(
                    'Authorization',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  actions: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      PopupMenuButton<Locale>(
                        onSelected: (locale) => _changeLanguage(locale),
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: Locale('en'),
                            child: Text('English'),
                          ),
                          const PopupMenuItem(
                            value: Locale('pr'),
                            child: Text('العربية'),
                          ),
                          const PopupMenuItem(
                            value: Locale('ar'),
                            child: Text('العربية'),
                          ),
                          const PopupMenuItem(
                            value: Locale('ru'),
                            child: Text('العربية'),
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
                      // showModalBottomSheet(
                      //   context: context,
                      //   builder: (_) => WoltModalSheet(
                      //     child: Padding(
                      //       padding: const EdgeInsets.all(16.0),
                      //       child: Column(
                      //         mainAxisSize: MainAxisSize.min,
                      //         children: [
                      //           Text(
                      //             "Error",
                      //             style: Theme.of(context).textTheme.headline6,
                      //           ),
                      //           const Gap(8),
                      //           Text(state.message),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // );
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: isKeyboardVisible
                          ? MainAxisAlignment.start
                          : MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
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
