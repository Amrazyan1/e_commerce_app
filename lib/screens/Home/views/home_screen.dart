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
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cupertino_navigation_bar/super_cupertino_navigation_bar.dart';
import 'dart:ui' as ui;

import '../../../Provider/main_provider.dart';
import '../../../blocs/search/bloc/global_search_bloc.dart';
import '../../Products/Components/product_card.dart';
import '../../Products/product_details_screen.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchFocusNode = FocusNode();
  final _searchTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: context.locale.languageCode == 'fa'
          ? ui.TextDirection.rtl
          : ui.TextDirection.ltr,
      child: Scaffold(
        body: SuperScaffold(
          key: const Key('home'),
          appBar: SuperAppBar(
            backgroundColor:
                Theme.of(context).colorScheme.background.withOpacity(.5),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Image.asset("assets/images/logo.png"),
                ),
              ],
            ),
            largeTitle: SuperLargeTitle(
              enabled: false,
              largeTitle: 'Orig Inn'.tr(), // Translated text
              textStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                    letterSpacing: 0,
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
                }
              },
              cancelTextStyle: Theme.of(context).textTheme.bodyLarge!,
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
                          childAspectRatio: 140 / 220,
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
                    return Center(child: Text('search'.tr())); // Translated
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
                      BannerSStyle1(
                        title: '', // Translated
                        subtitle: '', // Translated
                        press: () {},
                      ),
                      const SizedBox(height: defaultPadding / 4),
                    ],
                  ),
                ),
                const SliverToBoxAdapter(child: MostPopular()),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      const SizedBox(height: defaultPadding * 1.5),
                      BannerSStyle5(
                        title: '', // Translated
                        subtitle: '', // Translated
                        bottomText: '', // Translated
                        press: () {},
                      ),
                      const SizedBox(height: defaultPadding / 4),
                    ],
                  ),
                ),
                const SliverToBoxAdapter(child: BestSellers()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
