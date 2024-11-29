import 'package:auto_route/annotations.dart';
import 'package:e_commerce_app/components/search_bar_input_field.dart';
import 'package:e_commerce_app/screens/Home/views/components/best_sellers.dart';
import 'package:e_commerce_app/screens/Home/views/components/flash_sale.dart';
import 'package:e_commerce_app/screens/Home/views/components/most_popular.dart';
import 'package:e_commerce_app/screens/Home/views/components/offer_carousel_and_categories.dart';
import 'package:e_commerce_app/screens/Home/views/components/popular_products.dart';
import 'package:e_commerce_app/components/Banners/S/banner_s_style_1.dart';
import 'package:e_commerce_app/components/Banners/S/banner_s_style_5.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cupertino_navigation_bar/super_cupertino_navigation_bar.dart';

import '../../../Provider/main_provider.dart';
import '../../../blocs/search/bloc/global_search_bloc.dart';
import '../../Products/Components/product_card.dart';
import '../../Products/product_details_screen.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _searchFocusNode = FocusNode();

    final _searchTextController = TextEditingController();
    return SuperScaffold(
      appBar: SuperAppBar(
        backgroundColor:
            Theme.of(context).colorScheme.background.withOpacity(.5),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Yerevan, Davitashen',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(fontWeight: FontWeight.w700, fontSize: 16),
            ),
          ],
        ),
        largeTitle: SuperLargeTitle(
          largeTitle: 'Yerevan, Davitashen',
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
          cancelTextStyle: Theme.of(context).textTheme.bodyLarge!,
          onChanged: (value) {},
          onSubmitted: (value) {
            context.read<GlobalSearchBloc>().add(PerformGlobalSearch(
                  keyword: value,
                  perPage: 20,
                ));
          },
          searchResult: BlocBuilder<GlobalSearchBloc, GlobalSearchState>(
            builder: (context, state) {
              if (state is GlobalSearchLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is GlobalSearchLoaded) {
                // Display results in a GridView
                return Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: GridView.builder(
                    itemCount: state.results.data!.products!.data!.data!.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Customize grid layout
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 0.75,
                    ),
                    itemBuilder: (context, index) {
                      final product =
                          state.results.data!.products!.data!.data![index];
                      return ProductCard(
                        product: product,
                        press: () {
                          context.read<MainProvider>().currentProductModel =
                              product;
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
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: OffersCarouselAndCategories()),
            const SliverToBoxAdapter(child: PopularProducts()),
            const SliverPadding(
              padding: EdgeInsets.symmetric(vertical: defaultPadding * 1.5),
              sliver: SliverToBoxAdapter(child: FlashSale()),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  // While loading use 👇
                  // const BannerMSkelton(),
                  BannerSStyle1(
                    title: "New \narrival",
                    subtitle: "SPECIAL OFFER",
                    discountParcent: 50,
                    press: () {
                      Navigator.pushNamed(context, 'onSaleScreenRoute');
                    },
                  ),
                  const SizedBox(height: defaultPadding / 4),
                  // We have 4 banner styles, all in the pro version
                ],
              ),
            ),
            // const SliverToBoxAdapter(child: BestSellers()),
            const SliverToBoxAdapter(child: MostPopular()),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  const SizedBox(height: defaultPadding * 1.5),

                  const SizedBox(height: defaultPadding / 4),
                  // While loading use 👇
                  // const BannerSSkelton(),
                  BannerSStyle5(
                    title: "Black \nfriday",
                    subtitle: "50% Off",
                    bottomText: "Collection".toUpperCase(),
                    press: () {
                      Navigator.pushNamed(context, 'onSaleScreenRoute');
                    },
                  ),
                  const SizedBox(height: defaultPadding / 4),
                ],
              ),
            ),
            const SliverToBoxAdapter(child: BestSellers()),
          ],
        ),
      ),
    );
  }
}
