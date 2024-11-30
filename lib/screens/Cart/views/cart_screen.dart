import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:e_commerce_app/Provider/main_provider.dart';
import 'package:e_commerce_app/components/added_to_cart_message_screen.dart';
import 'package:e_commerce_app/components/checkout_modal.dart';
import 'package:e_commerce_app/components/custom_modal_bottom_sheet.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/screens/Products/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cupertino_navigation_bar/super_cupertino_navigation_bar.dart';

import '../../../blocs/cart/bloc/cart_bloc.dart';

@RoutePage()
class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void _increaseQuantity(int index) {
    // setState(() {
    //   context.read<MainProvider>().cartProducts[index].quantity++;
    // });
  }

  void _decreaseQuantity(int index) {
    // if (context.read<MainProvider>().cartProducts[index].quantity > 1) {
    //   setState(() {
    //     context.read<MainProvider>().cartProducts[index].quantity--;
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    return SuperScaffold(
      appBar: SuperAppBar(
        searchBar: SuperSearchBar(
          enabled: false,
        ),
        backgroundColor:
            Theme.of(context).colorScheme.background.withOpacity(.5),
        title: Text(
          'Cart',
          style: Theme.of(context)
              .textTheme
              .labelMedium!
              .copyWith(fontWeight: FontWeight.w700, fontSize: 16),
        ),
        largeTitle: SuperLargeTitle(
          largeTitle: 'Cart',
          textStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 24,
                letterSpacing: 0,
              ),
        ),
      ),
      body: Column(
        children: [
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              if (state is CartLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is CartLoaded) {
                if (state.cartItems.isEmpty) {
                  return const Center(
                    child: Text('There is no cart items'),
                  );
                }
                return Expanded(
                  child: ListView.builder(
                    itemCount: state.cartItems.length,
                    itemBuilder: (context, index) {
                      final item = state.cartItems[index];
                      return Dismissible(
                        key: Key(item.product!.name
                            .toString()), // Ensure each item has a unique key
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) {
                          context
                              .read<MainProvider>()
                              .removefromCart(item.product!);
                        },
                        background: Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          color: Colors.red,
                          child: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            context.read<MainProvider>().currentProductModel =
                                item.product!;

                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    const ProductDetailsScreen(),
                              ),
                            );
                          },
                          child: Card(
                            margin: const EdgeInsets.all(8.0),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Leading Image
                                  SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: Image.network(
                                      item.product!.images?.main?.src ??
                                          'https://via.placeholder.com/50',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  // Title and Subtitle
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.product!.name!,
                                          // style: Theme.of(context)
                                          //     .textTheme
                                          //     .subtitle1,
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          '\$${item.product!.price}',
                                          // style: Theme.of(context)
                                          //     .textTheme
                                          //     .bodyText2!
                                          //     .copyWith(color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Trailing Actions
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.remove),
                                        onPressed: () =>
                                            _decreaseQuantity(index),
                                      ),
                                      Text('${item.count}'),
                                      IconButton(
                                        icon: const Icon(Icons.add,
                                            color: kprimaryColor),
                                        onPressed: () =>
                                            _increaseQuantity(index),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
              return Center(
                child: Text('Cart Load error ${(state as CartError).message}'),
              );
            },
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  height: 64,
                  child: Material(
                    color: kprimaryColor,
                    clipBehavior: Clip.hardEdge,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(defaultBorderRadius),
                      ),
                    ),
                    child: InkWell(
                      onTap: () {
                        customModalBottomSheet(
                          context,
                          isDismissible: true,
                          child: const CheckoutModal(),
                        );
                      },
                      child: Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: defaultPadding),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  BlocBuilder<CartBloc, CartState>(
                                    builder: (context, state) {
                                      if (state is CartLoaded) {
                                        return Text(
                                          "Go To Checkout (${state.total})",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(color: Colors.white),
                                        );
                                      }
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
