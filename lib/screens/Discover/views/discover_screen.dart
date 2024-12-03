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
import 'package:gap/gap.dart';
import 'package:super_cupertino_navigation_bar/super_cupertino_navigation_bar.dart';

import '../../../blocs/categories/bloc/categories_bloc.dart';
import '../../../blocs/categories/bloc/categories_state.dart';
import '../../../blocs/categorydetails/bloc/category_detail_bloc.dart';
import '../../../blocs/categorydetails/bloc/category_detail_event.dart';
import '../../../blocs/categorydetails/bloc/category_detail_state.dart';
import '../../../blocs/search/bloc/global_search_bloc.dart';
import '../../../models/Product/product_model.dart';
import '../../Products/Components/product_card.dart';
import '../../Products/product_details_screen.dart';

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

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    log('onscroll');
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100) {
      // Close to the end of the scroll
      log('onscroll +++++');

      if (!context.read<MainProvider>().isLoadingMore) {
        if (context.read<CategoryDetailBloc>().categoryId.isEmpty) {
          return;
        }
        context.read<MainProvider>().isLoadingMore = true;

        context.read<CategoryDetailBloc>().add(FetchCategoryProductsEvent(
            id: context.read<CategoryDetailBloc>().categoryId, page: 1));
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CategoriesBloc, CategoriesState>(
      listener: (context, state) {
        if (state is CategoriesLoaded) {
          if (state.products.isNotEmpty) {
            AutoRouter.of(context).push(const DiscoverDetailsRoute());
          }
        }
      },
      child: WillPopScope(
        onWillPop: _handleBackNavigation,
        child: SuperScaffold(
          key: Key('discvoer'),
          appBar: SuperAppBar(
            automaticallyImplyLeading: false,
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
            searchBar: SuperSearchBar(
              searchFocusNode: _searchFocusNode,
              searchController: _searchTextController,
              textStyle: Theme.of(context).textTheme.bodyLarge!,
              onFocused: (value) {
                if (!value) {}
              },
              onSubmitted: (value) {
                context.read<GlobalSearchBloc>().add(PerformGlobalSearch(
                      keyword: value,
                      perPage: 20,
                    ));
              },
              cancelTextStyle: Theme.of(context).textTheme.bodyLarge!,
              onChanged: (value) {},
              searchResult: BlocBuilder<GlobalSearchBloc, GlobalSearchState>(
                builder: (context, state) {
                  if (state is GlobalSearchLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is GlobalSearchLoaded) {
                    // Display results in a GridView
                    return Padding(
                      padding: const EdgeInsets.all(defaultPadding),
                      child: GridView.builder(
                        itemCount:
                            state.results.data!.products!.data!.data!.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 8.0,
                          crossAxisSpacing: 8.0,
                          childAspectRatio: 140 / 220, // Match item dimensions
                        ),
                        itemBuilder: (context, index) {
                          final product =
                              state.results.data!.products!.data!.data![index];
                          return ProductCard(
                            product: product,
                            press: () {
                              _searchFocusNode.requestFocus();
                              Future.delayed(const Duration(milliseconds: 10),
                                  () {
                                _searchFocusNode.unfocus();
                                _searchTextController.clear();

                                context
                                    .read<MainProvider>()
                                    .currentProductModel = product;
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ProductDetailsScreen(),
                                  ),
                                );
                              });
                            },
                          );
                        },
                      ),
                    );
                  } else if (state is GlobalSearchError) {
                    return Center(child: Text(state.message));
                  } else {
                    // Initial state or no results
                    return const Center(child: Text('Start typing to search'));
                  }
                },
              ),
            ),
          ),
          body: CustomScrollView(
            controller: _scrollController,
            slivers: [
              // Categories Section
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                sliver: BlocListener<CategoriesBloc, CategoriesState>(
                  listener: (context, state) {
                    if (state is CategoriesError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            duration: const Duration(seconds: 5),
                            content: Text(state.error)),
                      );
                    }
                  },
                  child: BlocBuilder<CategoriesBloc, CategoriesState>(
                    builder: (context, state) {
                      if (state is CategoriesLoading) {
                        return const SliverToBoxAdapter(
                            child: Center(child: CircularProgressIndicator()));
                      } else if (state is CategoriesLoaded) {
                        return SliverGrid(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final category = state.categories[index];
                              final products = state.products;
                              return _categoryItem(
                                category: category,
                                productList: products,
                              );
                            },
                            childCount: state.categories.length,
                          ),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 8.0,
                            crossAxisSpacing: 8.0,
                            childAspectRatio: 174.5 / 189,
                          ),
                        );
                      }
                      return const SliverToBoxAdapter(
                          child: Center(child: Text('No Data')));
                    },
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 20)), // Spacer

              // Category Details Section
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                sliver: BlocListener<CategoryDetailBloc, CategoryDetailState>(
                  listener: (context, state) {
                    if (state is CategoryDetailLoaded) {
                      context.read<MainProvider>().isLoadingMore = false;
                    }
                    if (state is CategoryDetailError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            duration: const Duration(seconds: 5),
                            content: Text(state.message)),
                      );
                    }
                  },
                  child: BlocBuilder<CategoryDetailBloc, CategoryDetailState>(
                    builder: (context, state) {
                      if (state is CategoryDetailLoaded) {
                        final products = state.products;
                        return SliverPadding(
                          padding: const EdgeInsets.only(bottom: 20),
                          sliver: SliverGrid(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                return ProductCard(
                                  product: products[index],
                                  press: () {
                                    context
                                        .read<MainProvider>()
                                        .currentProductModel = products[index];
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const ProductDetailsScreen(),
                                      ),
                                    );
                                  },
                                );
                              },
                              childCount: state.products.length,
                            ),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 8.0,
                              crossAxisSpacing: 8.0,
                              childAspectRatio: 140 / 220,
                            ),
                          ),
                        );
                      } else if (state is CategoryDetailLoading) {
                        return const SliverToBoxAdapter(
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                      return const SliverToBoxAdapter(child: SizedBox.shrink());
                    },
                  ),
                ),
              ),

              if (context.watch<MainProvider>().isLoadingMore == true)
                const SliverToBoxAdapter(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _handleBackNavigation() async {
    return true;
    // log('${_categoryStack.length}');
    // if (_categoryStack.length > 1) {
    //   _categoryStack.removeLast(); // Remove current category
    //   final previousCategories = _categoryStack.last;

    //   context.read<CategoriesBloc>().add(
    //         FetchSubcategories(
    //             previousCategories.first), // Go back to previous category
    //       );

    //   return false; // Prevent the app from closing
    // }
    // return true; // Allow the app to close
  }
}

class _categoryItem extends StatelessWidget {
  const _categoryItem({
    super.key,
    required this.category,
    required this.productList,
  });

  final Category category;
  final List<Product> productList;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<CategoryDetailBloc>().categoryId = category.id!;
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
          if (category.productsCount! > 0) {
            context
                .read<CategoryDetailBloc>()
                .add(FetchCategoryProductsEvent(id: category.id!, page: 0));
          }
        } else if (category.productsCount! > 0) {
          context.read<MainProvider>().categoryName =
              category.name ?? 'Unknown';
          context
              .read<CategoryDetailBloc>()
              .add(FetchCategoryProductsEvent(id: category.id!, page: 0));
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
