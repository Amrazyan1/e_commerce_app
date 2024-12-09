import 'package:auto_route/auto_route.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:e_commerce_app/Provider/main_provider.dart';
import 'package:e_commerce_app/components/Banners/M/banner_m_with_counter.dart';
import 'package:e_commerce_app/router/router.gr.dart';
import 'package:e_commerce_app/screens/Products/Components/product_card.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/screens/Products/product_details_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/products/discounts/bloc/discounted_bloc.dart';
import '../../../../components/Shimmers/product_shimmer_portrait.dart';

class FlashSale extends StatelessWidget {
  const FlashSale({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<DiscountedBloc, DiscountedBlocState>(
      listener: (context, state) {
        if (state is DiscountedBlocError) {}
      },
      child: BlocBuilder<DiscountedBloc, DiscountedBlocState>(
        builder: (context, state) {
          if (state is DiscountedBlocLoaded) {
            final products = state.discountedProducts;
            if (products.isEmpty) {
              return Container();
            }
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const _barcodeItem(),
              const SizedBox(height: defaultPadding / 2),
              Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Text(
                  "flash".tr(),
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),

              BlocBuilder<DiscountedBloc, DiscountedBlocState>(
                builder: (context, state) {
                  if (state is DiscountedBlocLoading) {
                    return SizedBox(
                      height: 220,
                      child: ListView.builder(
                          itemCount: 5,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return const ShimmerProductPortrait();
                          }),
                    );
                  } else if (state is DiscountedBlocError) {
                    return SizedBox(
                      height: 220,
                      child: ListView.builder(
                          itemCount: 5,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return const ShimmerProductPortrait();
                          }),
                    );
                  } else if (state is DiscountedBlocLoaded) {
                    final products = state.discountedProducts;

                    return SizedBox(
                      height: 220,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        // Find demoFlashSaleProducts on models/ProductModel.dart
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
                              context.read<MainProvider>().currentProductModel =
                                  products[index];
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
                    );
                  }
                  return Container();
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

class _barcodeItem extends StatelessWidget {
  const _barcodeItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AutoRouter.of(context).push(BonusCarRoute());
      },
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
        padding: EdgeInsets.all(16), // Padding inside the container
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Bonus Card',
                  style: TextStyle(color: kprimaryColor),
                ),
              ],
            ),
            BarcodeWidget(
              data: '123456789012', // Replace with dynamic barcode data
              barcode: Barcode.code128(),
              width: double.infinity,
              height: 120,
              drawText: false,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Show Bonus Points > ',
                  style: TextStyle(color: kprimaryColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
