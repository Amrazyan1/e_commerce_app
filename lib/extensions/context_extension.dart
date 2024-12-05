import 'package:flutter/material.dart';

import '../themes/app_colors.dart';

extension BuildContextExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);

  MediaQueryData get media => MediaQuery.of(this);

  double get height => media.size.height;

  double get width => media.size.width;

  double get topPadding => media.padding.top;

  double get bottomPadding => media.padding.bottom;

  double get viewInsetsBottom => media.viewInsets.bottom;

  double get viewInsetsTop => media.viewInsets.top;

  bool get isDarkMode => media.platformBrightness == Brightness.dark;
}

extension ThemeDataHelper on ThemeData {
  TextStyle get displayLarge => textTheme.displayLarge!;

  TextStyle get displayMedium => textTheme.displayMedium!;

  TextStyle get displaySmall => textTheme.displaySmall!;

  TextStyle get headlineMedium => textTheme.headlineMedium!;

  TextStyle get headlineLarge => textTheme.headlineLarge!;

  TextStyle get headlineSmall => textTheme.headlineSmall!;

  TextStyle get titleLarge => textTheme.titleLarge!;

  TextStyle get titleMedium => textTheme.titleMedium!;

  TextStyle get titleSmall => textTheme.titleSmall!;

  TextStyle get labelLarge => textTheme.labelLarge!;

  TextStyle get buttonSmall => textTheme.labelLarge!.copyWith(
        fontSize: 14,
        height: 1.4,
      );

  TextStyle get bodyLarge => textTheme.bodyLarge!;

  TextStyle get bodyMedium => textTheme.bodyMedium!;

  TextStyle get bodySmall => textTheme.bodySmall!;

  TextStyle get labelSmall => textTheme.labelSmall!;

  TextStyle get labelMedium => textTheme.labelMedium!;

  ButtonStyle get elevatedButtonStyle => elevatedButtonTheme.style!;

  Color get primary => colorScheme.primary;

  Color get secondary => colorScheme.secondary;

  Color get surface => colorScheme.surface;

  Color get primaryContainer => colorScheme.primaryContainer;

  Color get secondaryVariant => colorScheme.secondaryContainer;

  Color get background => colorScheme.background;

  Color get error => colorScheme.error;

  Color get onPrimary => colorScheme.onPrimary;

  Color get onSecondary => colorScheme.onSecondary;

  Color get onSurface => colorScheme.onSurface;

  Color get onBackground => colorScheme.onBackground;

  Color get onError => colorScheme.onError;

  Color get onPrimaryContainer => colorScheme.onPrimaryContainer;

  Brightness get brightness => colorScheme.brightness;

  bool get isDarkMode => brightness == Brightness.dark;

  Color get lightBlueGreen => isDarkMode
      ? AppColors.lightBlueGreen
      : AppColors.lightBlueGreen.darker(0.3);

  Color get shimmerBaseColor =>
      isDarkMode ? AppColors.secondaryDark : Colors.grey.shade300;

  Color get shimmerHighlightColor =>
      isDarkMode ? Colors.grey.shade600 : Colors.grey.shade100;

  Color get greenIconColor =>
      isDarkMode ? AppColors.senary : AppColors.iconColorDark;

  Color get primaryContainerDarkIconColor =>
      isDarkMode ? AppColors.primaryContainerDark : AppColors.iconColorDark;

  Color get newGroupButtonColor =>
      isDarkMode ? AppColors.white : AppColors.iconColorDark;

  Color get bubbleColor =>
      isDarkMode ? AppColors.bubbleColorDark : AppColors.brightGray;

  Color get popUpColor =>
      isDarkMode ? AppColors.popUpColorDark : AppColors.popUpColorLight;

  Color get popUpButtonColor =>
      isDarkMode ? AppColors.bubbleColorDark : AppColors.lightWhite;

  Color get navBarColor =>
      isDarkMode ? AppColors.lightWhite : AppColors.navBarColorLight;

  Color get onSecondaryColor =>
      isDarkMode ? AppColors.onSecondaryDark : AppColors.onSecondaryLight;

  Color get newContactButtonColor =>
      isDarkMode ? AppColors.white : AppColors.iconColorDark;

  Color get transparentFrameColor => isDarkMode
      ? AppColors.blurredColorDark.withOpacity(.1)
      : AppColors.secondaryLight.withOpacity(.6);

  Color get lightBlueGreenIcons =>
      isDarkMode ? AppColors.lightBlueGreen : AppColors.iconColorDark;

  Color get gradientBoxBackground =>
      isDarkMode ? AppColors.secondaryDark : AppColors.white;

  Color get brightnessButtonTextColorReverse =>
      isDarkMode ? AppColors.black : AppColors.white;

  Color get backgroundColor =>
      isDarkMode ? AppColors.backgroundDark : AppColors.backgroundLight;

  Color get brightnessTextColor =>
      isDarkMode ? AppColors.white : AppColors.black;

  Color get toolBarSpeedColor =>
      isDarkMode ? AppColors.black : AppColors.lightGray;

  Color get brightnessColors =>
      isDarkMode ? AppColors.lightWhite : AppColors.newBlack;

  Color get reversedBrightnessColors =>
      isDarkMode ? AppColors.newBlack : AppColors.lightWhite;

  Color get navBarBorderColor =>
      (isDarkMode ? AppColors.white : AppColors.backgroundDark)
          .withOpacity(.19);

  Color get toolBarSpeedTextColor =>
      isDarkMode ? AppColors.waterloo : AppColors.black;

  Color get chatAckColor =>
      isDarkMode ? AppColors.chatAckColorDark : AppColors.chatAckColorLight;

  Color get blueAndPrimary =>
      isDarkMode ? AppColors.primaryDark : AppColors.crayola;

  Color get whiteAndButtonColor =>
      isDarkMode ? AppColors.white : AppColors.buttonColor;

  Color get infoColor =>
      isDarkMode ? AppColors.white : AppColors.buttonColor.withOpacity(.6);

  Color get buttonLabelColor =>
      isDarkMode ? AppColors.labelColorDark : AppColors.labelColor;

  Color get iconColor => isDarkMode ? AppColors.iconDark : AppColors.iconLight;

  Color get animatedTabItemColor =>
      isDarkMode ? AppColors.charlestonGreen : AppColors.brightGray;

  Color get labelColor =>
      isDarkMode ? AppColors.labelColorDark : AppColors.labelColorLight;

  Color get brightnessDividerColor =>
      isDarkMode ? AppColors.dividerColorDark : AppColors.dividerColorLight;

  Color get searchTextFieldBackground =>
      isDarkMode ? AppColors.backgroundDark : AppColors.secondaryLight;

  Color get green =>
      isDarkMode ? AppColors.primaryContainerDark : AppColors.senaryDark;

  Color get themeModeSecondary =>
      isDarkMode ? AppColors.secondaryDark : AppColors.secondaryLight;

  Color get subtitleColor =>
      isDarkMode ? AppColors.subTitle2ColorDark : AppColors.subTitle2ColorLight;

  Color get brightnessIconColor =>
      isDarkMode ? AppColors.onBackgroundDark : AppColors.iconColor;

  Color get blurredColor =>
      isDarkMode ? AppColors.blurredColorDark : AppColors.blurredColorLight;

  Color get bottomAppNavBarColor => isDarkMode
      ? AppColors.bottomAppBarColor
      : AppColors.bottomAppBarColorLight;

  Color get avatarFixedColor => isDarkMode
      ? AppColors.white.withOpacity(.7)
      : AppColors.buttonColor.withOpacity(.6);

  Color get linkColor => isDarkMode ? AppColors.primaryDark : AppColors.black;

  Color get inputFieldLightBorder =>
      isDarkMode ? AppColors.white : AppColors.inputFieldLightBorder;

  Color get fieldLabelColor => isDarkMode
      ? AppColors.white.withOpacity(0.6)
      : AppColors.buttonColor.withOpacity(0.6);

  Color get fieldTextColor =>
      isDarkMode ? AppColors.inputFieldDarkText : AppColors.onPrimaryLight;

  Color get fieldBgColor =>
      isDarkMode ? AppColors.inputFieldDarkBg : AppColors.inputFillColorLight;

  Color get fieldBorderColor => isDarkMode
      ? AppColors.inputFieldDarkBorder
      : AppColors.inputFieldLightBorder;

  Color get descriptionColor => isDarkMode
      ? AppColors.white.withOpacity(0.6)
      : AppColors.subTitle2Color.withOpacity(0.6);

  Color get bottomSheetBgColor =>
      isDarkMode ? AppColors.bottomSheetDark : AppColors.backgroundLight;

  Color get messageFieldColor =>
      isDarkMode ? AppColors.iconDark : AppColors.messageFiledColorLight;

  Color get headingColor =>
      isDarkMode ? AppColors.white : AppColors.onPrimaryLight;

  Color get settingBgColor =>
      isDarkMode ? AppColors.backgroundDark : AppColors.conversationBgColor;

  Color get loadingIconColor =>
      isDarkMode ? AppColors.primaryLight : AppColors.inputFieldLightBorder;

  Color get textButtonColor =>
      isDarkMode ? AppColors.maximumGreenYellow : AppColors.subTitle2Color;

  Color get actionTitleColor => isDarkMode
      ? AppColors.white.withOpacity(.7)
      : AppColors.onPrimaryLight.withOpacity(.7);

  Color get actionButtonColor =>
      isDarkMode ? AppColors.white : AppColors.onPrimaryLight;

  Color get userInfoColor =>
      isDarkMode ? AppColors.popUpColorDark : AppColors.userInfoLight;

  Color get tabIconColor =>
      isDarkMode ? AppColors.graniteGray : AppColors.newBlack;

  Color get settingFillColor =>
      isDarkMode ? AppColors.inputFieldDarkBg : AppColors.platinumColor;

  Color get settingsIconColor =>
      isDarkMode ? AppColors.white : AppColors.iconColorDark;

  Color get cardItemBgColor =>
      isDarkMode ? AppColors.eerieBlack : AppColors.inputFieldLightBg;

  Color get descriptionTextColor =>
      isDarkMode ? AppColors.onBackgroundDark : AppColors.inputFieldLightBorder;
}

extension ElevatedButtonHelper on ButtonStyle {
  /*ButtonStyle buttonColor(Color color) => copyWith(
        shadowColor: WidgetStatePropertyAll(color.withOpacity(0.5)),
        foregroundColor: WidgetStatePropertyAll(AppColors.white),
        backgroundColor: MaterialStateProperty.resolveWith(
          (states) {
            return states.contains(MaterialState.disabled)
                ? color.withOpacity(0.5)
                : color;
          },
        ),
      );
*/
  ButtonStyle elevationSize(double elevation) {
    return copyWith(
      elevation: WidgetStatePropertyAll(
        elevation,
      ),
    );
  }

  ButtonStyle paddingAll(double padding) {
    return copyWith(
      padding: WidgetStatePropertyAll(
        EdgeInsets.all(padding),
      ),
    );
  }

  ButtonStyle paddingVertical(double padding) {
    return copyWith(
      padding: WidgetStatePropertyAll(
        EdgeInsets.symmetric(vertical: padding),
      ),
    );
  }

  ButtonStyle get removePaddings => copyWith(
        padding: const WidgetStatePropertyAll(
          EdgeInsets.zero,
        ),
      );

  ButtonStyle textColor(
    Color color,
  ) {
    return copyWith(
      foregroundColor: WidgetStatePropertyAll(
        color,
      ),
    );
  }
}

// usage example: context.h3.regular.white
extension TextStyleHelpers on TextStyle {
  /*TextStyle get white => copyWith(color: AppColors.white);

  TextStyle get yellow => copyWith(color: AppColors.yellow);

  TextStyle get darkGray => copyWith(color: AppColors.darkGray);

  TextStyle get mediumGray => copyWith(color: AppColors.grayMedium);

  TextStyle get charcoal => copyWith(color: AppColors.charcoal);

  TextStyle get red => copyWith(color: AppColors.red);

  TextStyle get chalkboardBlack => copyWith(color: AppColors.chalkboardBlack);

  TextStyle get burgundy => copyWith(color: AppColors.burgundy);

  TextStyle get error => copyWith(color: AppColors.error);

  TextStyle dynamic({
    Color lightColor = AppColors.white,
    Color darkColor = AppColors.darkGray,
    bool invertColor = false,
  }) {
    return copyWith(
      color: brightnessColor(
        lightColor: lightColor,
        darkColor: darkColor,
        invert: invertColor,
      ),
    );
  }
*/
  TextStyle size([double? fontSize]) => copyWith(fontSize: fontSize);

  TextStyle get regular => copyWith(fontWeight: FontWeight.w400);

  TextStyle get medium => copyWith(fontWeight: FontWeight.w500);

  TextStyle get bold => copyWith(fontWeight: FontWeight.w600);
}

extension GlobalKeyEx on GlobalKey {
  Rect? get globalPaintBounds {
    final renderObject = currentContext?.findRenderObject();
    final translation = renderObject?.getTransformTo(null).getTranslation();

    return translation != null && renderObject?.paintBounds != null
        ? renderObject!.paintBounds.shift(Offset(translation.x, translation.y))
        : null;
  }
}
