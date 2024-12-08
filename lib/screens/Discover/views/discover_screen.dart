import 'dart:developer';

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:e_commerce_app/Provider/main_provider.dart';
import 'package:e_commerce_app/blocs/categories/bloc/categories_event.dart';
import 'package:e_commerce_app/blocs/categorydetails/bloc/copy/bloc/category_detail_copy_bloc.dart';
import 'package:e_commerce_app/components/search_bar_input_field.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/models/category_model_real.dart';
import 'package:e_commerce_app/router/router.gr.dart';
import 'package:e_commerce_app/screens/Discover/views/filter_screen.dart';
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
  final List<Category> _categoryStack = []; // Stack to keep track of navigation
  final _searchFocusNode = FocusNode();

  final _searchTextController = TextEditingController();

  final ScrollController _scrollController = ScrollController();
  bool _isInitialScreen = true;

  @override
  void initState() {
    super.initState();
    // Fetch categories on first navigation
    final categoriesState = context.read<CategoriesBloc>().state;
    if (categoriesState is! CategoriesLoaded) {
      context.read<CategoriesBloc>().add(FetchCategoriesEvent());
    } else {
      setState(() {
        _isInitialScreen =
            false; // Set to false if categories are already loaded
      });
    }
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100) {
      // Close to the end of the scroll
      log('onscroll +++++ ${context.read<MainProvider>().isLoadingMore}');
      if (!context.read<MainProvider>().isLoadingMore) {
        if (context.read<CategoryDetailBloc>().categoryId.isEmpty) {
          return;
        }
        log('onscroll +++++');

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
        if (state is CategoriesLoaded && _categoryStack.isEmpty) {
          setState(() {
            _isInitialScreen =
                true; // Ensure this is set only after initial load
          });
        }
        // if (state is CategoriesLoaded) {
        //   if (state.products.isNotEmpty) {
        //     AutoRouter.of(context).push(const DiscoverDetailsRoute());
        //   }
        // }
      },
      child: SuperScaffold(
        key: const Key('discvoer'),
        appBar: SuperAppBar(
          automaticallyImplyLeading: false,
          actions: !_isInitialScreen
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => FilterScreen(
                              isFirst: true,
                            ),
                          ),
                        );
                      },
                      icon: SvgPicture.asset("assets/icons/filter.svg",
                          color: Theme.of(context).textTheme.bodyLarge!.color),
                    ),
                  ],
                )
              : null,
          leading: !_isInitialScreen
              ? GestureDetector(
                  onTap: () {
                    _handleBackNavigation();
                  },
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                    child: SvgPicture.asset("assets/icons/arrow_back.svg",
                        color: Theme.of(context).textTheme.bodyLarge!.color),
                  ),
                )
              : null,
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
            enabled: false,
          ),
          // searchBar: SuperSearchBar(
          //   searchFocusNode: _searchFocusNode,
          //   searchController: _searchTextController,
          //   textStyle: Theme.of(context).textTheme.bodyLarge!,
          //   onFocused: (value) {
          //     if (!value) {}
          //   },
          //   onSubmitted: (value) {
          //     context.read<GlobalSearchBloc>().add(PerformGlobalSearch(
          //           keyword: value,
          //           perPage: 20,
          //         ));
          //   },
          //   cancelTextStyle: Theme.of(context).textTheme.bodyLarge!,
          //   onChanged: (value) {},
          //   searchResult: BlocBuilder<GlobalSearchBloc, GlobalSearchState>(
          //     builder: (context, state) {
          //       if (state is GlobalSearchLoading) {
          //         return const Center(child: CircularProgressIndicator());
          //       } else if (state is GlobalSearchLoaded) {
          //         // Display results in a GridView
          //         return Padding(
          //           padding: const EdgeInsets.all(defaultPadding),
          //           child: GridView.builder(
          //             itemCount:
          //                 state.results.data!.products!.data!.data!.length,
          //             gridDelegate:
          //                 const SliverGridDelegateWithFixedCrossAxisCount(
          //               crossAxisCount: 2,
          //               mainAxisSpacing: 8.0,
          //               crossAxisSpacing: 8.0,
          //               childAspectRatio: 140 / 220, // Match item dimensions
          //             ),
          //             itemBuilder: (context, index) {
          //               final product =
          //                   state.results.data!.products!.data!.data![index];
          //               return ProductCard(
          //                 product: product,
          //                 press: () {
          //                   _searchFocusNode.requestFocus();
          //                   Future.delayed(const Duration(milliseconds: 10),
          //                       () {
          //                     _searchFocusNode.unfocus();
          //                     _searchTextController.clear();

          //                     context.read<MainProvider>().currentProductModel =
          //                         product;
          //                     Navigator.of(context).push(
          //                       MaterialPageRoute(
          //                         builder: (context) =>
          //                             const ProductDetailsScreen(),
          //                       ),
          //                     );
          //                   });
          //                 },
          //               );
          //             },
          //           ),
          //         );
          //       } else if (state is GlobalSearchError) {
          //         return Center(child: Text(state.message));
          //       } else {
          //         // Initial state or no results
          //         return const Center(child: Text('Start typing to search'));
          //       }
          //     },
          //   ),
          // ),
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
                                onTap: _onCategoryTap);
                          },
                          childCount: state.categories.length,
                        ),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 8.0,
                          crossAxisSpacing: 8.0,
                          childAspectRatio: 174 / 174,
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
    );
  }

  void _onCategoryTap(Category category) {
    if ((category.subcategories ?? []).isNotEmpty) {
      setState(() {
        _categoryStack.add(category);
        _isInitialScreen = false; // Add the new category to the stack
      });
      context.read<CategoryDetailBloc>().categoryId = category.id!;

      context.read<CategoriesBloc>().add(FetchSubcategories(category));
      context.read<CategoryDetailBloc>().cancelLoadProducts();
      if (category.productsCount! > 0) {
        context
            .read<CategoryDetailBloc>()
            .add(FetchCategoryProductsEvent(id: category.id!, page: 1));
      }
    } else if (category.productsCount! > 0) {
      context.read<MainProvider>().categoryName = category.name ?? 'Unknown';
      context
          .read<CategoryDetailCopyBloc>()
          .add(FetchCategoryProductsEventCopy(id: category.id!, page: 0));
      context.router.push(const DiscoverDetailsRoute());
    } else {
      {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${category.name} has no subcategories')),
        );
      }
    }
  }

  void _handleBackNavigation() {
    context.read<CategoryDetailBloc>().cancelLoadProducts();

    setState(() {
      if (_categoryStack.isNotEmpty) {
        _categoryStack.removeLast(); // Go back in stack
      }
      _isInitialScreen = _categoryStack.isEmpty;
    });

    if (_categoryStack.isNotEmpty) {
      // Fetch products for the previous category
      final previousCategory = _categoryStack.last;
      context.read<CategoryDetailBloc>().categoryId = previousCategory.id!;
      context.read<CategoryDetailBloc>().add(
            FetchCategoryProductsEvent(id: previousCategory.id!, page: 0),
          );
    } else {
      context.read<CategoryDetailBloc>().categoryId = '';
      context.read<CategoriesBloc>().add(FetchCategoriesEvent());
      context.read<CategoryDetailBloc>().add(
            FetchCategoryProductsEvent(id: '', page: 0),
          );
    }
  }

  Widget _categoryItem({
    required Category category,
    required List<Product> productList,
    required void Function(Category category) onTap,
  }) {
    return GestureDetector(
      onTap: () => onTap(category),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10), // Apply radius to the child

        child: Container(
          decoration: BoxDecoration(
            color: ksecondaryColor, //.withOpacity(0.2),
            border: Border.all(color: const Color(0xFFD2B7E5)),
          ),
          child: Stack(
            children: [
              _buildImage(category.image),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Flexible(
                  child: Text(
                    category.name ?? 'Unknown',
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),

                    textAlign: TextAlign.start,
                    maxLines: 3, // Limit the number of lines
                    overflow:
                        TextOverflow.ellipsis, // Add ellipsis if text overflows
                  ),
                ),
              ),
            ],
          ),
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
        placeholderBuilder: (context) => const CircularProgressIndicator(),
      );
    } else {
      return Image.network(
        imageUrl,
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
