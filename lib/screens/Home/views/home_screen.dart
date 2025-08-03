import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:e_commerce_app/blocs/settings/bloc/settings_bloc.dart';
import 'package:e_commerce_app/components/search_bar_input_field.dart';
import 'package:e_commerce_app/models/Settings/settings_model.dart';
import 'package:e_commerce_app/router/router.gr.dart';
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
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:super_cupertino_navigation_bar/super_cupertino_navigation_bar.dart';
import 'dart:ui' as ui;

import '../../../Provider/main_provider.dart';
import '../../../blocs/products/discounts/bloc/discounted_bloc.dart';
import '../../../blocs/products/popular/bloc/popular_products_bloc.dart';
import '../../../blocs/products/trending/bloc/trend_new_products_bloc.dart';
import '../../../blocs/search/bloc/global_search_bloc.dart';
import '../../../blocs/settings/bloc/settings_state.dart';
import '../../Products/Components/product_card.dart';
import '../../Products/product_details_screen.dart';
import '../../searchfocusnode.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchTextController = TextEditingController();

  Locale? previousLocale;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Check if the locale has changed
    if (previousLocale != context.locale) {
      previousLocale = context.locale;
      _onLocaleChanged();
    }
  }

  Future<void> _onLocaleChanged() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TrendNewProductsBloc>().add(FetchTrendNewProductsEvent());
      context.read<DiscountedBloc>().add(FetchDiscountedProductsEvent());
      context.read<PopularProductsBloc>().add(FetchTrendPopularProductsEvent());
      context.read<MainProvider>().forceUpdatebanners = true;
    });
  }

  Future<void> _onrefresh() async {
    context.read<MainProvider>().forceUpdatebanners = true;
    _onLocaleChanged();
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection:
          context.locale.languageCode == 'fa' ? ui.TextDirection.rtl : ui.TextDirection.ltr,
      child: RefreshIndicator(
        onRefresh: _onrefresh,
        child: SuperScaffold(
          key: superScaffoldKey,
          transitionBetweenRoutes: false,
          appBar: SuperAppBar(
            backgroundColor: Theme.of(context).colorScheme.background.withOpacity(.5),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: SizedBox(width: 120, child: SvgPicture.asset("assets/images/Logo.svg")),
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
              searchFocusNode: searchFocusService.searchFocusNode,
              searchController: _searchTextController,
              textStyle: Theme.of(context).textTheme.bodyLarge!,
              onFocused: (value) {
                if (!value) {
                  setState(_searchTextController.clear);
                } else {
                  context.read<GlobalSearchBloc>().add(SetSearchInitialEvent());
                }
              },
              cancelTextStyle: Theme.of(context).textTheme.bodyLarge!,
              onSubmitted: (value) {
                if (value.isEmpty) {
                  return;
                }
                context.read<GlobalSearchBloc>().add(PerformGlobalSearch(
                      keyword: value,
                      perPage: 20,
                    ));
              },
              searchResult: Container(
                child: BlocBuilder<GlobalSearchBloc, GlobalSearchState>(
                  builder: (buildercontext, state) {
                    if (state is GlobalSearchLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is GlobalSearchLoaded) {
                      return Padding(
                        padding: const EdgeInsets.all(defaultPadding),
                        child: GridView.builder(
                          itemCount: state.results.data!.products!.data!.data!.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 8.0,
                            crossAxisSpacing: 8.0,
                            childAspectRatio: 140 / 220,
                          ),
                          itemBuilder: (context, index) {
                            final product = state.results.data!.products!.data!.data![index];
                            return ProductCard(
                              product: product,
                              press: () {
                                // _searchFocusNode.requestFocus();
                                Future.delayed(const Duration(milliseconds: 0), () {
                                  // _searchFocusNode.unfocus();
                                  _searchTextController.clear();

                                  context.read<MainProvider>().currentProductModel = product;
                                  AutoRouter.of(context).push(ProductDetailsRoute());
                                  // Navigator.of(context).push(
                                  //   MaterialPageRoute(
                                  //     builder: (context) =>
                                  //         const ProductDetailsScreen(),
                                  //   ),
                                  // );
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
          ),
          body: SafeArea(
            child: CustomScrollView(
              slivers: [
                const SliverToBoxAdapter(child: OffersCarouselAndCategories()),
                const SliverToBoxAdapter(child: PopularProducts()),
                BlocBuilder<SettingsBloc, SettingsState>(
                  builder: (context, state) {
                    if (state is SettingsLoaded) {
                      return SliverToBoxAdapter(
                        child: _barcodeItem(
                          settingsModel: state.settings,
                        ),
                      );
                    }
                    return const SliverToBoxAdapter(
                      child: SizedBox.shrink(),
                    );
                  },
                ),
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

class _barcodeItem extends StatefulWidget {
  final SettingsModel settingsModel;
  const _barcodeItem({
    super.key,
    required this.settingsModel,
  });

  @override
  State<_barcodeItem> createState() => _barcodeItemState();
}

class _barcodeItemState extends State<_barcodeItem> {
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.settingsModel.data?.bonusCode?.isNotEmpty ?? false,
      child: GestureDetector(
        onTap: () {
          AutoRouter.of(context).push(BonusCarRoute(
            code: widget.settingsModel.data?.bonusCode ?? '',
            bonusPoints: widget.settingsModel.data?.bonus ?? '',
          ));
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white, // Background color of the container
              borderRadius: BorderRadius.circular(16), // Adjust as needed
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 4,
                  offset: Offset(0, 2), // Slight shadow for a better look
                ),
              ],
            ),
            padding: const EdgeInsets.all(16), // Padding inside the container
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'bonus_card'.tr(),
                      style: const TextStyle(color: kprimaryColor),
                    ),
                  ],
                ),
                BarcodeWidget(
                  data: widget.settingsModel.data?.bonusCode ?? '',
                  barcode: Barcode.code128(),
                  width: double.infinity,
                  height: 120,
                  drawText: false,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'show_bonus'.tr(),
                      style: const TextStyle(color: kprimaryColor),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
