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

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                context.read<MainProvider>().currentProductModel.imageUrl,
                context.read<MainProvider>().currentProductModel.imageUrl,
                context.read<MainProvider>().currentProductModel.imageUrl
              ],
            ),
            ProductInfo(
              brand:
                  '${context.watch<MainProvider>().currentProductModel.brandName}',
              title:
                  '${context.watch<MainProvider>().currentProductModel.title}',
              isAvailable: true,
              description:
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
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
            SliverToBoxAdapter(
              child: SizedBox(
                height: 220,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(
                        left: defaultPadding,
                        right: index == 4 ? defaultPadding : 0),
                    child: ProductCard(
                      image: productDemoImg2,
                      title: "Product",
                      brandName: "product",
                      price: 24.65,
                      priceAfetDiscount: index.isEven ? 20.99 : null,
                      dicountpercent: index.isEven ? 25 : null,
                      press: () {},
                    ),
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: defaultPadding),
            )
          ],
        ),
      ),
    );
  }
}
