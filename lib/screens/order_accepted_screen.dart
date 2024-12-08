import 'package:auto_route/auto_route.dart';
import 'package:e_commerce_app/blocs/orders/bloc/orders_bloc.dart';
import 'package:e_commerce_app/blocs/orders/bloc/orders_event.dart';
import 'package:e_commerce_app/components/checkout_modal.dart';
import 'package:e_commerce_app/router/router.gr.dart';
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
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                "You Order Has Been Accepted",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
              ),
            ),
            const Spacer(),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                "Your item has been placed and is on it's way to being processed",
                textAlign: TextAlign.center,
                style: TextStyle(
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
                text: 'Track order',
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
              child: const Text(
                "Back To Home",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
