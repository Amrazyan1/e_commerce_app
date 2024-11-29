import 'dart:developer';

import 'package:e_commerce_app/Provider/main_provider.dart';
import 'package:e_commerce_app/blocs/favourites/bloc/favourites_bloc.dart';
import 'package:e_commerce_app/screens/Products/Components/product_availability_tag.dart';
import 'package:e_commerce_app/screens/Products/Components/quantity_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';

class ProductInfo extends StatelessWidget {
  const ProductInfo({
    super.key,
    required this.productId,
    required this.title,
    required this.brand,
    required this.description,
    required this.rating,
    required this.numOfReviews,
    required this.isAvailable,
    required this.price,
  });
  final String productId;
  final String title, brand, description;
  final double rating;
  final int numOfReviews;
  final bool isAvailable;
  final String price;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(defaultPadding),
      sliver: SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(brand.toUpperCase(),
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontWeight: FontWeight.bold)),
                ),
                GestureDetector(
                  onTap: () {
                    log('IS favorite true');
                    context
                        .read<FavouritesBloc>()
                        .add(AddToFavouritesEvent(productId));
                  },
                  child: const Icon(
                    // context
                    //         .watch<MainProvider>()
                    //         .currentProductModel
                    //         .isFavourite
                    true ? Icons.favorite : Icons.favorite_border_outlined,
                    color: kprimaryColor,
                  ),
                )
              ],
            ),
            const SizedBox(height: defaultPadding / 2),
            Text(
              title,
              maxLines: 2,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: Colors.black.withOpacity(0.5)),
            ),
            const SizedBox(height: defaultPadding),
            Row(
              children: [
                // ProductAvailabilityTag(isAvailable: isAvailable),
                QuantityWidget(
                  initialCount: 1,
                  callback: (value) {},
                ),
                const Spacer(),
                const SizedBox(width: defaultPadding / 4),
                Text(
                  "$price ",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),
            const SizedBox(height: defaultPadding),
            Text(
              "Product info",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: defaultPadding / 2),
            Text(
              description,
              style: const TextStyle(height: 1.4),
            ),
            const SizedBox(height: defaultPadding / 2),
          ],
        ),
      ),
    );
  }
}
