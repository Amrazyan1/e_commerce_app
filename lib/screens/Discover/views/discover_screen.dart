import 'dart:developer';

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:e_commerce_app/Provider/main_provider.dart';
import 'package:e_commerce_app/blocs/categories/bloc/categories_event.dart';
import 'package:e_commerce_app/components/search_bar_input_field.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/models/category_model_real.dart';
import 'package:e_commerce_app/router/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:super_cupertino_navigation_bar/super_cupertino_navigation_bar.dart';

import '../../../blocs/categories/bloc/categories_bloc.dart';
import '../../../blocs/categories/bloc/categories_state.dart';
import '../../../blocs/categorydetails/bloc/category_detail_bloc.dart';
import '../../../blocs/categorydetails/bloc/category_detail_event.dart';
import '../../../models/Product/product_model.dart';

@RoutePage()
class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final List<List<Category>> _categoryStack =
      []; // Stack to keep track of navigation
  final _searchFocusNode = FocusNode();

  final _searchTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocListener<CategoriesBloc, CategoriesState>(
      listener: (context, state) {
        if (state is CategoriesLoaded) {
          if (state.products.isNotEmpty) {
            //            context.read<MainProvider>().categoryName =
            // category.name ?? 'Unknown';
            AutoRouter.of(context).push(const DiscoverDetailsRoute());
          }
        }
      },
      child: WillPopScope(
        onWillPop: _handleBackNavigation,
        child: SuperScaffold(
          appBar: SuperAppBar(
            backgroundColor:
                Theme.of(context).colorScheme.background.withOpacity(.5),
            title: Text(
              'Find products',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(fontWeight: FontWeight.w700, fontSize: 16),
            ),
            largeTitle: SuperLargeTitle(
              largeTitle: 'Find products',
              textStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                    letterSpacing: 0,
                  ),
            ),

            // actions: IconButton(
            //   icon: Container(
            //     width: 28,
            //     height: 28,
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(16),
            //       color: Theme.of(context).colorScheme.onPrimary,
            //     ),
            //     child: Icon(
            //       Icons.plus_one,
            //       size: 18,
            //       color: Theme.of(context).colorScheme.background,
            //     ),
            //   ),
            //   onPressed: () {},
            // ),
            searchBar: SuperSearchBar(
              searchFocusNode: _searchFocusNode,
              searchController: _searchTextController,
              textStyle: Theme.of(context).textTheme.bodyLarge!,
              onFocused: (value) {
                if (!value) {}
              },
              cancelTextStyle: Theme.of(context).textTheme.bodyLarge!,
              onChanged: (value) {},
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: BlocBuilder<CategoriesBloc, CategoriesState>(
                    builder: (context, state) {
                      if (state is CategoriesLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is CategoriesLoaded) {
                        return GridView.builder(
                          physics: const BouncingScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 8.0,
                            crossAxisSpacing: 8.0,
                            childAspectRatio: 174.5 / 189,
                          ),
                          itemCount: state.categories.length,
                          itemBuilder: (context, index) {
                            final category = state.categories[index];
                            final products = state.products;

                            return _categoryItem(
                              category: category,
                              productList: products,
                            );
                          },
                        );
                      } else if (state is CategoriesError) {
                        return Center(child: Text('Error: ${state.error}'));
                      }
                      return const Center(child: Text('No Data'));
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _handleBackNavigation() async {
    log('${_categoryStack.length}');
    if (_categoryStack.length > 1) {
      _categoryStack.removeLast(); // Remove current category
      final previousCategories = _categoryStack.last;

      context.read<CategoriesBloc>().add(
            FetchSubcategories(
                previousCategories.first), // Go back to previous category
          );

      return false; // Prevent the app from closing
    }
    return true; // Allow the app to close
  }
}

class _categoryItem extends StatelessWidget {
  const _categoryItem(
      {super.key, required this.category, required this.productList});

  final Category category;
  final List<Product> productList;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if ((category.subcategories ?? []).isNotEmpty) {
          AutoRouter.of(context).push(const DiscoverRoute());
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (_) => DiscoverScreen(
          //         // categories: category.subcategories, // Pass subcategories
          //         ),
          //   ),
          // );
          context.read<CategoriesBloc>().add(FetchSubcategories(category));
        } else if (category.productsCount! > 0) {
          context.read<MainProvider>().categoryName =
              category.name ?? 'Unknown';
          context
              .read<CategoryDetailBloc>()
              .add(FetchCategoryProductsEvent(id: category.id!));
          AutoRouter.of(context).push(const DiscoverDetailsRoute());
        } else {
          // if (category.productsCount! > 0) {
          //   context.read<CategoriesBloc>().add(FetchSubcategories(category));
          // } else
          {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${category.name} has no subcategories')),
            );
          }
        }
      },
      child: Container(
        width: 174.5,
        height: 189,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: ksecondaryColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFD2B7E5)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildImage(category.image),
            const SizedBox(height: 10),
            Flexible(
              child: Text(
                category.name ?? 'Unknown',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
                maxLines: 3, // Limit the number of lines
                overflow:
                    TextOverflow.ellipsis, // Add ellipsis if text overflows
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(String? imageUrl) {
    if (imageUrl == null || imageUrl.isEmpty) {
      return const Icon(Icons.image_not_supported, size: 60);
    }

    if (imageUrl.endsWith('.svg')) {
      return SvgPicture.network(
        imageUrl,
        width: 60,
        height: 60,
        placeholderBuilder: (context) => const CircularProgressIndicator(),
        // errorBuilder: (context, error, stackTrace) =>
        //     const Icon(Icons.error, size: 60),
      );
    } else {
      return Image.network(
        imageUrl,
        width: 60,
        height: 60,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) =>
            const Icon(Icons.error, size: 60),
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          return const CircularProgressIndicator();
        },
      );
    }
  }
}
