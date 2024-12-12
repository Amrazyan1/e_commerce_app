import 'dart:async';
import 'package:e_commerce_app/Provider/main_provider.dart';
import 'package:e_commerce_app/models/banner_model.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/components/Banners/M/banner_m_style_1.dart';
import 'package:e_commerce_app/components/Banners/M/banner_m_style_2.dart';
import 'package:e_commerce_app/components/Banners/M/banner_m_style_3.dart';
import 'package:e_commerce_app/components/Banners/M/banner_m_style_4.dart';
import 'package:e_commerce_app/components/dot_indicators.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../services/api_service.dart';

class OffersCarousel extends StatefulWidget {
  const OffersCarousel({
    super.key,
  });

  @override
  State<OffersCarousel> createState() => _OffersCarouselState();
}

class _OffersCarouselState extends State<OffersCarousel> {

  // Offers List
  // List offers = [
  //   BannerMStyle1(
  //     text: "Fresh webetables",
  //     press: () {},
  //   ),
  //   BannerMStyle2(
  //     title: "Black \nfriday",
  //     subtitle: "Collection",
  //     discountParcent: 50,
  //     press: () {},
  //   ),
  //   BannerMStyle3(
  //     title: "Grab \nyours now",
  //     discountParcent: 50,
  //     press: () {},
  //   ),
  //   BannerMStyle4(
  //     title: "SUMMER \nSALE",
  //     subtitle: "SPECIAL OFFER",
  //     discountParcent: 80,
  //     press: () {},
  //   ),
  // ];
 
 

  @override
  Widget build(BuildContext context) {
    
    return Center(
      child: ClipRRect(
        borderRadius:
            BorderRadius.circular(15), // Rounded corners with radius 30
        child: SizedBox(
          width: 368, // Set width of the carousel
          height: 130, // Set height of the carousel
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              PageView.builder(
                controller: context.watch<MainProvider>().pageController,
                itemCount: context.watch<MainProvider>().offers.length,
                onPageChanged: (int index) {
                  context.read<MainProvider>().selectedIndex = index;
             
                },
                itemBuilder: (context, index) => context.watch<MainProvider>().offers[index],
              ),
              FittedBox(
                child: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: SizedBox(
                    height: 16,
                    child: Row(
                      children: List.generate(
                        context.watch<MainProvider>().offers.length,
                        (index) {
                          return Padding(
                            padding:
                                const EdgeInsets.only(left: defaultPadding / 4),
                            child: DotIndicator(
                              isActive: index == context.read<MainProvider>().selectedIndex,
                              activeColor: Colors.white70,
                              inActiveColor: Colors.white54,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
