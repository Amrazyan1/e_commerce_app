import 'package:e_commerce_app/Provider/main_provider.dart';
import 'package:e_commerce_app/components/network_image_with_loader.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/Product/product_model.dart';
import '../../../models/cart_products_response.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    super.key,
    required this.product,
    required this.press,
  });
  final Product product;

  final VoidCallback press;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isAddedToCart = false;

  void addToCart() async {
    CartProductItem? cardProdItem =
        await context.read<MainProvider>().addToCartById(widget.product.id);
    if (cardProdItem != null) {
      setState(() {
        isAddedToCart = true;
      });

      // Revert back to the initial state after a delay
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            isAddedToCart = false;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: widget.press,
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(140, 220),
        maximumSize: const Size(140, 220),
        padding: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        side: const BorderSide(
          color: Color.fromARGB(66, 124, 124, 124),
          width: 1, // Optional: You can adjust the border width here
        ), // Set radius to 15
      ),
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1.15,
            child: Stack(
              children: [
                NetworkImageWithLoader(widget.product.images!.main!.src!,
                    radius: defaultBorderRadius),
                if (widget.product.discount != null)
                  Positioned(
                    right: defaultPadding / 2,
                    top: defaultPadding / 2,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: defaultPadding / 2),
                      height: 16,
                      decoration: const BoxDecoration(
                        color: errorColor,
                        borderRadius: BorderRadius.all(
                            Radius.circular(defaultBorderRadius)),
                      ),
                      child: Text(
                        "${widget.product.discount} off",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  )
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: defaultPadding / 2, vertical: defaultPadding / 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.name!.toUpperCase(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: defaultPadding / 4),
                  Flexible(
                    child: Text(
                      widget.product.description ?? '',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontSize: 10),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: widget.product.discountedPrice != null
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${widget.product.discountedPrice}",
                                    style: const TextStyle(
                                      color: ksecondaryColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                    ),
                                  ),
                                  // const SizedBox(width: defaultPadding / 4),
                                  Text(
                                    widget.product.price!,
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .color,
                                      fontSize: 10,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                ],
                              )
                            : Text(
                                widget.product.price!,
                                style: const TextStyle(
                                  color: ksecondaryColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                ),
                              ),
                      ),
                      Container(
                        width: 35,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: ksecondaryColor,
                        ),
                        child: Center(
                          child: IconButton(
                            icon: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              child: isAddedToCart
                                  ? const Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      key: ValueKey('checkIcon'),
                                    )
                                  : const Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      key: ValueKey('addIcon'),
                                    ),
                            ),
                            padding: EdgeInsets.zero,
                            onPressed: addToCart,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
