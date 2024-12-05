import 'package:e_commerce_app/components/country_codes.dart';
import 'package:flutter/material.dart';

class FlagWidget extends StatelessWidget {
  const FlagWidget({super.key, required this.countryCode, this.fontSize = 25});

  final String countryCode;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    final flag = countryCodesAndFlags[countryCode.toLowerCase()];

    if (flag != null) {
      return Text(
        flag,
        style: TextStyle(
          fontSize: fontSize,
        ),
      );
    }

    return const SizedBox.shrink();
  }
}
