import 'package:auto_route/auto_route.dart';
import 'package:e_commerce_app/blocs/orders/bloc/orders_bloc.dart';
import 'package:e_commerce_app/blocs/orders/bloc/orders_event.dart';
import 'package:e_commerce_app/components/checkout_modal.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../blocs/orders/details/bloc/orderdetail_bloc.dart';
import '../blocs/orders/details/bloc/orderdetail_event.dart';
import '../blocs/orders/details/bloc/orderdetail_state.dart';

@RoutePage()
class OrderInfoScreen extends StatelessWidget {
  const OrderInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample product data
    void cancelOrder(String orderId, bool isReversable) {
      context.read<OrderDetailBloc>().add(CancelOrderEvent(orderId, isReversable));
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'order_info'.tr(),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: BlocListener<OrderDetailBloc, OrderDetailState>(
        listener: (context, state) {
          if (state is OrderDetailError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );

            AutoRouter.of(context).maybePop();
          }
          if (state is OrderDetailLoaded) {
            if (state.orderDetail == null) {
              context.read<OrdersBloc>().add(FetchOrders());

              AutoRouter.of(context).maybePop();
            }
          }
        },
        child: BlocBuilder<OrderDetailBloc, OrderDetailState>(
          builder: (context, state) {
            if (state is OrderDetailLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is OrderDetailLoaded || state is OrderDetailLoadingCancle) {
              if ((state as OrderDetailLoaded).orderDetail == null) {
                return Container();
              }
              final products = (state as OrderDetailLoaded).orderDetail!.data!.items!;
              return ListView.builder(
                padding: const EdgeInsets.all(defaultPadding),
                itemCount: products.length + 1, // Products + summary info
                itemBuilder: (context, index) {
                  if (index < products.length) {
                    final product = products[index];
                    return SizedBox(
                      height: 70,
                      child: Row(
                        children: [
                          Image.network(
                            product.product?.images?.main?.src ?? '',
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                'assets/images/placeholder.png', // Path to your fallback image
                                height: 50,
                                width: 50,
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AutoSizeText(
                                  product.product?.name.toString() ?? 'Product name',
                                  maxLines: 2,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12, // Max font size
                                  ),
                                  minFontSize: 8, // Minimum font size
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Flexible(
                                  child: Text(
                                    overflow: TextOverflow.ellipsis,
                                    product.product?.description ?? 'Description',
                                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'x${product.count}',
                                style: const TextStyle(fontSize: 14),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                product.product?.price ?? 'Price',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  } else {
                    final orderData = state.orderDetail?.data;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildInfoRow('delivery', '${orderData?.addresses?[0].name}'),
                        _buildInfoRow('payment'.tr(), '${orderData?.method}'),
                        _buildInfoRow('total_cost', '${orderData?.totalWithDelivery ?? 'Total'}'),
                        _buildInfoRow('date', '${orderData?.date ?? 'Date'}'),
                        _buildInfoRow('status', '${orderData?.status ?? 'Status'}'),
                        Visibility(
                          visible: orderData?.isCancelable ?? false,
                          child: SizedBox(
                            height: 50,
                            child: Row(
                              children: [
                                // Expanded(
                                //     child: ButtonMainWidget(text: 'Order Again')),
                                // Gap(10),
                                Expanded(
                                    child: ButtonMainWidget(
                                  text: 'cancel_order'.tr(),
                                  customwidget: state is OrderDetailLoadingCancle
                                      ? const CircularProgressIndicator()
                                      : null,
                                  callback: () {
                                    cancelOrder(orderData!.id!, false);
                                  },
                                )),
                              ],
                            ),
                          ),
                        ),
                        Visibility(
                          visible: orderData?.isReversable ?? false,
                          child: SizedBox(
                            height: 50,
                            child: Row(
                              children: [
                                // Expanded(
                                //     child: ButtonMainWidget(text: 'Order Again')),
                                // Gap(10),
                                Expanded(
                                    child: ButtonMainWidget(
                                  text: 'refund_order'.tr(),
                                  customwidget: state is OrderDetailLoadingCancle
                                      ? const CircularProgressIndicator()
                                      : null,
                                  callback: () {
                                    cancelOrder(orderData!.id!, true);
                                  },
                                )),
                              ],
                            ),
                          ),
                        )
                      ],
                    );
                  }
                },
              );
            }
            return const Center(child: Text('Empty'));
          },
        ),
      ),
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title.tr(),
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const Gap(40),
                Flexible(
                  child: Text(
                    value,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                    overflow: TextOverflow.ellipsis, // Add this to show ellipsis
                    maxLines: 1, // Ensure it doesn't exceed one line
                  ),
                ),
              ],
            ),
          ),
          const Divider()
        ],
      ),
    );
  }
}
