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

    String? _validateAndFormatPhoneNumber(String? value) {
      if (value == null || value.isEmpty) {
        return 'please_enter'.tr();
      }

      // Regular expression to match valid Armenian numbers
      final phoneRegex = RegExp(r'^[1-9]\d{7}$');

      // Remove the leading "0" if it exists
      if (value.startsWith('0')) {
        value = value.substring(1);
      }

      // Validate the number against the regex
      if (!phoneRegex.hasMatch(value)) {
        return 'please_enter_valid'.tr();
      }

      // If valid, format and return null (no error)
      _phoneController.text = value; // Update controller with valid number
      return null;
    }

    return BlocProvider(
      create: (_) => AuthBloc(),
      child: Directionality(
        textDirection:
            context.locale.languageCode == 'fa' ? ui.TextDirection.rtl : ui.TextDirection.ltr,
        child: Scaffold(
          body: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Scaffold(
              appBar: AppBar(actions: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: '',
                        style: const TextStyle(fontSize: 18),
                        children: [
                          TextSpan(
                            text: 'skip'.tr(),
                            style: const TextStyle(
                              color: kprimaryColor,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                AutoRouter.of(context).replaceAll([const EntryPoint()]);
                              },
                          ),
                        ],
                      ),
                    ),
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
              ]),
              body: BlocListener<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthPhoneSent) {
                    AutoRouter.of(context).push(OtpRoute(phoneNumber: state.phoneNumber));
                  } else if (state is AuthError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(duration: const Duration(seconds: 5), content: Text(state.message)),
                    );
                  }
                },
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(0),
                              child: SizedBox(
                                  height: 50,
                                  width: 300,
                                  child: SvgPicture.asset("assets/images/Logo.svg")),
                            ),
                          ],
                        ),
                        Gap(50),
                        Text(
                          'Authorization'.tr(),
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                        ),
                        Gap(90),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'welcome',
                              textAlign: TextAlign.left,
                              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                                    fontSize: 16,
                                  ),
                            ).tr(),
                            Gap(20),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(height: 90, child: Center(child: Text('+374'))),
                                // DropdownButton<String>(
                                //   value: dropdownvalue,
                                //   onChanged: (val) {
                                //     log(val!);
                                //     setState(() {
                                //       dropdownvalue = val;
                                //       log(dropdownvalue);
                                //     });
                                //   },
                                //   underline: const SizedBox(),
                                //   items: ['+374'].map((code) {
                                //     return DropdownMenuItem(
                                //       value: code,
                                //       child: Text(code),
                                //     );
                                //   }).toList(),
                                // ),
                                const SizedBox(width: 10), // Space between Dropdown and TextField
                                Expanded(
                                  child: TextFormField(
                                    controller: _phoneController,
                                    keyboardType: TextInputType.phone,
                                    decoration: InputDecoration(
                                      labelText: 'Phone Number'.tr(),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                        borderSide: const BorderSide(color: kprimaryColor),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                        borderSide: const BorderSide(color: Colors.red),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                        borderSide: const BorderSide(color: Colors.red),
                                      ),
                                    ),
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    validator: _validateAndFormatPhoneNumber,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Gap(180),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: BlocBuilder<AuthBloc, AuthState>(
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
                                      final formattedPhoneNumber = phoneNumber.startsWith('0')
                                          ? phoneNumber.substring(1)
                                          : phoneNumber;

                                      if (formattedPhoneNumber.isNotEmpty) {
                                        BlocProvider.of<AuthBloc>(context)
                                            .add(SendPhoneEvent('$dropdownvalue$phoneNumber'));
                                      }
                                    },
                                  ));
                            },
                          ),
                        ),
                        const Gap(20),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 40),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: '${'By signing up, you agree to the'.tr()} \n',
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 13,
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'terms_conditions'.tr(),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            final langCode =
                                                EasyLocalization.of(context)!.locale.languageCode;
                                            AutoRouter.of(context).push(WebviewRoute(
                                                link:
                                                    'https://imexpro.am/terms-conditions/$langCode'));
                                          },
                                        style: const TextStyle(
                                          color: kprimaryColor,
                                          decoration: TextDecoration.underline,
                                          fontSize: 14,
                                        ),
                                      ),
                                      const TextSpan(
                                        text: '  and  ',
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 13,
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'privacy_policy'.tr(),
                                        style: const TextStyle(
                                          color: kprimaryColor,
                                          decoration: TextDecoration.underline,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            final langCode =
                                                EasyLocalization.of(context)!.locale.languageCode;
                                            AutoRouter.of(context).push(WebviewRoute(
                                                link:
                                                    'https://imexpro.am/privacy-policy/$langCode'));
                                          },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
