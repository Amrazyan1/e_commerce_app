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
import 'package:super_cupertino_navigation_bar/super_cupertino_navigation_bar.dart';

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
        title: Text(
          'Yerevan, Davitashen',
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        largeTitle: SuperLargeTitle(
          largeTitle: 'Yerevan, Davitashen',
          textStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 24,
                letterSpacing: 0,
              ),
        ),
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [],
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
