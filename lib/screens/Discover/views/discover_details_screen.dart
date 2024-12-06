import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:e_commerce_app/Provider/main_provider.dart';
import 'package:e_commerce_app/blocs/categorydetails/bloc/copy/bloc/category_detail_copy_bloc.dart';
import 'package:e_commerce_app/blocs/search/bloc/global_search_bloc.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/screens/Discover/views/filter_screen.dart';
import 'package:e_commerce_app/screens/Products/Components/product_card.dart';
import 'package:e_commerce_app/screens/Products/product_details_screen.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SuperScaffold(
        key: Key('discvoerdetail'),
        transitionBetweenRoutes: true,
        appBar: SuperAppBar(
          automaticallyImplyLeading: false,
          title: Text(
            context.watch<MainProvider>().categoryName,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          largeTitle: SuperLargeTitle(
            largeTitle: context.watch<MainProvider>().categoryName,
            textStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                  letterSpacing: 0,
                ),
          ),
          actions: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
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
        body: BlocBuilder<CategoryDetailCopyBloc, CategoryDetailCopyState>(
          builder: (context, state) {
            if (state is CategoryDetailCopyLoaded) {
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
            } else if (state is CategoryDetailCopyLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is CategoryDetailCopyError) {
              return Center(
                child: Text(state.message),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
