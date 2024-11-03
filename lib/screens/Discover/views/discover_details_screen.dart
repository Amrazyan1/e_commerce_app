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

@RoutePage()
class DiscoverDetailsScreen extends StatelessWidget {
  const DiscoverDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
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
                itemCount: demoPopularProducts.length,
                itemBuilder: (context, index) {
                  return ProductCard(
                    image: demoPopularProducts[index].imageUrl,
                    brandName: demoPopularProducts[index].brandName,
                    title: demoPopularProducts[index].title,
                    price: demoPopularProducts[index].price,
                    priceAfetDiscount:
                        demoPopularProducts[index].priceAfetDiscount,
                    dicountpercent: demoPopularProducts[index].dicountpercent,
                    press: () {
                      context.read<MainProvider>().currentProductModel =
                          demoPopularProducts[index];
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ProductDetailsScreen(),
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
