import 'package:auto_route/annotations.dart';
import 'package:e_commerce_app/Provider/main_provider.dart';
import 'package:e_commerce_app/screens/Discover/views/filter_screen.dart';
import 'package:e_commerce_app/screens/Products/Components/product_card.dart';
import 'package:e_commerce_app/screens/Products/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../blocs/categorydetails/bloc/category_detail_bloc.dart';
import '../../../blocs/categorydetails/bloc/category_detail_state.dart';

@RoutePage()
class DiscoverDetailsScreen extends StatelessWidget {
  // final List<Product> products;
  const DiscoverDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: true,
        title: Text(
          context.watch<MainProvider>().categoryName,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => FilterScreen(),
                ),
              );
            },
            icon: SvgPicture.asset("assets/icons/filter.svg",
                color: Theme.of(context).textTheme.bodyLarge!.color),
          ),
        ],
      ),
      body: BlocBuilder<CategoryDetailBloc, CategoryDetailState>(
        builder: (context, state) {
          if (state is CategoryDetailLoaded) {
            final products = state.products;
            return Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 8.0,
                        crossAxisSpacing: 8.0,
                        childAspectRatio: 140 / 220, // Match item dimensions
                      ),
                      itemCount: state.products.length,
                      itemBuilder: (context, index) {
                        return ProductCard(
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
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          } else if (state is CategoryDetailLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is CategoryDetailError) {
            return Center(
              child: Text(state.message),
            );
          }
          return Container();
        },
      ),
    );
  }
}
