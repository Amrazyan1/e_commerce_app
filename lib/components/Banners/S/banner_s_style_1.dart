import 'package:e_commerce_app/components/Banners/M/banner_discount_tag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';

import '../../../constants.dart';
import '../../../models/banner_model.dart';
import '../../../services/api_service.dart';
import 'banner_s.dart';

class BannerSStyle1 extends StatefulWidget {
  BannerSStyle1({
    super.key,
    required this.title,
    required this.press,
    this.subtitle,
    this.discountParcent,
  });
  final String title;
  final String? subtitle;
  final int? discountParcent;
  final VoidCallback press;

  @override
  State<BannerSStyle1> createState() => _BannerSStyle1State();
}

class _BannerSStyle1State extends State<BannerSStyle1> {
  String? image = '';

  @override
  void initState() {
    getOfferBanners();
    super.initState();
  }

  void getOfferBanners() async {
    final ApiService _apiService = GetIt.I<ApiService>();
    final response = await _apiService.getContentsByKeys('secondBanner');
    final data = bannerModelResponseFromJson(response.data);
    if (data.data != null && data.data!.isNotEmpty) {
      setState(() {
        image = data.data!.first.src;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BannerS(
      image: image!,
      press: widget.press,
      children: [
        Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title.toUpperCase(),
                      style: const TextStyle(
                        fontFamily: grandisExtendedFont,
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        height: 1,
                      ),
                    ),
                    const SizedBox(height: defaultPadding / 4),
                    if (widget.subtitle != null)
                      Text(
                        widget.subtitle!.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Visibility(
          visible: widget.discountParcent != null,
          child: Align(
            alignment: Alignment.topCenter,
            child: BannerDiscountTag(
              percentage: widget.discountParcent ?? 0,
              height: 56,
            ),
          ),
        ),
      ],
    );
  }
}
