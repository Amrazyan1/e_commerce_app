import 'package:auto_route/annotations.dart';
import 'package:e_commerce_app/Provider/main_provider.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/screens/Products/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Favourites',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        body: Column(
          children: [
            context.watch<MainProvider>().favouriteProducts.length < 1
                ? Center(
                    child: Padding(
                    padding: const EdgeInsets.only(top: 250),
                    child: Text('Favourites is empty'),
                  ))
                : Expanded(
                    child: ListView.builder(
                      itemCount: context
                          .watch<MainProvider>()
                          .favouriteProducts
                          .length,
                      itemBuilder: (context, index) {
                        final item = context
                            .watch<MainProvider>()
                            .favouriteProducts[index];
                        return GestureDetector(
                          onTap: () {
                            context.read<MainProvider>().currentProductModel =
                                item;

                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ProductDetailsScreen(),
                              ),
                            );
                          },
                          child: Card(
                            margin: EdgeInsets.all(8.0),
                            child: ListTile(
                              leading: Image.network(item.imageUrl),
                              title: Text(item.title),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item.title),
                                  // Text(
                                  //     '\$${(item.price * item.quantity).toStringAsFixed(2)}'),
                                ],
                              ),
                              trailing: Container(
                                child: IconButton(
                                  icon: Icon(Icons.clear),
                                  onPressed: () {
                                    context
                                        .read<MainProvider>()
                                        .addToFavourites(item);
                                    context
                                        .read<MainProvider>()
                                        .fakeNotifyListener();
                                  },
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ));
  }
}
