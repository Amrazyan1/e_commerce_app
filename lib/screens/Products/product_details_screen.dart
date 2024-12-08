import 'dart:convert';
import 'dart:developer';

import 'package:e_commerce_app/Provider/main_provider.dart';
import 'package:e_commerce_app/components/added_to_cart_message_screen.dart';
import 'package:e_commerce_app/components/custom_modal_bottom_sheet.dart';
import 'package:e_commerce_app/screens/Products/Components/product_card.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/screens/Products/Components/product_images.dart';
import 'package:e_commerce_app/screens/Products/Components/product_info.dart';
import 'package:e_commerce_app/screens/Products/Components/review_card.dart';
import 'package:e_commerce_app/screens/Products/Components/cart_button.dart';
import 'package:e_commerce_app/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';

import '../../blocs/favourites/bloc/favourites_bloc.dart';
import '../../blocs/products/trending/bloc/trend_new_products_bloc.dart';
import '../../models/cart_products_response.dart';
import 'Components/quantity_widget.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({
    super.key,
  });

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final ApiService _apiService = GetIt.I<ApiService>();

  bool canShowquantity = false;
  bool isLoading = false;

  String countOfItem = '';
  String total = '';
  void addToCart(int count) async {
    setState(() {
      isLoading = true;
    });
    // CartProductItem? cardProdItem = await context
    //     .read<MainProvider>()
    //     .changeCountCartByProductId(
    //        , count);
    var response = await _apiService.changeCart({
      "id": context.read<MainProvider>().currentProductModel.id,
      "count": count
    });
    Map<String, dynamic> parsedJson = jsonDecode(response.data);
    int countTot = parsedJson['data']['count'];
    String total = parsedJson['data']['total'];
    CartProductItem cardProdItem =
        CartProductItem(count: countTot, total: total);

    if (cardProdItem != null) {
      setState(() {
        canShowquantity = true;
        countOfItem = cardProdItem.count.toString();
        total = cardProdItem.total.toString();
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
    // customModalBottomSheet(
    //   context,
    //   isDismissible: true,
    //   child: const AddedToCartMessageScreen(),
    // );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TrendNewProductsBloc, TrendNewProductsState>(
      listener: (context, state) {
        if (state is TrendNewProductsError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                duration: const Duration(seconds: 15),
                content: Text(state.message)),
          );
        }
      },
      child: Scaffold(
        bottomNavigationBar: CartButton(
          press: (isLoading || countOfItem.isNotEmpty)
              ? () {}
              : () => {addToCart(1)},
          infoWidget: isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Text(
                  '${countOfItem.isNotEmpty ? '$countOfItem items added' : 'Add to basket'}',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: Colors.white),
                ),
        ),
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                floating: true,
              ),
              ProductImages(
                images: [
                  context
                          .read<MainProvider>()
                          .currentProductModel
                          .images
                          ?.main
                          ?.src ??
                      '',
                  // context
                  //         .read<MainProvider>()
                  //         .currentProductModel
                  //         .images
                  //         ?.main
                  //         ?.src ??
                  //     '',
                  // context
                  //         .read<MainProvider>()
                  //         .currentProductModel
                  //         .images
                  //         ?.main
                  //         ?.src ??
                  //     '',
                ],
              ),
              SliverPadding(
                padding: const EdgeInsets.all(defaultPadding),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                                context
                                    .read<MainProvider>()
                                    .currentProductModel
                                    .name!
                                    .toUpperCase(),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(fontWeight: FontWeight.bold)),
                          ),
                          GestureDetector(
                            onTap: () {
                              log('IS favorite true');
                              context.read<FavouritesBloc>().add(
                                  AddToFavouritesEvent(context
                                      .read<MainProvider>()
                                      .currentProductModel
                                      .id));
                            },
                            child: const Icon(
                              // context
                              //         .watch<MainProvider>()
                              //         .currentProductModel
                              //         .isFavourite
                              true
                                  ? Icons.favorite
                                  : Icons.favorite_border_outlined,
                              color: kprimaryColor,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: defaultPadding / 2),
                      Text(
                        '${context.read<MainProvider>().currentProductModel.name}',
                        maxLines: 2,
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: Colors.black.withOpacity(0.5)),
                      ),
                      const SizedBox(height: defaultPadding),
                      Row(
                        children: [
                          // ProductAvailabilityTag(isAvailable: isAvailable),
                          Visibility(
                            visible: canShowquantity,
                            child: QuantityWidget(
                              initialCount: 1,
                              callback: addToCart,
                            ),
                          ),
                          const Spacer(),
                          const SizedBox(width: defaultPadding / 4),
                          Text(
                            '${total.isNotEmpty ? total : context.watch<MainProvider>().currentProductModel.price}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ],
                      ),
                      const SizedBox(height: defaultPadding),
                      Visibility(
                        visible: context
                                .read<MainProvider>()
                                .currentProductModel
                                .description !=
                            null,
                        child: Column(
                          children: [
                            Text(
                              "Product info",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: defaultPadding / 2),
                            Text(
                              '${context.read<MainProvider>().currentProductModel.description}',
                              style: const TextStyle(height: 1.4),
                            ),
                            const SizedBox(height: defaultPadding / 2),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Unit",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: defaultPadding / 2),
                          Text(
                            '${context.read<MainProvider>().currentProductModel.unit?.value} ${context.read<MainProvider>().currentProductModel.unit?.name ?? ''}',
                            style: const TextStyle(height: 1.4),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              // ProductInfo(
              //   productId: '',
              //   brand: '',
              //   title: '',
              //   isAvailable: true,
              //   description:
              //       ,
              //   rating: 4.4,
              //   numOfReviews: 126,
              //   price: '',
              // ),
              // ProductListTile(
              //   svgSrc: "assets/icons/Product.svg",
              //   title: "Product Details",
              //   press: () {},
              // ),
              // ProductListTile(
              //   svgSrc: "assets/icons/Delivery.svg",
              //   title: "Shipping Information",
              //   press: () {},
              // ),
              // ProductListTile(
              //   svgSrc: "assets/icons/Return.svg",
              //   title: "Returns",
              //   isShowBottomBorder: true,
              //   press: () {},
              // ),
              // const SliverToBoxAdapter(
              //   child: Padding(
              //     padding: EdgeInsets.all(defaultPadding),
              //     child: ReviewCard(
              //       rating: 4.3,
              //       numOfReviews: 128,
              //       numOfFiveStar: 80,
              //       numOfFourStar: 30,
              //       numOfThreeStar: 5,
              //       numOfTwoStar: 4,
              //       numOfOneStar: 1,
              //     ),
              //   ),
              // ),
              // ProductListTile(
              //   svgSrc: "assets/icons/Chat.svg",
              //   title: "Reviews",
              //   isShowBottomBorder: true,
              //   press: () {
              //     Navigator.pushNamed(context, 'productReviewsScreenRoute');
              //   },
              // ),
              SliverPadding(
                padding: const EdgeInsets.all(defaultPadding),
                sliver: SliverToBoxAdapter(
                  child: Text(
                    "You may also like",
                    style: Theme.of(context).textTheme.titleSmall!,
                  ),
                ),
              ),
              BlocBuilder<TrendNewProductsBloc, TrendNewProductsState>(
                builder: (context, state) {
                  if (state is TrendNewProductsLoading) {
                    return const SliverToBoxAdapter(
                        child: Center(child: CircularProgressIndicator()));
                  } else if (state is TrendNewProductsError) {
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   SnackBar(
                    //       duration: const Duration(seconds: 15),
                    //       content: Text(state.message)),
                    // );
                  } else if (state is TrendNewProductsLoaded) {
                    final products = state.products;

                    return SliverToBoxAdapter(
                      child: SizedBox(
                        height: 220,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: products.length,
                          itemBuilder: (context, index) => Padding(
                            padding: EdgeInsets.only(
                              left: defaultPadding,
                              right: index == products.length - 1
                                  ? defaultPadding
                                  : 0,
                            ),
                            child: ProductCard(
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
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                  return Container();
                },
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: defaultPadding),
              )
            ],
          ),
        ),
      ),
    );
  }
}
