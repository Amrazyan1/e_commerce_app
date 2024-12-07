import 'dart:developer';

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:e_commerce_app/Provider/main_provider.dart';
import 'package:e_commerce_app/blocs/orders/bloc/orders_bloc.dart';
import 'package:e_commerce_app/blocs/orders/bloc/orders_event.dart';
import 'package:e_commerce_app/blocs/settings/bloc/settings_bloc.dart';
import 'package:e_commerce_app/blocs/settings/bloc/settings_state.dart';
import 'package:e_commerce_app/components/list_tile/divider_list_tile.dart';
import 'package:e_commerce_app/components/network_image_with_loader.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/router/router.gr.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';

import 'components/profile_card.dart';
import 'components/profile_menu_item_list_tile.dart';

@RoutePage()
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: Text(
              "Account",
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          const SizedBox(height: defaultPadding / 2),
          ProfileMenuListTile(
            text: "Orders",
            svgSrc: "assets/icons/Order.svg",
            press: () {
              context.read<OrdersBloc>().add(FetchOrders());
              AutoRouter.of(context).push(const OrdersRoute());
            },
          ),

          ProfileMenuListTile(
            text: "My Details",
            svgSrc: "assets/icons/my_details.svg",
            press: () {
              AutoRouter.of(context).push(const MyDetailsRoute());
            },
          ),
          ProfileMenuListTile(
            text: "Delivery Address",
            svgSrc: "assets/icons/Address.svg",
            press: () {
              AutoRouter.of(context).push(const DeliveryAddresseRoute());
            },
          ),
          ProfileMenuListTile(
            text: "Payment Methods",
            svgSrc: "assets/icons/payment.svg",
            press: () {
              AutoRouter.of(context).push(const PaymentmethodsRoute());
            },
          ),
          ProfileMenuListTile(
            text: "Promo Codes",
            svgSrc: "assets/icons/promo_code.svg",
            press: () {
              AutoRouter.of(context).push(const CouponsRoute());
            },
          ),
          const SizedBox(height: defaultPadding),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding, vertical: defaultPadding / 2),
            child: Text(
              "Additional",
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
                title: const Text(
                  'Notification',
                  style: TextStyle(fontSize: 14, height: 1),
                ),
                trailing: SizedBox(
                  width: 50,
                  child: Row(
                    children: [
                      const Spacer(),
                      CupertinoSwitch(
                        // overrides the default green color of the track
                        activeColor: const Color.fromARGB(255, 123, 193, 125),
                        // color of the round icon, which moves from right to left
                        thumbColor: Colors.white,
                        // when the switch is off
                        // trackColor: kButtonColor,
                        // boolean variable value
                        value: context.watch<MainProvider>().isAvailable,
                        // changes the state of the switch
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
            text: "Help",
            svgSrc: "assets/icons/help.svg",
            press: () {
              AutoRouter.of(context)
                  .push(FakeProifleRoute(pageName: 'Help screen'));
            },
          ),
          const SizedBox(height: defaultPadding),
          ProfileMenuListTile(
            text: "About",
            svgSrc: "assets/icons/help.svg",
            press: () {
              AutoRouter.of(context).push(AboutUsRoute());
            },
          ),
          const SizedBox(height: defaultPadding),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding, vertical: defaultPadding / 2),
            child: Text(
              "Settings",
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          ProfileMenuListTile(
            text: "Language",
            svgSrc: "assets/icons/help.svg",
            press: () {
              // Navigator.pushNamed(context, 'selectLanguageScreenRoute');
            },
          ),

          const SizedBox(height: defaultPadding),

          // Log Out
          Padding(
            padding: const EdgeInsets.all(24),
            child: Container(
              height: 54,
              decoration: BoxDecoration(
                color: Color(0xFFF2F3F4),
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextButton(
                style: ButtonStyle(
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                onPressed: () {
                  // Your logout logic here
                },
                child: const Text(
                  'Log out',
                  style: TextStyle(
                    color: ksecondaryColor,
                    fontSize: 16, // You can adjust the font size
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
