import 'package:auto_route/annotations.dart';
import 'package:e_commerce_app/Provider/main_provider.dart';
import 'package:e_commerce_app/components/search_bar_input_field.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/screens/Discover/views/filter_screen.dart';
import 'package:e_commerce_app/screens/Products/Components/product_card.dart';
import 'package:e_commerce_app/screens/Products/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../models/Product/product_model.dart';

@RoutePage()
class DiscoverDetailsScreen extends StatelessWidget {
  final List<Product> products;
  const DiscoverDetailsScreen({super.key, required this.products});

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
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: GridView.builder(
                physics: BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                  childAspectRatio: 140 / 220, // Match item dimensions
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return ProductCard(
                    id: products[index].id,
                    image: products[index].images?.main?.src ?? '',
                    brandName: products[index].name!,
                    title: products[index].description!,
                    priceAfetDiscount: products[index].discountedPrice!,
                    dicountpercent: '${products[index].discount}',
                    press: () {
                      context.read<MainProvider>().currentProductModel =
                          products[index];
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ProductDetailsScreen(),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
