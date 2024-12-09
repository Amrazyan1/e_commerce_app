import 'dart:developer';

import 'package:e_commerce_app/Provider/main_provider.dart';
import 'package:e_commerce_app/screens/Products/Components/secondary_product_card.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/screens/Products/product_details_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../blocs/products/popular/bloc/popular_products_bloc.dart';
import '../../../../components/Shimmers/product_shimmer_landscape.dart';

class MostPopular extends StatelessWidget {
  const MostPopular({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<PopularProductsBloc, PopularProductsState>(
      listener: (context, state) {
        if (state is PopularProductsError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                duration: const Duration(seconds: 15),
                content: Text(state.message)),
          );
        }
      },
      child: BlocBuilder<PopularProductsBloc, PopularProductsState>(
        builder: (context, state) {
          if (state is PopularProductsLoaded) {
            final products = state.products;
            if (products.isEmpty) {
              return Container();
            }
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: defaultPadding / 2),
              Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Text(
                  "mostpopular".tr(),
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              // SeconderyProductsSkelton(),
              BlocBuilder<PopularProductsBloc, PopularProductsState>(
                builder: (context, state) {
                  if (state is PopularProductsLoading) {
                    return SizedBox(
                      height: 114,
                      child: ListView.builder(
                          itemCount: 5,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return const ShimmerProductWidget();
                          }),
                    );
                  } else if (state is PopularProductsError) {
                    return SizedBox(
                      height: 114,
                      child: ListView.builder(
                          itemCount: 5,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return const ShimmerProductWidget();
                          }),
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
                              return const ShimmerProductWidget();
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
                            right: index == products.length - 1
                                ? defaultPadding
                                : 0,
                          ),
                          child: SecondaryProductCard(
                            key: ValueKey(products[index].id),
                            image: products[index].images!.main!.src ?? '',
                            brandName: products[index].name!,
                            title: products[index].description ?? '',
                            price: products[index].price!,
                            priceAfetDiscount: products[index].discountedPrice,
                            dicountpercent: products[index].discount,
                            press: () {
                              context.read<MainProvider>().currentProductModel =
                                  products[index];
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ProductDetailsScreen(),
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
        },
      ),
    );
  }
}
