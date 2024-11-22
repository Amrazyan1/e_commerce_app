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

  double _calculateTotal() {
    return 0;
    // return context.read<MainProvider>().cartProducts.fold(
    //       0,
    //       (sum, item) => sum + (item.price * item.quantity),
    //     );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Cart',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: context.watch<MainProvider>().cartProducts.length,
              itemBuilder: (context, index) {
                final item = context.read<MainProvider>().cartProducts[index];
                return Dismissible(
                  key: Key(item.name
                      .toString()), // Ensure each item has a unique key
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    context.read<MainProvider>().removefromCart(item);
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
                      context.read<MainProvider>().currentProductModel = item;

                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ProductDetailsScreen(),
                        ),
                      );
                    },
                    child: Card(
                      margin: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: Image.network(item.images?.main?.src ?? ''),
                        title: Text(item.name!),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.name!),
                            Text('\$${(item.price)}'),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: () => _decreaseQuantity(index),
                            ),
                            Text('${item.count}'),
                            IconButton(
                              icon: const Icon(
                                Icons.add,
                                color: kprimaryColor,
                              ),
                              onPressed: () => _increaseQuantity(index),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
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
                        Radius.circular(defaultBorderRadious),
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
                                  Text(
                                    "Go To Checkout (${_calculateTotal().toStringAsFixed(2)} ֏)",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(color: Colors.white),
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

class CartItem {
  final String imageUrl;
  final String title;
  final String info;
  final double price;
  int quantity;

  CartItem({
    required this.imageUrl,
    required this.title,
    required this.info,
    required this.price,
    this.quantity = 1,
  });
}
