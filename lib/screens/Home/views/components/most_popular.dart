import 'dart:developer';

import 'package:e_commerce_app/Provider/main_provider.dart';
import 'package:e_commerce_app/screens/Products/Components/secondary_product_card.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/screens/Products/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../blocs/products/popular/bloc/popular_products_bloc.dart';

class MostPopular extends StatelessWidget {
  const MostPopular({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: defaultPadding / 2),
        Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Text(
            "Most popular",
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        // SeconderyProductsSkelton(),
        BlocBuilder<PopularProductsBloc, PopularProductsState>(
          builder: (context, state) {
            if (state is PopularProductsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PopularProductsError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    duration: const Duration(seconds: 15),
                    content: Text(state.message)),
              );
            } else if (state is PopularProductsLoaded) {
              final products = state.products;
              if (products.isEmpty) {
                return SizedBox(
                  height: 114,
                  child: ListView.builder(
                      itemCount: 5,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return ShimmerProductWidget();
                      }),
                );
              }
              return SizedBox(
                height: 114,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: products.length,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(
                      left: defaultPadding,
                      right: index == products.length - 1 ? defaultPadding : 0,
                    ),
                    child: SecondaryProductCard(
                      key: ValueKey(products[index].id),
                      image: products[index].images!.main!.src!,
                      brandName: products[index].name!,
                      title: products[index].description!,
                      price: products[index].price!,
                      priceAfetDiscount: products[index].discountedPrice,
                      dicountpercent: products[index].discount,
                      press: () {
                        context.read<MainProvider>().currentProductModel =
                            products[index];
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const ProductDetailsScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            }
            return Container();
          },
        )
      ],
    );
  }
}

class ShimmerProductWidget extends StatelessWidget {
  const ShimmerProductWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(256, 114),
          maximumSize: const Size(256, 114),
          padding: const EdgeInsets.all(8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          side: const BorderSide(
            color: Color.fromARGB(66, 124, 124, 124),
            width: 1, // Optional: You can adjust the border width here
          ),
        ),
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 1.15,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(
                            Radius.circular(defaultBorderRadious))),
                  )
                ],
              ),
            ),
            const SizedBox(width: defaultPadding / 4),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(defaultPadding / 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 10,
                      width: 80,
                      margin: const EdgeInsets.only(bottom: defaultPadding / 2),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(height: defaultPadding / 2),
                    Container(
                      height: 12,
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: defaultPadding / 2),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      height: 12,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
