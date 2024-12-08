import 'package:auto_route/auto_route.dart';
import 'package:e_commerce_app/blocs/orders/bloc/orders_bloc.dart';
import 'package:e_commerce_app/blocs/orders/bloc/orders_event.dart';
import 'package:e_commerce_app/components/checkout_modal.dart';
import 'package:e_commerce_app/router/router.gr.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OrderAcceptedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(
              flex: 10,
            ),
            SizedBox(
                width: 200,
                height: 200,
                child: Image.asset("assets/Illustration/success.png")),
            const Spacer(
              flex: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'order_accepted'.tr(),
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'order_accepted_info'.tr(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xff7C7C7C),
                    fontWeight: FontWeight.w600),
              ),
            ),
            const Spacer(
              flex: 8,
            ),
            SizedBox(
              height: 50,
              child: ButtonMainWidget(
                text: 'order_track'.tr(),
                callback: () {
                  Navigator.pop(context);
                  context.read<OrdersBloc>().add(FetchOrders());

                  AutoRouter.of(context)
                      .navigate(const EmptyRouter(children: [OrdersRoute()]));
                },
              ),
            ),
            const Spacer(
              flex: 2,
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Text(
                'back_to_home'.tr(),
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const Spacer(
              flex: 10,
            ),
          ],
        ),
      ),
    );
  }
}
