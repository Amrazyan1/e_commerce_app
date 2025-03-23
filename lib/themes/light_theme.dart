import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import 'app_colors.dart';
import 'app_fonts.dart';

final base = ThemeData(
  fontFamily: FontFamily.SFProDisplay,
  useMaterial3: false,
  brightness: Brightness.light,
  fontFamilyFallback: Platform.isAndroid
      ? [
          FontFamily.AppleColorEmoji,
        ]
      : null,
  extensions: const <ThemeExtension>[
    WoltModalSheetThemeData(
      mainContentScrollPhysics: NeverScrollableScrollPhysics(),
    ),
  ],
);

final lightTheme = base.copyWith(
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  hoverColor: Colors.transparent,
  primaryColor: AppColors.primaryLight,
  expansionTileTheme: base.expansionTileTheme.copyWith(
    iconColor: AppColors.newBlack,
    collapsedIconColor: AppColors.newBlack,
    collapsedTextColor: base.primaryColor,
    clipBehavior: Clip.none,
    shape: Border.all(color: AppColors.backgroundLight),
    collapsedShape: Border.all(color: AppColors.backgroundLight),
    tilePadding: const EdgeInsets.symmetric(horizontal: 16),
  ),
  colorScheme: base.colorScheme.copyWith(
    brightness: Brightness.light,
    primary: AppColors.primaryLight,
    primaryContainer: AppColors.primaryContainerLight,
    secondary: AppColors.secondaryLight,
    background: AppColors.backgroundLight,
    surface: AppColors.surfaceLight,
    error: AppColors.error,
    onPrimary: AppColors.onPrimaryLight,
    onSecondary: AppColors.onSecondaryLight,
    onBackground: AppColors.onBackgroundLight,
    onPrimaryContainer: AppColors.subTitle2ColorLight,
    onSurface: AppColors.black,
    onError: AppColors.onErrorLight,
  ),
  cardTheme: CardThemeData(
    color: base.dialogBackgroundColor,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    clipBehavior: Clip.none,
  ),
  tabBarTheme: TabBarThemeData(
    unselectedLabelStyle: base.primaryTextTheme.labelLarge!.copyWith(
      color: AppColors.primaryLight,
    ),
    labelStyle: const TextStyle(
      color: AppColors.primaryLight,
      fontWeight: FontWeight.normal,
      fontSize: 16,
      height: 1,
    ),
    indicator: BoxDecoration(
      borderRadius: BorderRadius.circular(13),
      color: AppColors.primaryLight,
    ),
    indicatorSize: TabBarIndicatorSize.tab,
    labelColor: AppColors.primaryLight,
    unselectedLabelColor: AppColors.primaryLight,
    labelPadding: const EdgeInsets.symmetric(
      horizontal: 10,
      vertical: 5,
    ),
  ),
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    },
  ),
  scaffoldBackgroundColor: AppColors.backgroundLight,
  drawerTheme: const DrawerThemeData(
    backgroundColor: AppColors.backgroundLight,
  ),
  dividerColor: AppColors.dividerColor.withOpacity(.19),
  dividerTheme: base.dividerTheme.copyWith(
    space: 1,
    thickness: 1,
    indent: 0,
    endIndent: 0,
    color: AppColors.dividerColor.withOpacity(.19),
  ),
  primaryIconTheme: base.primaryIconTheme.copyWith(color: AppColors.primaryLight),
  iconTheme: base.iconTheme.copyWith(color: AppColors.iconLight),
  appBarTheme: base.appBarTheme.copyWith(
    centerTitle: false,
    titleSpacing: 20,
    iconTheme: const IconThemeData(
      color: AppColors.primaryLight,
    ),
    elevation: 0,
    scrolledUnderElevation: 0,
    backgroundColor: AppColors.backgroundLight,
    shadowColor: AppColors.primaryLight.withOpacity(0.15),
    titleTextStyle: base.primaryTextTheme.titleLarge!.copyWith(
      color: AppColors.black,
      fontWeight: FontWeight.w600,
      fontSize: 26,
    ),
    systemOverlayStyle: const SystemUiOverlayStyle(
      systemNavigationBarColor: AppColors.backgroundLight,
      systemNavigationBarDividerColor: AppColors.backgroundLight,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
    ),
    toolbarTextStyle: base.textTheme
        .copyWith(
          bodyLarge: base.textTheme.bodyLarge!.copyWith(
            color: AppColors.primaryLight,
            fontWeight: FontWeight.bold,
          ),
          titleLarge: base.textTheme.titleLarge!.copyWith(
            color: AppColors.black,
            fontWeight: FontWeight.bold,
          ),
          displaySmall: base.textTheme.displaySmall!.copyWith(
            color: AppColors.primaryLight,
            fontWeight: FontWeight.bold,
          ),
          headlineMedium: base.textTheme.headlineMedium!.copyWith(
            color: AppColors.primaryLight,
            fontWeight: FontWeight.w500,
          ),
        )
        .bodyMedium,
  ),
  bottomNavigationBarTheme: base.bottomNavigationBarTheme.copyWith(
    backgroundColor: AppColors.bottomAppBarColor,
    selectedItemColor: AppColors.black,
    unselectedItemColor: AppColors.iconLight,
    selectedLabelStyle: base.textTheme.bodyMedium,
    unselectedLabelStyle: base.textTheme.bodyLarge,
    elevation: 4,
    type: BottomNavigationBarType.shifting,
  ),
  chipTheme: base.chipTheme.copyWith(
    backgroundColor: Colors.transparent,
    labelPadding: const EdgeInsets.symmetric(horizontal: 20),
    labelStyle: const TextStyle(
      color: AppColors.primaryLight,
      fontWeight: FontWeight.w500,
    ),
    selectedColor: AppColors.primaryLight,
    secondaryLabelStyle: const TextStyle(
      color: AppColors.primaryLight,
      fontWeight: FontWeight.w500,
    ),
    secondarySelectedColor: Colors.transparent,
  ),
  sliderTheme: base.sliderTheme.copyWith(
    activeTrackColor: AppColors.primaryLight,
    inactiveTrackColor: AppColors.primaryLight,
    overlayColor: Colors.transparent,
    thumbColor: AppColors.primaryLight,
    thumbShape: SliderComponentShape.noOverlay,
    valueIndicatorColor: AppColors.primaryLight,
  ),
  textSelectionTheme: base.textSelectionTheme.copyWith(
    cursorColor: AppColors.primaryLight,
    selectionHandleColor: AppColors.primaryLight,
  ),
  cupertinoOverrideTheme: const CupertinoThemeData(
    primaryColor: AppColors.primaryLight,
  ),
  brightness: Brightness.light,
  inputDecorationTheme: base.inputDecorationTheme.copyWith(
    prefixStyle: base.textTheme.bodyLarge!.copyWith(
      color: AppColors.onSecondaryLight,
    ),
    disabledBorder: InputBorder.none,
    errorStyle: const TextStyle(
      color: AppColors.error,
      fontWeight: FontWeight.w400,
      height: 1.2,
    ),
    hintStyle: base.primaryTextTheme.bodyLarge!.copyWith(
      color: AppColors.inputFieldLightText,
      fontWeight: FontWeight.w400,
      fontSize: 14,
      height: 1.2,
    ),
    fillColor: AppColors.inputFillColorLight,
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 10,
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.inputFieldLightBorder.withOpacity(.1),
      ),
      borderRadius: const BorderRadius.all(Radius.circular(8)),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.inputFieldLightBorder.withOpacity(.1),
      ),
      borderRadius: const BorderRadius.all(Radius.circular(8)),
    ),
    errorBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.error,
      ),
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.inputFieldLightBorder.withOpacity(.4), //AppColors.inputFieldLightBorder.withOpacity(.3),
      ),
      borderRadius: const BorderRadius.all(Radius.circular(8)),
    ),
    filled: true,
    labelStyle: TextStyle(
      color: AppColors.onSecondaryLight.withOpacity(.6),
      fontWeight: FontWeight.w400,
      fontSize: 10,
      height: 1,
    ),
  ),
  buttonTheme: base.buttonTheme.copyWith(
    textTheme: ButtonTextTheme.primary,
    buttonColor: AppColors.primaryLight,
  ),
  toggleButtonsTheme: ToggleButtonsThemeData(
    borderRadius: BorderRadius.circular(4),
    borderColor: AppColors.primaryLight,
    color: AppColors.primaryLight,
    selectedBorderColor: AppColors.primaryLight,
    selectedColor: AppColors.onPrimaryLight,
    fillColor: AppColors.primaryLight,
    constraints: const BoxConstraints(minHeight: 38, minWidth: 64),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      padding: const WidgetStatePropertyAll(
        EdgeInsets.symmetric(
          horizontal: 36,
          vertical: 16,
        ),
      ),
      elevation: const WidgetStatePropertyAll(0),
      textStyle: WidgetStatePropertyAll(base.textTheme.bodyLarge),
      shape: WidgetStateProperty.resolveWith(
        (states) {
          return RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(
              color: states.contains(WidgetState.disabled) ? AppColors.onSurfaceLight : AppColors.primaryLight,
            ),
          );
        },
      ),
      foregroundColor: const WidgetStatePropertyAll(AppColors.white),
      backgroundColor: WidgetStateProperty.resolveWith(
        (states) {
          return states.contains(WidgetState.disabled) ? AppColors.onSurfaceLight : Colors.transparent;
        },
      ),
    ),
  ),
  iconButtonTheme: IconButtonThemeData(
    style: ButtonStyle(
      padding: const WidgetStatePropertyAll(
        EdgeInsets.zero,
      ),
      elevation: const WidgetStatePropertyAll(0),
      textStyle: WidgetStatePropertyAll(base.textTheme.bodyLarge),
      shape: WidgetStateProperty.resolveWith(
        (states) {
          return RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(
              color: states.contains(WidgetState.disabled) ? AppColors.onSurfaceLight : AppColors.primaryLight,
            ),
          );
        },
      ),
      foregroundColor: const WidgetStatePropertyAll(AppColors.white),
      backgroundColor: WidgetStateProperty.resolveWith(
        (states) {
          return states.contains(WidgetState.disabled) ? AppColors.onSurfaceLight : Colors.transparent;
        },
      ),
    ),
  ),
  tooltipTheme: TooltipThemeData(
    preferBelow: false,
    decoration: BoxDecoration(
      color: AppColors.primaryLight,
      borderRadius: BorderRadius.circular(8),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      padding: const WidgetStatePropertyAll(
        EdgeInsets.symmetric(
          horizontal: 36,
          vertical: 16,
        ),
      ),
      overlayColor: const WidgetStatePropertyAll(
        Colors.transparent,
      ),
      elevation: const WidgetStatePropertyAll(0),
      textStyle: WidgetStatePropertyAll(
        base.textTheme.bodyLarge!.copyWith(
          color: AppColors.onPrimaryLight,
          fontWeight: FontWeight.w700,
          fontSize: 14,
          height: 1.2,
        ),
      ),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
      ),
      foregroundColor: const WidgetStatePropertyAll(AppColors.white),
      backgroundColor: WidgetStateProperty.resolveWith(
        (states) {
          return states.contains(WidgetState.disabled) ? AppColors.onSurfaceLight : AppColors.primaryLight;
        },
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      padding: const WidgetStatePropertyAll(
        EdgeInsets.symmetric(
          horizontal: 32,
          vertical: 16,
        ),
      ),
      overlayColor: const WidgetStatePropertyAll(
        Colors.transparent,
      ),
      elevation: const WidgetStatePropertyAll(0),
      textStyle: WidgetStatePropertyAll(
        base.textTheme.bodyLarge!.copyWith(
          color: AppColors.black,
          fontWeight: FontWeight.w700,
          fontSize: 14,
          height: 1.2,
        ),
      ),
      side: const WidgetStatePropertyAll(
        BorderSide(color: AppColors.subTitle2ColorDark),
      ),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
          side: const BorderSide(
            color: AppColors.lightGray,
          ),
        ),
      ),
      foregroundColor: const WidgetStatePropertyAll(AppColors.black),
      backgroundColor: const WidgetStatePropertyAll(Colors.transparent),
    ),
  ),
  textTheme: base.textTheme.copyWith(
    titleLarge: base.textTheme.titleLarge!.copyWith(
      color: AppColors.black,
      fontWeight: FontWeight.w600,
      fontSize: 18,
      letterSpacing: 0,
    ),
    displayLarge: base.textTheme.displayLarge!.copyWith(
      color: AppColors.onSecondaryLight,
      fontWeight: FontWeight.w700,
      fontSize: 36,
      letterSpacing: 0,
    ),
    labelMedium: base.textTheme.labelMedium!.copyWith(
      color: AppColors.onSecondaryLight,
      fontWeight: FontWeight.w600,
      fontSize: 26,
      letterSpacing: 0,
    ),
    displayMedium: base.textTheme.displayMedium!.copyWith(
      color: AppColors.onSecondaryLight,
      fontWeight: FontWeight.w600,
      fontSize: 32,
      letterSpacing: 0,
    ),
    displaySmall: base.textTheme.displaySmall!.copyWith(
      color: AppColors.onSecondaryLight,
      fontWeight: FontWeight.w400,
      fontSize: 12,
      letterSpacing: 0,
    ),
    headlineMedium: base.textTheme.headlineMedium!.copyWith(
      color: AppColors.onSecondaryLight,
      fontWeight: FontWeight.w600,
      fontSize: 12,
      letterSpacing: 0,
    ),
    headlineLarge: base.textTheme.headlineLarge!.copyWith(
      color: AppColors.onBackgroundLight,
      fontWeight: FontWeight.w600,
      fontSize: 16,
      letterSpacing: 0,
    ),
    headlineSmall: base.textTheme.headlineSmall!.copyWith(
      color: AppColors.onSecondaryLight,
      fontWeight: FontWeight.w700,
      fontSize: 15,
      letterSpacing: 0,
    ),
    bodyLarge: base.textTheme.bodyLarge!.copyWith(
      color: AppColors.onPrimaryLight,
      fontWeight: FontWeight.w600,
      fontSize: 16,
      letterSpacing: 0,
    ),
    bodyMedium: base.textTheme.bodyMedium!.copyWith(
      color: AppColors.onSecondaryLight,
      fontWeight: FontWeight.w700,
      fontSize: 10,
      letterSpacing: 0,
    ),
    labelSmall: base.textTheme.labelSmall!.copyWith(
      color: AppColors.onPrimaryLight,
      fontWeight: FontWeight.w500,
      fontSize: 14,
      letterSpacing: 0,
    ),
    titleMedium: base.textTheme.titleMedium!.copyWith(
      color: AppColors.onSecondaryLight,
      fontWeight: FontWeight.w600,
      fontSize: 11,
      letterSpacing: 0,
    ),
    labelLarge: base.textTheme.labelLarge!.copyWith(
      color: AppColors.onSecondaryLight,
      fontWeight: FontWeight.w600,
      fontSize: 16,
      letterSpacing: 0,
    ),
    titleSmall: base.textTheme.titleSmall!.copyWith(
      color: AppColors.onSecondaryLight,
      fontWeight: FontWeight.w400,
      fontSize: 13,
      letterSpacing: 0,
    ),
    bodySmall: base.textTheme.bodySmall!.copyWith(
      color: AppColors.error,
      fontWeight: FontWeight.w600,
      fontSize: 13,
      letterSpacing: 0,
    ),
  ),
  checkboxTheme: CheckboxThemeData(
    fillColor: WidgetStateProperty.resolveWith<Color?>((states) {
      if (states.contains(WidgetState.disabled)) {
        return null;
      }
      if (states.contains(WidgetState.selected)) {
        return AppColors.primaryLight;
      }
      return null;
    }),
  ),
  radioTheme: RadioThemeData(
    fillColor: WidgetStateProperty.resolveWith<Color?>((states) {
      if (states.contains(WidgetState.disabled)) {
        return null;
      }
      if (states.contains(WidgetState.selected)) {
        return AppColors.primaryLight;
      }
      return null;
    }),
  ),
  switchTheme: base.switchTheme
      .copyWith(
    trackColor: const WidgetStatePropertyAll(AppColors.primaryLight),
    thumbColor: const WidgetStatePropertyAll(AppColors.dark),
  )
      .copyWith(
    thumbColor: WidgetStateProperty.resolveWith<Color?>((states) {
      if (states.contains(WidgetState.disabled)) {
        return null;
      }
      if (states.contains(WidgetState.selected)) {
        return AppColors.primaryLight;
      }
      return null;
    }),
    trackColor: WidgetStateProperty.resolveWith<Color?>((states) {
      if (states.contains(WidgetState.disabled)) {
        return null;
      }
      if (states.contains(WidgetState.selected)) {
        return AppColors.primaryLight;
      }
      return null;
    }),
  ),
);
