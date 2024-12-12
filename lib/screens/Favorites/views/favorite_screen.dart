import 'package:auto_route/annotations.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/screens/Products/product_details_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cupertino_navigation_bar/super_cupertino_navigation_bar.dart';

import '../../../Provider/main_provider.dart';
import '../../../blocs/favourites/bloc/favourites_bloc.dart';

@RoutePage()
class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        
        automaticallyImplyLeading: false,
        backgroundColor:
            Theme.of(context).colorScheme.background.withOpacity(.5),
        title: Text(
          'favorite'.tr(),
          style: Theme.of(context)
              .textTheme
              .labelMedium!
              .copyWith(fontWeight: FontWeight.w700, fontSize: 16),
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
              return Center(
                child: Text('empty_fav'.tr()),
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
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/images/placeholder.png', // Path to your fallback image
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                  title: Text(product.name!),
                  subtitle: Text('${product.price}'),
                  onTap: () {
                    context.read<MainProvider>().currentProductModel = product;
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
                      context
                          .read<FavouritesBloc>()
                          .add(RemoveFavouritesEvent(product.id));
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
