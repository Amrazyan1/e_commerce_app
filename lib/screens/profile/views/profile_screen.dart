import 'package:auto_route/annotations.dart';
import 'package:e_commerce_app/components/list_tile/divider_list_tile.dart';
import 'package:e_commerce_app/components/network_image_with_loader.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
          ProfileCard(
            name: "Name Surname",
            email: "email@gmail.com",
            imageSrc: "https://i.imgur.com/IXnwbLk.png",
            // proLableText: "Sliver",
            // isPro: true, if the user is pro
            press: () {
              Navigator.pushNamed(context, 'userInfoScreenRoute');
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
              Navigator.pushNamed(context, 'ordersScreenRoute');
            },
          ),

          ProfileMenuListTile(
            text: "My Details",
            svgSrc: "assets/icons/my_details.svg",
            press: () {},
          ),
          ProfileMenuListTile(
            text: "Delivery Address",
            svgSrc: "assets/icons/Address.svg",
            press: () {
              Navigator.pushNamed(context, 'addressesScreenRoute');
            },
          ),
          ProfileMenuListTile(
            text: "Payment Methods",
            svgSrc: "assets/icons/payment.svg",
            press: () {
              Navigator.pushNamed(context, 'emptyPaymentScreenRoute');
            },
          ),
          ProfileMenuListTile(
            text: "Promo Cods",
            svgSrc: "assets/icons/promo_code.svg",
            press: () {
              Navigator.pushNamed(context, 'walletScreenRoute');
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
          DividerListTileWithTrilingText(
            svgSrc: "assets/icons/Notification.svg",
            title: "Notification",
            trilingText: "Off",
            press: () {
              Navigator.pushNamed(context, 'enableNotificationScreenRoute');
            },
          ),
          ProfileMenuListTile(
            text: "Help",
            svgSrc: "assets/icons/help.svg",
            press: () {
              Navigator.pushNamed(context, 'preferencesScreenRoute');
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
            svgSrc: "assets/icons/Language.svg",
            press: () {
              Navigator.pushNamed(context, 'selectLanguageScreenRoute');
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
