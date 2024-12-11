import 'dart:developer';

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:e_commerce_app/Provider/main_provider.dart';
import 'package:e_commerce_app/blocs/coupons/bloc/coupons_bloc.dart';
import 'package:e_commerce_app/blocs/orders/bloc/orders_bloc.dart';
import 'package:e_commerce_app/blocs/orders/bloc/orders_event.dart';
import 'package:e_commerce_app/blocs/settings/bloc/settings_bloc.dart';
import 'package:e_commerce_app/blocs/settings/bloc/settings_state.dart';
import 'package:e_commerce_app/components/list_tile/divider_list_tile.dart';
import 'package:e_commerce_app/components/network_image_with_loader.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/router/router.gr.dart';
import 'package:e_commerce_app/services/api_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:ui' as ui;

import 'components/profile_card.dart';
import 'components/profile_menu_item_list_tile.dart';

@RoutePage()
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void deleteAccount() async {
      ApiService _apiService = GetIt.I<ApiService>();

      try {
        await _apiService.deleteUser();
      } catch (e) {
      } finally {
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('auth_token');
        Navigator.of(context).pop(); // Close the dialog
        AutoRouter.of(context).replaceAll([const AuthorizationRoute()]);
      }
    }

    return Directionality(
      textDirection: context.locale.languageCode == 'fa'
          ? ui.TextDirection.rtl
          : ui.TextDirection.ltr,
      child: Scaffold(
        body: ListView(
          children: [
            BlocBuilder<SettingsBloc, SettingsState>(
              builder: (context, state) {
                if (state is SettingsLoaded) {
                  return ProfileCard(
                    name: state.settings.data!.fullName!,
                    email: state.settings.data!.email!,
                    imageSrc:
                        "https://cdn-icons-png.flaticon.com/512/219/219988.png",
                    isPro: state.settings.data!.isPartner!,
                  );
                }
                if (state is SettingsError) {
                  log('Error ${state.error}');
                }
                return Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  enabled: true,
                  child: const ProfileCard(
                    name: "",
                    email: "",
                    imageSrc:
                        "https://cdn-icons-png.flaticon.com/512/219/219988.png",
                  ),
                );
              },
            ),

            // Account Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(
                "account".tr(),
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            const SizedBox(height: defaultPadding / 2),
            ProfileMenuListTile(
              text: "orders".tr(),
              svgSrc: "assets/icons/Order.svg",
              press: () {
                context.read<OrdersBloc>().add(FetchOrders());
                AutoRouter.of(context).push(const OrdersRoute());
              },
            ),
            ProfileMenuListTile(
              text: "my_details".tr(),
              svgSrc: "assets/icons/my_details.svg",
              press: () {
                AutoRouter.of(context).push(const MyDetailsRoute());
              },
            ),
            ProfileMenuListTile(
              text: "delivery_address".tr(),
              svgSrc: "assets/icons/Address.svg",
              press: () {
                AutoRouter.of(context).push(const DeliveryAddresseRoute());
              },
            ),
            // ProfileMenuListTile(
            //   text: "payment_methods".tr(),
            //   svgSrc: "assets/icons/payment.svg",
            //   press: () {
            //     AutoRouter.of(context).push(const PaymentmethodsRoute());
            //   },
            // ),
            ProfileMenuListTile(
              text: "promo_codes".tr(),
              svgSrc: "assets/icons/promo_code.svg",
              press: () {
                context.read<CouponsBloc>().add(FetchCoupons());
                AutoRouter.of(context).push(const CouponsRoute());
              },
            ),
            const SizedBox(height: defaultPadding),

            // Additional Section
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: defaultPadding, vertical: defaultPadding / 2),
              child: Text(
                "additional".tr(),
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            Column(
              children: [
                ListTile(
                  onTap: () {
                    context.read<MainProvider>().isAvailable =
                        !context.read<MainProvider>().isAvailable;
                  },
                  minLeadingWidth: 24,
                  leading: SvgPicture.asset(
                    "assets/icons/Notification.svg",
                    height: 24,
                    width: 24,
                    colorFilter: ColorFilter.mode(
                        Theme.of(context).iconTheme.color!, BlendMode.srcIn),
                  ),
                  title: Text(
                    'notification'.tr(),
                    style: const TextStyle(fontSize: 14, height: 1),
                  ),
                  trailing: SizedBox(
                    width: 50,
                    child: Row(
                      children: [
                        const Spacer(),
                        CupertinoSwitch(
                          activeColor: const Color.fromARGB(255, 123, 193, 125),
                          thumbColor: Colors.white,
                          value: context.watch<MainProvider>().isAvailable,
                          onChanged: (value) {
                            context.read<MainProvider>().isAvailable = value;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Divider(),
            ProfileMenuListTile(
              text: "help".tr(),
              svgSrc: "assets/icons/help.svg",
              press: () {
                AutoRouter.of(context)
                    .push(FakeProifleRoute(pageName: 'Help screen'));
              },
            ),
            const SizedBox(height: defaultPadding),
            ProfileMenuListTile(
              text: "about".tr(),
              svgSrc: "assets/icons/help.svg",
              press: () {
                AutoRouter.of(context).push(AboutUsRoute());
              },
            ),
            const SizedBox(height: defaultPadding),

            // Settings Section
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: defaultPadding, vertical: defaultPadding / 2),
              child: Text(
                "settings".tr(),
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            ProfileMenuListTile(
              text: "language".tr(),
              svgSrc: "assets/icons/help.svg",
              press: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Change Language'.tr()),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            title: Text('English'),
                            onTap: () {
                              context.setLocale(const Locale('en'));
                              Navigator.of(context).pop();
                            },
                          ),
                          ListTile(
                            title: Text('العربية'),
                            onTap: () {
                              context.setLocale(const Locale('fa'));
                              Navigator.of(context).pop();
                            },
                          ),
                          ListTile(
                            title: Text('Հայերեն'),
                            onTap: () {
                              context.setLocale(const Locale('hy'));
                              Navigator.of(context).pop();
                            },
                          ),
                          ListTile(
                            title: Text('Русский'),
                            onTap: () {
                              context.setLocale(const Locale('ru'));
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),

            const SizedBox(height: defaultPadding),

            // Log Out
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 54,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF2F3F4),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      onPressed: () async {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('log_out'.tr()),
                              content: Text('log_sure'.tr()),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    // Close the dialog
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('cancel'.tr()),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    final prefs =
                                        await SharedPreferences.getInstance();
                                    await prefs.remove('auth_token');
                                    AutoRouter.of(context).replaceAll(
                                        [const AuthorizationRoute()]);
                                  },
                                  child: Text(
                                    'log_out'.tr(),
                                    style: const TextStyle(color: Colors.red),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Text(
                        'log_out'.tr(),
                        style: const TextStyle(
                          color: ksecondaryColor,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const Gap(10),
                  Container(
                    height: 54,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF2F3F4),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: Colors.red, // Red border color
                        width: 1, // Border width
                      ),
                    ),
                    child: TextButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      onPressed: () async {
                        // Show Alert Dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('confirm_delete'.tr()),
                              content: Text('delete_sure'.tr()),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    // Close the dialog
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('cancel'.tr()),
                                ),
                                TextButton(
                                  onPressed: deleteAccount,
                                  child: Text(
                                    'delete'.tr(),
                                    style: const TextStyle(color: Colors.red),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Text(
                        'delete_acc'.tr(),
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
