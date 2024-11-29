import 'package:flutter/material.dart';

import '../../../../../constants.dart';
import 'categories.dart';
import 'offers_carousel.dart';

class OffersCarouselAndCategories extends StatelessWidget {
  const OffersCarouselAndCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // While loading use 👇
        // const OffersSkelton(),
        Padding(
          padding: EdgeInsets.only(left: 16, right: 16),
          child: OffersCarousel(),
        ),
        // const SizedBox(height: defaultPadding / 2),
        // Padding(
        //   padding: const EdgeInsets.all(defaultPadding),
        //   child: Text(
        //     "Categories",
        //     style: Theme.of(context).textTheme.titleSmall,
        //   ),
        // ),
        // // While loading use 👇
        // // const CategoriesSkelton(),
        // const Categories(),
      ],
    );
  }
}
