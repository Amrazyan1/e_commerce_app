import 'package:e_commerce_app/Provider/main_provider.dart';
import 'package:e_commerce_app/components/Shimmers/product_shimmer_portrait.dart';
import 'package:e_commerce_app/screens/Products/Components/product_card.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/screens/Products/product_details_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/products/trending/bloc/trend_new_products_bloc.dart';

class PopularProducts extends StatelessWidget {
  const PopularProducts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<TrendNewProductsBloc, TrendNewProductsState>(
      listener: (context, state) {
        if (state is TrendNewProductsError) {
          // Show a SnackBar when there's an error
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: BlocBuilder<TrendNewProductsBloc, TrendNewProductsState>(
        builder: (context, state) {
          if (state is TrendNewProductsLoaded) {
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
                  "popular".tr(),
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              BlocBuilder<TrendNewProductsBloc, TrendNewProductsState>(
                builder: (context, state) {
                  if (state is TrendNewProductsLoading) {
                    return SizedBox(
                      height: 220,
                      child: ListView.builder(
                          itemCount: 5,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return const ShimmerProductPortrait();
                          }),
                    );
                  } else if (state is TrendNewProductsError) {
                    return SizedBox(
                      height: 220,
                      child: ListView.builder(
                          itemCount: 5,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return const ShimmerProductPortrait();
                          }),
                    );
                  } else if (state is TrendNewProductsLoaded) {
                    final products = state.products;

                    return SizedBox(
                      height: 220,
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
                          child: ProductCard(
                            product: products[index],
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
