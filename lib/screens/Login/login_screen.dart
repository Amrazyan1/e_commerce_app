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
    _usernameController.text = 'info@origins.am';
    _passwordController.text = 'secret';
    _emailController.text = 'example@gmail.com';
  }

  void _changeLanguage(Locale locale) {
    context.setLocale(locale);
  }

  @override
  Widget build(BuildContext context) {
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
                PopupMenuItem(
                  value: const Locale('en'),
                  child: const Text('English'),
                ),
                PopupMenuItem(
                  value: const Locale('ar'),
                  child: const Text('العربية'),
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
                AutoRouter.of(context).replace(const EntryPoint());
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
                            // Add your date picker logic
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
                                              username: _usernameController.text
                                                  .trim(),
                                              password: _passwordController.text
                                                  .trim(),
                                            ),
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
