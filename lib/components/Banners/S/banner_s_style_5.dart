import 'package:e_commerce_app/models/banner_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'dart:ui' as ui;

import '../../../constants.dart';
import '../../../services/api_service.dart';
import 'banner_s.dart';

class BannerSStyle5 extends StatefulWidget {
  BannerSStyle5({
    super.key,
    this.title,
    required this.press,
    this.subtitle,
    this.bottomText,
  });

  final String? title;
  final String? subtitle, bottomText;

  final VoidCallback press;

  @override
  State<BannerSStyle5> createState() => _BannerSStyle5State();
}

class _BannerSStyle5State extends State<BannerSStyle5> {
  String? image = '';

  @override
  void initState() {
    getOfferBanners();
    super.initState();
  }

  void getOfferBanners() async {
    final ApiService _apiService = GetIt.I<ApiService>();
    final response = await _apiService.getContentsByKeys('thirdBanner');
    final data = bannerModelResponseFromJson(response.data);
    if (data.data != null && data.data!.isNotEmpty) {
      setState(() {
        image = data.data!.first.src;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: context.locale.languageCode == 'fa'
          ? ui.TextDirection.rtl
          : ui.TextDirection.ltr,
      child: BannerS(
        image: image!,
        press: widget.press,
        children: [
          Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start, // Handles RTL layout
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (widget.subtitle != null)
                        const SizedBox(height: defaultPadding / 2),
                      Text(
                        widget.title ?? ''.toUpperCase(),
                        style: const TextStyle(
                          fontFamily: grandisExtendedFont,
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          height: 1,
                        ),
                      ),
                      if (widget.bottomText != null)
                        Text(
                          widget.bottomText!,
                          style: const TextStyle(
                            fontFamily: grandisExtendedFont,
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
