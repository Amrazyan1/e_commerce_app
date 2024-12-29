import 'dart:developer';

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:e_commerce_app/Provider/main_provider.dart';
import 'package:e_commerce_app/components/added_to_cart_message_screen.dart';
import 'package:e_commerce_app/components/checkout_modal.dart';
import 'package:e_commerce_app/components/custom_modal_bottom_sheet.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/models/cart_products_response.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/screens/Products/product_details_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:super_cupertino_navigation_bar/super_cupertino_navigation_bar.dart';

import '../../../blocs/cart/bloc/cart_bloc.dart';
import '../../../components/network_image_with_loader.dart';
import '../../../router/router.gr.dart';
import '../../../services/api_service.dart';

@RoutePage()
class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final ApiService apiService = GetIt.I<ApiService>();

  void _increaseQuantity(String id) {
    context.read<CartBloc>().add(AddToCart(id: id));

    // setState(() {
    //   context.read<MainProvider>().cartProducts[index].quantity++;
    // });
  }

  void _decreaseQuantity(String id, int count) {
    if (count == 1) {
      context.read<CartBloc>().add(RemoveFromCart(id: id));
    } else {
      context.read<CartBloc>().add(ReduceFromCart(id: id));
    }
    // if (context.read<MainProvider>().cartProducts[index].quantity > 1) {
    //   setState(() {
    //     context.read<MainProvider>().cartProducts[index].quantity--;
    //   });
    // }
  }

  void gotoCheckout() async {
    log('gotoCheckout ----------------------------------------------------------------');
    context.read<CartBloc>().add(CartCreateOrder());
  }

  bool _isModalShown = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartBloc, CartState>(
      listener: (context, state) {
        if (state is CartPlaceOrderState && !_isModalShown) {
          _isModalShown = true; // Ensure modal is shown only once
          context.read<MainProvider>().isProcessOrder = false;
          customModalBottomSheet(
            context,
            isDismissible: true,
            child: CheckoutModal(
              data: state.vieworder,
            ),
          ).then((_) {
            // Reset the flag when the modal is dismissed
            _isModalShown = false;
          });
        }
        if (state is CartError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                duration: const Duration(seconds: 5),
                content: Text(state.message)),
          );
        }
      },
      child: WillPopScope(
        onWillPop: () async {
          final tabsRouter = AutoTabsRouter.of(context);
          if (tabsRouter.activeIndex != 0) {
            tabsRouter.setActiveIndex(0);
            return false;
          }
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor:
                Theme.of(context).colorScheme.background.withOpacity(.5),
            title: Text(
              'your_cart'.tr(),
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(fontWeight: FontWeight.w700, fontSize: 16),
            ),
          ),
          body: Column(
            children: [
              BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  if (state is CartLoading) {
                    return const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  if (state is CartLoaded) {
                    if (state.cartItems.isEmpty) {
                      return Expanded(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'empty_cart'.tr(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                'no_cart'.tr(),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    return Expanded(
                      child: Column(
                        children: [
                          // Add the row with "Clear All" text
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    context.read<CartBloc>().add(ClearCart());
                                  },
                                  child: Text(
                                    'clear_all'.tr(),
                                    style: const TextStyle(
                                      decoration: TextDecoration.underline,
                                      decorationColor:
                                          Colors.red, // Adds the underscore
                                      color: Colors
                                          .red, // Optional, for better visibility
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Add the ListView.builder below the row
                          Expanded(
                            child: ListView.builder(
                              shrinkWrap: false,
                              itemCount: state.cartItems.length,
                              itemBuilder: (context, index) {
                                final item = state.cartItems[index];
                                return _cartItem(item, context, index);
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return Container();
                },
              ),
              BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  if (state is CartLoaded) {
                    if (state.cartItems.isEmpty) {
                      return Container();
                    }
                    return Column(
                      children: [
                        Visibility(
                            visible: !state.orderable.orderAbleIs!,
                            child: Text('${state.orderable.description}')),
                        Visibility(
                          visible: state.orderable.orderAbleIs! == true &&
                              !state.deliveryDetails.deliveryDetailIs!,
                          child: Text(
                            tr('free_delivery',
                                args: ['${state.deliveryDetails.limit}']),
                            style: TextStyle(),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: SizedBox(
                            height: 64,
                            child: Material(
                              color: state.orderable.orderAbleIs!
                                  ? kprimaryColor
                                  : kprimaryColor.withOpacity(0.7),
                              clipBehavior: Clip.hardEdge,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(defaultBorderRadius),
                                ),
                              ),
                              child: InkWell(
                                onTap: state.orderable.orderAbleIs!
                                    ? gotoCheckout
                                    : null,
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 4,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: defaultPadding),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            BlocBuilder<CartBloc, CartState>(
                                              builder: (context, state) {
                                                if (state
                                                    is CartPlaceOrderStateLoading) {
                                                  return const Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  );
                                                }
                                                if (state is CartLoaded ||
                                                    state
                                                        is CartPlaceOrderState) {
                                                  state = state as CartLoaded;
                                                  return Text(
                                                    "go_check".tr() +
                                                        "(${state.total})",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleSmall!
                                                        .copyWith(
                                                            color:
                                                                Colors.white),
                                                  );
                                                }
                                                return const Center(
                                                  child:
                                                      CircularProgressIndicator(),
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
                    );
                  }
                  return Container();
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Dismissible _cartItem(CartProductItem item, BuildContext context, int index) {
    return Dismissible(
      key: Key(
          item.product!.name.toString()), // Ensure each item has a unique key
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        context.read<CartBloc>().add(RemoveFromCart(id: item.product!.id));
        // context.read<MainProvider>().removefromCart(item.product!);
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
          context.read<MainProvider>().currentProductModel = item.product!;
          // context.router.push(const ProductDetailsRoute());
          // AutoRouter.of(context).navigateNamed('cart/cart-product-details');

          AutoRouter.of(context).push(ProductDetailsRoute());
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
                  child: NetworkImageWithLoader(
                    item.product!.image!.src ?? '',
                    radius: 0,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.product!.name!,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${item.total}', //${item.product!.discount != '0 %' ? item.product!.discountedPrice : item.product!.price}
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () =>
                          _decreaseQuantity(item.product!.id!, item.count!),
                    ),
                    Text(
                      _getDisplayCount(item),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add, color: kprimaryColor),
                      onPressed: () => _increaseQuantity(item.product!.id!),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getDisplayCount(CartProductItem item) {
    final alternativeUnitName = item.product?.unit?.alternative?.name;
    final alternativeUnitValue = item.product?.unit?.alternative?.value;
    final itemCount = item.count;

    if (alternativeUnitName != null && alternativeUnitValue != null) {
      final parsedValue = num.tryParse(alternativeUnitValue);
      if (parsedValue != null) {
        return (parsedValue * itemCount!).toString() + alternativeUnitName;
      }
    }

    return itemCount.toString();
  }
}
