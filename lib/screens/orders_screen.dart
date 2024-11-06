import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/router/router.gr.dart';
import 'package:e_commerce_app/screens/order_info_screen.dart';
import 'package:flutter/material.dart';

@RoutePage()
class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  // List of statuses for demo purposes

  @override
  Widget build(BuildContext context) {
    final List<String> statuses = [
      'Success',
      'Success',
      'Pending',
      'Success',
      'Not Delivered',
      'Pending',
      'Not Delivered',
      'Pending',
      'Not Delivered',
      'Success',
    ];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'OrdersScreen',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(defaultPadding),
        itemCount: statuses.length,
        itemBuilder: (context, index) {
          final status = statuses[index];
          Color containerColor;

          // Determine container color based on status
          switch (status) {
            case 'Success':
              containerColor = Colors.lightGreen[100]!;
              break;
            case 'Pending':
              containerColor = Colors.orange[100]!;
              break;
            case 'Not Delivered':
              containerColor = Colors.red[100]!;
              break;
            default:
              containerColor = Colors.grey[200]!;
          }

          return GestureDetector(
            onTap: () {
              log('go to order info ');
              AutoRouter.of(context).push(OrderInfoRoute());
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Container(
                height: 81,
                decoration: BoxDecoration(
                  color: containerColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Top row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Apple, Peach, Juice ......',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          status,
                          style: TextStyle(
                            color: status == 'Success'
                                ? Colors.green
                                : status == 'Pending'
                                    ? Colors.orange
                                    : Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    // Middle row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Text(
                          '123 Main Street, City',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                    // Bottom row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          '01.01.2024 10:25',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        Text(
                          'Card **59',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
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
