import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:e_commerce_app/blocs/login/bloc/login_bloc.dart';
import 'package:e_commerce_app/blocs/login/bloc/login_event.dart';
import 'package:e_commerce_app/blocs/login/bloc/login_state.dart';
import 'package:e_commerce_app/components/checkout_modal.dart';
import 'package:e_commerce_app/router/router.gr.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'dart:ui' as ui;

@RoutePage()
class LoginPage extends StatefulWidget {
  final String phoneNumber;

  LoginPage({required this.phoneNumber});
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _dateTimeController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _usernameController.text = '';
    _passwordController.text = 'password';
    _emailController.text = '';
  }

  void _changeLanguage(Locale locale) {
    context.setLocale(locale);
  }

  @override
  Widget build(BuildContext context) {
    Future<DateTime?> showDialog(Widget child) async {
      DateTime? picked = await showCupertinoModalPopup<DateTime>(
        context: context,
        builder: (BuildContext context) => Container(
          height: 216,
          padding: const EdgeInsets.only(top: 6.0),
          // The Bottom margin is provided to align the popup above the system
          // navigation bar.
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          // Provide a background color for the popup.
          color: CupertinoColors.systemBackground.resolveFrom(context),
          // Use a SafeArea widget to avoid system overlaps.
          child: SafeArea(
            top: false,
            child: child,
          ),
        ),
      );
      // This block is executed when the date picker is dismissed.
      print('Date Picker closed. Selected Date: $picked');
      // Return the selected date (or null if the picker was dismissed without a selection).
      return picked;
    }

    return Directionality(
      textDirection: context.locale.languageCode == 'ar'
          ? ui.TextDirection.rtl
          : ui.TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            PopupMenuButton<Locale>(
              onSelected: (locale) => _changeLanguage(locale),
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: Locale('en'),
                  child: Text('English'),
                ),
                const PopupMenuItem(
                  value: Locale('ar'),
                  child: Text('العربية'),
                ),
              ],
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginSuccess) {
                AutoRouter.of(context)
                    .replaceAll([DeliveryAddressNew(fromLogin: true)]);
              } else if (state is LoginFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.error)),
                );
              }
            },
            builder: (context, state) {
              return Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sign Up'.tr(),
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Enter your credentials to continue'.tr(),
                          style:
                              const TextStyle(fontSize: 16, color: Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 32),
                        TextFormField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            labelText: 'Username'.tr(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your username'.tr();
                            }
                            return null;
                          },
                        ),
                        const Gap(16),
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: 'Email'.tr(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email'.tr();
                            }
                            return null;
                          },
                        ),
                        const Gap(16),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              CupertinoDatePicker(
                                initialDateTime: DateTime.now(),

                                mode: CupertinoDatePickerMode.date,
                                use24hFormat: true,
                                // This shows day of week alongside day of month
                                showDayOfWeek: true,
                                // This is called when the user changes the date.
                                onDateTimeChanged: (DateTime newDate) {
                                  log(newDate.toString());
                                  String formattedDate =
                                      DateFormat('yyyy-MM-dd').format(newDate);

                                  _dateTimeController.text = formattedDate;
                                },
                              ),
                            );
                          },
                          child: AbsorbPointer(
                            child: TextFormField(
                              controller: _dateTimeController,
                              readOnly: true,
                              decoration: InputDecoration(
                                labelText: 'Birth date'.tr(),
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.calendar_month),
                                  onPressed: () {
                                    // Handle calendar icon action
                                  },
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your birth date'.tr();
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        const Gap(16),
                        state is LoginLoading
                            ? const Center(child: CircularProgressIndicator())
                            : SizedBox(
                                height: 50,
                                child: ButtonMainWidget(
                                  text: 'Sign In'.tr(),
                                  callback: () {
                                    if (_formKey.currentState!.validate()) {
                                      context.read<LoginBloc>().add(
                                            LoginSubmitted(
                                                username: _usernameController
                                                    .text
                                                    .trim(),
                                                password: _passwordController
                                                    .text
                                                    .trim(),
                                                birthDate:
                                                    _dateTimeController.text,
                                                email: _emailController.text,
                                                phone: widget.phoneNumber),
                                          );
                                    }
                                  },
                                ),
                              ),
                        const Gap(16),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
