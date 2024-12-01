import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:e_commerce_app/blocs/orders/details/bloc/orderdetail_bloc.dart';
import 'package:e_commerce_app/blocs/orders/details/bloc/orderdetail_event.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/router/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/orders/bloc/orders_bloc.dart';
import '../blocs/orders/bloc/orders_state.dart';

@RoutePage()
class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'OrdersScreen',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: BlocBuilder<OrdersBloc, OrdersState>(
        builder: (context, state) {
          if (state is OrdersLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is OrdersLoaded) {
            final orders = state.ordersResponse.data ?? [];
            return ListView.builder(
              padding: const EdgeInsets.all(defaultPadding),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                final status = order.status ?? 'Unknown';
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
                    log('Go to order info for order ID: ${order.id}');
                    context
                        .read<OrderDetailBloc>()
                        .add(FetchOrderDetail(order.id!));
                    AutoRouter.of(context).push(const OrderInfoRoute());
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
                              Text(
                                order.method ?? 'Unknown Item',
                                style: const TextStyle(
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
                            children: [
                              Text(
                                order.address?.name ?? 'No Address',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          // Bottom row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                order.date ?? 'No Date',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                order.totalWithDelivery != null
                                    ? '\$${order.totalWithDelivery}'
                                    : 'No Total',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (state is OrdersError) {
            return Center(child: Text("Error: ${state.error}"));
          } else {
            return const Center(child: Text("No orders available."));
          }
        },
      ),
    );
  }
}
