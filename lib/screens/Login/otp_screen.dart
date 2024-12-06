import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:e_commerce_app/blocs/login/auth/bloc/auth_bloc.dart';
import 'package:e_commerce_app/components/checkout_modal.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/router/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:super_cupertino_navigation_bar/super_cupertino_navigation_bar.dart';

@RoutePage()
class OtpScreen extends StatelessWidget {
  final String phoneNumber;
  final TextEditingController _otpController = TextEditingController();

  OtpScreen({required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthBloc(),
      child: Scaffold(
        body: SuperScaffold(
          appBar: SuperAppBar(
            automaticallyImplyLeading: false,
            title: const Text(
              'Otp verify',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            searchBar: SuperSearchBar(
              enabled: false,
              scrollBehavior: SearchBarScrollBehavior.pinned,
              resultBehavior: SearchBarResultBehavior.neverVisible,
            ),
            largeTitle: SuperLargeTitle(
              largeTitle: 'Otp verify',
              textStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                    letterSpacing: 0,
                  ),
            ),
            leading: GestureDetector(
              onTap: () {
                context.router.maybePop();
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                child: SvgPicture.asset("assets/icons/arrow_back.svg",
                    color: Theme.of(context).textTheme.bodyLarge!.color),
              ),
            ),
          ),
          body: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthVerified) {
                //NAVIGATE TO REGISTER SCREEN
              } else if (state is AuthError) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: PinFieldAutoFill(
                          codeLength: 4,
                          autoFocus: true,
                          enableInteractiveSelection: false,
                          keyboardType: TextInputType.number,
                          decoration: BoxLooseDecoration(
                            gapSpace: 10,
                            strokeWidth: 2,
                            textStyle: const TextStyle(
                                color: Color(0xFF512DA8),
                                fontSize: 18,
                                fontWeight: FontWeight.w400),
                            strokeColorBuilder: PinListenColorBuilder(
                                const Color(0xFFF4F5F7),
                                const Color(0xFFF4F5F7)),
                            bgColorBuilder: PinListenColorBuilder(
                                kprimaryColor.withOpacity(0.2),
                                kprimaryColor.withOpacity(0.1)),
                            radius: const Radius.circular(15),
                          ),
                          enabled: true,
                          onCodeSubmitted: (String verificationCode) {
                            _otpController.text = verificationCode;
                            // Handle submission or further actions
                          },
                          onCodeChanged: (p0) {
                            _otpController.text = p0 ?? '';
                            if (_otpController.text.length == 4) {
                              // Code is fully entered, close keyboard
                              FocusManager.instance.primaryFocus?.unfocus();
                            }
                            log(_otpController.text);
                          },
                        ),
                      ),
                    ),
                  ),
                  const Gap(20),
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      if (state is AuthLoading) {
                        return const CircularProgressIndicator();
                      }
                      return SizedBox(
                          height: 50,
                          child: ButtonMainWidget(
                            text: 'Verify',
                            callback: () {
                              final otp = _otpController.text;
                              BlocProvider.of<AuthBloc>(context)
                                  .add(VerifyOtpEvent(phoneNumber, otp));
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
  }
}
