import 'dart:developer';

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:e_commerce_app/Provider/main_provider.dart';
import 'package:e_commerce_app/blocs/categorydetails/bloc/copy/bloc/category_detail_copy_bloc.dart';
import 'package:e_commerce_app/blocs/search/bloc/global_search_bloc.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/router/router.gr.dart';
import 'package:e_commerce_app/screens/Discover/views/filter_screen.dart';
import 'package:e_commerce_app/screens/Products/Components/product_card.dart';
import 'package:e_commerce_app/screens/Products/product_details_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:super_cupertino_navigation_bar/super_cupertino_navigation_bar.dart';

@RoutePage()
class DiscoverDetailsScreen extends StatefulWidget {
  // final List<Product> products;
  const DiscoverDetailsScreen({super.key});

  @override
  State<DiscoverDetailsScreen> createState() => _DiscoverDetailsScreenState();
}

class _DiscoverDetailsScreenState extends State<DiscoverDetailsScreen> {
  final _searchFocusNode = FocusNode();

  final _searchTextController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // // Fetch categories on first navigation
    // final categoriesState = context.read<CategoryDetailCopyBloc>().state;
    // if (categoriesState is! CategoryDetailCopyLoaded) {
    //   context.read<CategoryDetailCopyBloc>().add(FetchCategoryProductsEventCopy());
    // } else {

    // }
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100) {
      // Close to the end of the scroll
      log('onscroll +++++ ${context.read<MainProvider>().isLoadingMore}');
      if (!context.read<MainProvider>().isLoadingMore) {
        if (context.read<CategoryDetailCopyBloc>().categoryId.isEmpty) {
          return;
        }
        log('onscroll +++++');

        context.read<MainProvider>().isLoadingMore = true;

        context.read<CategoryDetailCopyBloc>().add(
            FetchCategoryProductsEventCopy(
                id: context.read<CategoryDetailCopyBloc>().categoryId,
                page: 1));
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
    String _truncateText(String text, {required int maxLength}) {
      if (text.length > maxLength) {
        return text.substring(0, maxLength) + '...'; // Append ellipsis
      }
      return text; // No truncation needed
    }

    return Scaffold(
      body: SuperScaffold(
        key: const Key('discvoerdetail'),
        transitionBetweenRoutes: false,
        appBar: SuperAppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              Flexible(
                child: Text(
                  context.watch<MainProvider>().categoryName,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ],
          ),
          largeTitle: SuperLargeTitle(
            largeTitle: _truncateText(
                context.watch<MainProvider>().categoryName,
                maxLength: 18),
            textStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 24,
                letterSpacing: 0,
                overflow: TextOverflow.ellipsis),
          ),
          leading: GestureDetector(
            onTap: () {
              context.router.maybePop();
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: SvgPicture.asset("assets/icons/arrow_back.svg",
                  color: Theme.of(context).textTheme.bodyLarge!.color),
            ),
          ),
          searchBar: SuperSearchBar(
            placeholderText: 'search'.tr(),
            searchFocusNode: _searchFocusNode,
            searchController: _searchTextController,
            textStyle: Theme.of(context).textTheme.bodyLarge!,
            onFocused: (value) {
              if (!value) {
                setState(_searchTextController.clear);
              } else {
                context.read<GlobalSearchBloc>().add(SetSearchInitialEvent());
              }
            },
            onSubmitted: (value) {
              if (value.isEmpty) {
                return;
              }
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
                      itemBuilder: (contextlocal, index) {
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

                              context.read<MainProvider>().currentProductModel =
                                  product;
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
          primary: false,
          controller: _scrollController,
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              sliver:
                  BlocListener<CategoryDetailCopyBloc, CategoryDetailCopyState>(
                listener: (context, state) {
                  if (state is CategoryDetailCopyLoaded) {
                    context.read<MainProvider>().isLoadingMore = false;
                  }
                },
                child: BlocBuilder<CategoryDetailCopyBloc,
                    CategoryDetailCopyState>(
                  builder: (context, state) {
                    if (state is CategoryDetailCopyLoaded) {
                      final products = state.products;
                      return SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 8.0,
                          crossAxisSpacing: 8.0,
                          childAspectRatio: 140 / 220, // Match item dimensions
                        ),
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
                          childCount: products.length,
                        ),
                      );
                    } else if (state is CategoryDetailCopyLoading) {
                      return const SliverToBoxAdapter(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else if (state is CategoryDetailCopyError) {
                      return SliverToBoxAdapter(
                        child: Center(
                          child: Text(state.message),
                        ),
                      );
                    }
                    return const SliverToBoxAdapter(
                      child: SizedBox.shrink(),
                    );
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
}
