import 'package:auto_route/annotations.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/screens/Products/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/favourites/bloc/favourites_bloc.dart';

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
      body: BlocBuilder<FavouritesBloc, FavouritesState>(
        builder: (context, state) {
          if (state is FavouritesLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is FavouritesLoaded) {
            if (state.favouriteProducts.isEmpty) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 250),
                  child: Text('Favourites is empty'),
                ),
              );
            }

            return ListView.builder(
              itemCount: state.favouriteProducts.length,
              itemBuilder: (context, index) {
                final product = state.favouriteProducts[index];
                return ListTile(
                  leading: Image.network(
                    product.images?.main?.src ?? '',
                    fit: BoxFit.cover,
                    width: 50,
                    height: 50,
                  ),
                  title: Text(product.name!),
                  subtitle: Text('${product.price}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProductDetailsScreen(),
                      ),
                    );
                  },
                  trailing: IconButton(
                    icon: const Icon(Icons.favorite, color: Colors.red),
                    onPressed: () {
                      // Handle remove from favourites logic here
                    },
                  ),
                );
              },
            );
          } else if (state is FavouritesError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
