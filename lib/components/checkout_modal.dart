import 'package:auto_route/auto_route.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/router/router.gr.dart';
import 'package:e_commerce_app/screens/profile/views/components/profile_menu_item_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class CheckoutModal extends StatelessWidget {
  const CheckoutModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Checkout',
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(Icons.close))
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    _customListTile(
                      text: 'Delivery',
                      text1: 'Select Address',
                    ),
                    Divider(height: 1),
                    _customListTile(
                      text: 'Payment',
                      text1: 'Select Payment',
                    ),
                    Divider(height: 1),
                    _customListTile(
                      text: 'Promo Code',
                      text1: 'Pick discount',
                    ),
                    Divider(height: 1),
                    _customListTile(
                      text: 'Total Cost',
                      text1: '7,780 ֏',
                    ),
                    Divider(height: 1),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: SizedBox(
                    height: 50,
                    child: ButtonMainWidget(
                      text: 'Place order',
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ButtonMainWidget extends StatelessWidget {
  ButtonMainWidget({
    super.key,
    required this.text,
    this.callback,
  });
  final String text;
  VoidCallback? callback;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: kprimaryColor,
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(defaultBorderRadious),
        ),
      ),
      child: InkWell(
        onTap: callback ?? () {},
        child: Center(
          child: Text(
            text,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class _customListTile extends StatelessWidget {
  const _customListTile({
    super.key,
    required this.text,
    required this.text1,
  });

  final String text;
  final String text1;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      title: Text(
        text,
        style: TextStyle(
            fontSize: 17, fontWeight: FontWeight.bold, color: Colors.grey),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text1,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          SvgPicture.asset(
            "assets/icons/miniRight.svg",
            colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
          ),
        ],
      ),
    );
  }
}
