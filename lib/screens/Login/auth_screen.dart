import 'package:auto_route/auto_route.dart';
import 'package:e_commerce_app/blocs/login/auth/bloc/auth_bloc.dart';
import 'package:e_commerce_app/router/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:gap/gap.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

@RoutePage()
class AuthorizationScreen extends StatelessWidget {
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthBloc(),
      child: KeyboardVisibilityBuilder(
        builder: (context, isKeyboardVisible) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Authorization'),
              centerTitle: true,
              backgroundColor: Colors.blueAccent,
            ),
            body: BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthPhoneSent) {
                  // Navigator.of(context).push(SwipeablePageRoute(
                  //   builder: (_) => OtpRoute(phoneNumber: state.phoneNumber),
                  // ));
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
                    WidgetAnimator(
                      child: TextField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: 'Phone Number',
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: DropdownButton<String>(
                              value: '+374',
                              onChanged: (_) {},
                              underline: const SizedBox(),
                              items: ['+374', '+1', '+91'].map((code) {
                                return DropdownMenuItem(
                                  value: code,
                                  child: Text(code),
                                );
                              }).toList(),
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide:
                                const BorderSide(color: Colors.blueAccent),
                          ),
                        ),
                      ),
                    ),
                    const Gap(30),
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        if (state is AuthLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return WidgetAnimator(
                          child: ElevatedButton(
                            onPressed: () {
                              final phoneNumber = _phoneController.text;
                              if (phoneNumber.isNotEmpty) {
                                BlocProvider.of<AuthBloc>(context)
                                    .add(SendPhoneEvent(phoneNumber));
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                            child: const Text(
                              'Next',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
