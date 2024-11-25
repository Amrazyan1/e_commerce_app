import 'package:e_commerce_app/Provider/main_provider.dart';
import 'package:e_commerce_app/components/added_to_cart_message_screen.dart';
import 'package:e_commerce_app/components/custom_modal_bottom_sheet.dart';
import 'package:e_commerce_app/screens/Products/Components/product_card.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/screens/Products/Components/product_images.dart';
import 'package:e_commerce_app/screens/Products/Components/product_info.dart';
import 'package:e_commerce_app/screens/Products/Components/review_card.dart';
import 'package:e_commerce_app/screens/Products/Components/cart_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../blocs/products/trending/bloc/trend_new_products_bloc.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({
    super.key,
  });

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
          price: context.watch<MainProvider>().detailButtonPriceSum,
          press: () {
            context
                .read<MainProvider>()
                .addToCart(context.read<MainProvider>().currentProductModel);
            customModalBottomSheet(
              context,
              isDismissible: true,
              child: const AddedToCartMessageScreen(),
            );
          },
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
                  context
                          .read<MainProvider>()
                          .currentProductModel
                          .images
                          ?.main
                          ?.src ??
                      '',
                  context
                          .read<MainProvider>()
                          .currentProductModel
                          .images
                          ?.main
                          ?.src ??
                      '',
                ],
              ),
              ProductInfo(
                productId:
                    '${context.read<MainProvider>().currentProductModel.id}',
                brand:
                    '${context.read<MainProvider>().currentProductModel.name}',
                title:
                    '${context.read<MainProvider>().currentProductModel.name}',
                isAvailable: true,
                description:
                    '${context.read<MainProvider>().currentProductModel.description}',
                rating: 4.4,
                numOfReviews: 126,
                price:
                    '${context.watch<MainProvider>().currentProductModel.price}',
              ),
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
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: ReviewCard(
                    rating: 4.3,
                    numOfReviews: 128,
                    numOfFiveStar: 80,
                    numOfFourStar: 30,
                    numOfThreeStar: 5,
                    numOfTwoStar: 4,
                    numOfOneStar: 1,
                  ),
                ),
              ),
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
                              id: products[index].id,
                              image: products[index].images!.main!.src!,
                              brandName: products[index].name!,
                              title: products[index].description!,
                              priceText: products[index].price!,
                              priceAfetDiscount:
                                  products[index].discountedPrice,
                              dicountpercent: products[index].discount,
                              press: () {
                                context
                                    .read<MainProvider>()
                                    .currentProductModel = products[index];
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ProductDetailsScreen(),
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
