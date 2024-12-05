import 'package:e_commerce_app/extensions/context_extension.dart';
import 'package:e_commerce_app/themes/app_colors.dart';
import 'package:flutter/material.dart';

import '../Provider/screen_service.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    this.icon,
    this.action,
    this.iconSize,
    this.size = 14,
    this.radius = 10,
    this.iconColor,
    this.borderColor,
    this.vector,
    this.withBorder = true,
    this.title,
  });

  final IconData? icon;
  final String? vector;
  final VoidCallback? action;
  final double size;
  final double? iconSize;
  final double radius;
  final Color? iconColor;
  final Color? borderColor;
  final bool withBorder;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: IconButton(
        onPressed: action ?? router.maybePop,
        padding: EdgeInsets.zero,
        icon: Container(
          margin: withBorder ? EdgeInsets.all(size / 1.4) : EdgeInsets.zero,
          decoration: withBorder
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(radius),
                  border: Border.all(
                    color: borderColor ??
                        context.theme.onBackground.withOpacity(.2),
                    width: 2,
                  ),
                )
              : null,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon == null)
                Container()
              else
                Icon(
                  icon,
                  size: iconSize ?? size,
                  color: iconColor ?? context.theme.brightnessTextColor,
                ),
              Text(
                title ?? '',
                style: context.theme.labelLarge.copyWith(
                  color: AppColors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
