import 'dart:convert';
import 'dart:developer';

import 'package:e_commerce_app/Provider/main_provider.dart';
import 'package:e_commerce_app/blocs/bloc/product_detail_bloc.dart';
import 'package:e_commerce_app/screens/Products/Components/product_card.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/screens/Products/Components/product_images.dart';
import 'package:e_commerce_app/screens/Products/Components/cart_button.dart';
import 'package:e_commerce_app/services/api_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get_it/get_it.dart';
import 'package:like_button/like_button.dart';
import 'package:shimmer/shimmer.dart';
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

  bool isLoading = false;

  String countOfItem = '';
  String total = '';
  int prodCount = 1;
  void productCounter(int count) {
    prodCount = count;
  }

  void addToCart(int count) async {
    setState(() {
      isLoading = true;
    });
    // CartProductItem? cardProdItem = await context
    //     .read<MainProvider>()
    //     .changeCountCartByProductId(
    //        , count);
    var response = await _apiService.addToCart({
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
  void initState() {
    super.initState();
    context.read<ProductDetailBloc>().add(FetchProductDetail(
        context.read<MainProvider>().currentProductModel.id));
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
          press: (isLoading) ? () {} : () => {addToCart(prodCount)},
          infoWidget: isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: QuantityWidget(
                        initialCount: prodCount,
                        minCount: context
                                .read<MainProvider>()
                                .currentProductModel
                                .unit!
                                .minCount ??
                            1,
                        maxCount: context
                            .read<MainProvider>()
                            .currentProductModel
                            .unit!
                            .maxCount,
                        callback: productCounter,
                        alternative: context
                            .watch<MainProvider>()
                            .currentProductModel
                            .unit!
                            .alternative!,
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Text(
                        countOfItem.isNotEmpty
                            ? '$countOfItem ' + 'items_added'.tr()
                            : 'add_basket'.tr(),
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: Colors.white),
                      ).tr(),
                    ),
                  ],
                ),
        ),
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                floating: true,
              ),
              BlocBuilder<ProductDetailBloc, ProductDetailState>(
                builder: (context, state) {
                  if (state is ProductDetailLoaded) {
                    return ProductImages(
                      images: [
                        state.product.images?.main?.src ?? '',
                        ...(state.product.images?.additional ?? [])
                            .map((image) => image.src ?? '')
                            .toList(),
                      ],
                    );
                  }
                  return SliverToBoxAdapter(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Stack(
                        children: [
                          PageView.builder(
                            itemCount: 1,
                            itemBuilder: (context, index) => Padding(
                              padding:
                                  const EdgeInsets.only(right: defaultPadding),
                              child: Shimmer.fromColors(
                                baseColor: Colors.grey.shade200,
                                highlightColor: Colors.grey.shade100,
                                enabled: true,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(defaultBorderRadius * 2),
                                  ),
                                  child: Container(
                                    color: Colors.amber,
                                  ),
                                  // child: NetworkImageWithLoader(''),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              SliverPadding(
                padding: const EdgeInsets.all(defaultPadding),
                sliver: SliverToBoxAdapter(
                  child: BlocBuilder<ProductDetailBloc, ProductDetailState>(
                    builder: (context, state) {
                      if (state is ProductDetailLoaded) {
                        context.read<MainProvider>().currentProductModel.unit =
                            state.product.unit;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(state.product.name!.toUpperCase(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                              fontWeight: FontWeight.bold)),
                                ),
                                Center(
                                  child: LikeButton(
                                    size: 30,
                                    onTap: (istapped) async {
                                      log('IS favorite true');
                                      context.read<FavouritesBloc>().add(
                                          AddToFavouritesEvent(
                                              state.product.id!));
                                      return !istapped;
                                    },
                                    likeBuilder: (isLiked) {
                                      return Icon(
                                        Icons.favorite,
                                        color: isLiked
                                            ? kprimaryColor
                                            : kprimaryColor.withOpacity(0.2),
                                        size: 30,
                                      );
                                    },
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: defaultPadding / 2),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${context.read<MainProvider>().currentProductModel.unit?.value} ${context.read<MainProvider>().currentProductModel.unit?.name ?? ''}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            const SizedBox(height: defaultPadding),
                            Row(
                              children: [
                                // ProductAvailabilityTag(isAvailable: isAvailable),

                                const Spacer(),
                                const SizedBox(width: defaultPadding / 4),
                                state.product.discount != null &&
                                        state.product.discount != '0 %'
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${state.product.discountedPrice}",
                                            style: const TextStyle(
                                              color: ksecondaryColor,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 18,
                                            ),
                                          ),
                                          const SizedBox(
                                              width: defaultPadding / 2),
                                          Text(
                                            state.product.price!,
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge!
                                                  .color,
                                              fontSize: 16,
                                              decoration:
                                                  TextDecoration.lineThrough,
                                            ),
                                          ),
                                        ],
                                      )
                                    : Text(
                                        '${total.isNotEmpty ? total : state.product.price}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                      ),
                              ],
                            ),
                            Visibility(
                              visible: state.product.description != null &&
                                  state.product.description!.isNotEmpty,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "product_info".tr(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(height: defaultPadding / 2),
                                  HtmlWidget('${state.product.description}'),
                                  const SizedBox(height: defaultPadding / 2),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: state.product?.characteristics
                                          ?.isNotEmpty ??
                                      false
                                  ? Column(
                                      children: state.product!.characteristics!
                                          .map((characteristic) {
                                        final name =
                                            characteristic['name'] ?? 'Unknown';
                                        final value = characteristic['value'] ??
                                            'Unknown';
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 4.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                name,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                value,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey[700],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }).toList(),
                                    )
                                  : Container(),
                            )
                          ],
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
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
                    "you_may_like".tr(),
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
