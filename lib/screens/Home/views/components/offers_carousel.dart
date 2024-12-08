import 'dart:async';
import 'package:e_commerce_app/models/banner_model.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/components/Banners/M/banner_m_style_1.dart';
import 'package:e_commerce_app/components/Banners/M/banner_m_style_2.dart';
import 'package:e_commerce_app/components/Banners/M/banner_m_style_3.dart';
import 'package:e_commerce_app/components/Banners/M/banner_m_style_4.dart';
import 'package:e_commerce_app/components/dot_indicators.dart';
import 'package:e_commerce_app/constants.dart';
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
  int _selectedIndex = 0;
  late PageController _pageController;
  late Timer _timer;

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
  List offers = [];
  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    getOfferBanners();
    super.initState();
  }

  void getOfferBanners() async {
    final ApiService _apiService = GetIt.I<ApiService>();
    final response = await _apiService.getContentsByKeys('firstBanner');
    final data = bannerModelResponseFromJson(response.data);
    if (data.data != null && data.data!.isNotEmpty) {
      setState(() {
        for (var element in data.data!) {
          offers.add(BannerMStyle1(
            press: () {},
            text: element.description ?? '',
            image: element.src,
          ));
        }
        _timer = Timer.periodic(const Duration(seconds: 4), (Timer timer) {
          if (_selectedIndex < offers.length - 1) {
            _selectedIndex++;
          } else {
            _selectedIndex = 0;
          }

          _pageController.animateToPage(
            _selectedIndex,
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeOutCubic,
          );
        });
      });
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

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
                controller: _pageController,
                itemCount: offers.length,
                onPageChanged: (int index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                itemBuilder: (context, index) => offers[index],
              ),
              FittedBox(
                child: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: SizedBox(
                    height: 16,
                    child: Row(
                      children: List.generate(
                        offers.length,
                        (index) {
                          return Padding(
                            padding:
                                const EdgeInsets.only(left: defaultPadding / 4),
                            child: DotIndicator(
                              isActive: index == _selectedIndex,
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
