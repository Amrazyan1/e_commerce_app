import 'package:auto_route/auto_route.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:e_commerce_app/Provider/main_provider.dart';
import 'package:e_commerce_app/components/Banners/M/banner_m_with_counter.dart';
import 'package:e_commerce_app/router/router.gr.dart';
import 'package:e_commerce_app/screens/Products/Components/product_card.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/screens/Products/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FlashSale extends StatelessWidget {
  const FlashSale({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // While loading show 👇
        // const BannerMWithCounterSkelton(),
        // BannerMWithCounter(
        //   duration: const Duration(hours: 8),
        //   text: "Super Flash Sale \n50% Off",
        //   press: () {},
        // ),
        _barcodeItem(),
        const SizedBox(height: defaultPadding / 2),
        Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Text(
            "Flash sale",
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        // While loading show 👇
        // const ProductsSkelton(),
        SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            // Find demoFlashSaleProducts on models/ProductModel.dart
            itemCount: demoFlashSaleProducts.length,
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.only(
                left: defaultPadding,
                right: index == demoFlashSaleProducts.length - 1
                    ? defaultPadding
                    : 0,
              ),
              child: ProductCard(
                image: demoFlashSaleProducts[index].imageUrl,
                brandName: demoFlashSaleProducts[index].brandName,
                title: demoFlashSaleProducts[index].title,
                price: demoFlashSaleProducts[index].price,
                priceAfetDiscount:
                    demoFlashSaleProducts[index].priceAfetDiscount,
                dicountpercent:
                    '${demoFlashSaleProducts[index].dicountpercent}',
                press: () {
                  context.read<MainProvider>().currentProductModel =
                      demoPopularProducts[index];
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ProductDetailsScreen(),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
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
          boxShadow: [
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
            Row(
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
            Row(
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
