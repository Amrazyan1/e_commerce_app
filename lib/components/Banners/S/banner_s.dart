import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../network_image_with_loader.dart';
import 'dart:ui' as ui;

class BannerS extends StatelessWidget {
  const BannerS(
      {super.key,
      required this.image,
      required this.press,
      required this.children});

  final String image;
  final VoidCallback press;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: context.locale.languageCode == 'fa'
          ? ui.TextDirection.rtl
          : ui.TextDirection.ltr,
      child: AspectRatio(
        aspectRatio: 2.56,
        child: GestureDetector(
          onTap: press,
          child: Stack(
            children: [
              NetworkImageWithLoader(image, radius: 0),
              ...children,
            ],
          ),
        ),
      ),
    );
  }
}
