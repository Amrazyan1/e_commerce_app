import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:ui' as ui;

import '../../../constants.dart';
import 'banner_s.dart';

class BannerSStyle5 extends StatelessWidget {
  const BannerSStyle5({
    super.key,
    this.image = "https://pngimg.com/d/strawberry_PNG89.png",
    required this.title,
    required this.press,
    this.subtitle,
    this.bottomText,
  });

  final String? image;
  final String title;
  final String? subtitle, bottomText;

  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: context.locale.languageCode == 'ar'
          ? ui.TextDirection.rtl
          : ui.TextDirection.ltr,
      child: BannerS(
        image: image!,
        press: press,
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
                      if (subtitle != null)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: defaultPadding / 2,
                            vertical: defaultPadding / 8,
                          ),
                          color: Colors.white70,
                          child: Text(
                            subtitle!,
                            style: const TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      const SizedBox(height: defaultPadding / 2),
                      Text(
                        title.toUpperCase(),
                        style: const TextStyle(
                          fontFamily: grandisExtendedFont,
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          height: 1,
                        ),
                      ),
                      if (bottomText != null)
                        Text(
                          bottomText!,
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
                const SizedBox(width: defaultPadding),
                SvgPicture.asset(
                  "assets/icons/Child.svg",
                  height: 28,
                  colorFilter:
                      const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
