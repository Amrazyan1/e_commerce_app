import 'dart:io';

import 'package:e_commerce_app/components/background_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import 'app_colors.dart';
import 'app_fonts.dart';

final base = ThemeData(
  fontFamily: FontFamily.SFProDisplay,
  useMaterial3: false,
  brightness: Brightness.dark,
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

final darkTheme = base.copyWith(
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  hoverColor: Colors.transparent,
  primaryColor: AppColors.primaryDark,
  expansionTileTheme: base.expansionTileTheme.copyWith(
    iconColor: AppColors.lightWhite,
    collapsedIconColor: AppColors.lightWhite,
    collapsedTextColor: base.primaryColor,
    clipBehavior: Clip.none,
    shape: Border.all(color: AppColors.backgroundDark),
    collapsedShape: Border.all(color: AppColors.backgroundDark),
    tilePadding: const EdgeInsets.symmetric(horizontal: 16),
  ),
  colorScheme: base.colorScheme.copyWith(
    brightness: Brightness.dark,
    primary: AppColors.primaryDark,
    primaryContainer: AppColors.primaryContainerDark,
    secondary: AppColors.secondaryDark,
    background: AppColors.backgroundDark,
    surface: AppColors.surfaceDark,
    error: AppColors.error,
    onPrimary: AppColors.onPrimaryDark,
    onSecondary: AppColors.onSecondaryDark,
    onBackground: AppColors.onBackgroundDark,
    onPrimaryContainer: AppColors.subTitle2ColorDark,
    onSurface: AppColors.onSurfaceDark,
    onError: AppColors.onErrorDark,
  ),
  cardTheme: CardTheme(
    color: base.dialogBackgroundColor,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    clipBehavior: Clip.none,
  ),
  tabBarTheme: TabBarTheme(
    unselectedLabelStyle: base.primaryTextTheme.labelLarge!.copyWith(
      color: AppColors.primaryDark,
    ),
    labelStyle: const TextStyle(
      color: AppColors.primaryDark,
      fontWeight: FontWeight.normal,
      fontSize: 16,
      height: 1,
    ),
    indicator: BoxDecoration(
      borderRadius: BorderRadius.circular(13),
      color: AppColors.primaryDark,
    ),
    indicatorSize: TabBarIndicatorSize.tab,
    labelColor: AppColors.primaryDark,
    unselectedLabelColor: AppColors.primaryDark,
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
  scaffoldBackgroundColor: AppColors.backgroundDark,
  drawerTheme: const DrawerThemeData(
    backgroundColor: AppColors.backgroundDark,
  ),
  dividerColor: AppColors.dividerColor,
  dividerTheme: base.dividerTheme.copyWith(
    space: 1,
    thickness: 1,
    indent: 0,
    endIndent: 0,
    color: AppColors.dividerColor,
  ),
  primaryIconTheme:
      base.primaryIconTheme.copyWith(color: AppColors.primaryDark),
  iconTheme: base.iconTheme.copyWith(color: AppColors.iconDark),
  appBarTheme: base.appBarTheme.copyWith(
    centerTitle: false,
    titleSpacing: 20,
    iconTheme: const IconThemeData(
      color: AppColors.primaryDark,
    ),
    elevation: 0,
    scrolledUnderElevation: 0,
    backgroundColor: AppColors.backgroundDark,
    shadowColor: AppColors.primaryDark.withOpacity(0.15),
    titleTextStyle: base.primaryTextTheme.titleLarge!.copyWith(
      color: AppColors.white,
      fontWeight: FontWeight.w600,
      fontSize: 26,
    ),
    systemOverlayStyle: const SystemUiOverlayStyle(
      systemNavigationBarColor: AppColors.backgroundDark,
      systemNavigationBarDividerColor: AppColors.backgroundDark,
      systemNavigationBarIconBrightness: Brightness.light,
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
    ),
    toolbarTextStyle: base.textTheme
        .copyWith(
          bodyLarge: base.textTheme.bodyLarge!.copyWith(
            color: AppColors.primaryDark,
            fontWeight: FontWeight.bold,
          ),
          titleLarge: base.textTheme.titleLarge!.copyWith(
            color: AppColors.primaryDark,
            fontWeight: FontWeight.bold,
          ),
          displaySmall: base.textTheme.displaySmall!.copyWith(
            color: AppColors.primaryDark,
            fontWeight: FontWeight.bold,
          ),
          headlineMedium: base.textTheme.headlineMedium!.copyWith(
            color: AppColors.primaryDark,
            fontWeight: FontWeight.w500,
          ),
        )
        .bodyMedium,
  ),
  bottomNavigationBarTheme: base.bottomNavigationBarTheme.copyWith(
    backgroundColor: AppColors.bottomAppBarColor,
    selectedItemColor: AppColors.white,
    unselectedItemColor: AppColors.iconDark,
    selectedLabelStyle: base.textTheme.bodyMedium,
    unselectedLabelStyle: base.textTheme.bodyLarge,
    elevation: 4,
    type: BottomNavigationBarType.shifting,
  ),
  chipTheme: base.chipTheme.copyWith(
    backgroundColor: Colors.transparent,
    labelPadding: const EdgeInsets.symmetric(horizontal: 20),
    labelStyle: const TextStyle(
      color: AppColors.primaryDark,
      fontWeight: FontWeight.w500,
    ),
    selectedColor: AppColors.primaryDark,
    secondaryLabelStyle: const TextStyle(
      color: AppColors.primaryDark,
      fontWeight: FontWeight.w500,
    ),
    secondarySelectedColor: Colors.transparent,
  ),
  sliderTheme: base.sliderTheme.copyWith(
    activeTrackColor: AppColors.primaryDark,
    inactiveTrackColor: AppColors.primaryDark,
    overlayColor: Colors.transparent,
    thumbColor: AppColors.primaryDark,
    thumbShape: SliderComponentShape.noOverlay,
    valueIndicatorColor: AppColors.primaryDark,
  ),
  textSelectionTheme: base.textSelectionTheme.copyWith(
    cursorColor: AppColors.primaryDark,
    selectionHandleColor: AppColors.primaryDark,
  ),
  cupertinoOverrideTheme: const CupertinoThemeData(
    primaryColor: AppColors.primaryDark,
  ),
  brightness: Brightness.dark,
  inputDecorationTheme: base.inputDecorationTheme.copyWith(
    prefixStyle: base.textTheme.bodyLarge!.copyWith(
      color: AppColors.onSecondaryDark,
    ),
    disabledBorder: InputBorder.none,
    errorStyle: const TextStyle(
      color: AppColors.error,
      fontWeight: FontWeight.w400,
      height: 1.2,
    ),
    hintStyle: base.primaryTextTheme.bodyLarge!.copyWith(
      color: AppColors.inputFieldDarkText,
      fontWeight: FontWeight.w400,
      fontSize: 14,
      height: 1.2,
    ),
    fillColor: Colors.transparent,
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 10,
    ),
    border: const OutlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.inputFieldDarkBorder,
      ),
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.inputFieldDarkBorder,
      ),
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    errorBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.error,
      ),
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.white,
      ),
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    filled: true,
    labelStyle: TextStyle(
      color: AppColors.onSecondaryDark.withOpacity(.6),
      fontWeight: FontWeight.w400,
      fontSize: 10,
      height: 1,
    ),
  ),
  buttonTheme: base.buttonTheme.copyWith(
    textTheme: ButtonTextTheme.primary,
    buttonColor: AppColors.primaryDark,
  ),
  toggleButtonsTheme: ToggleButtonsThemeData(
    borderRadius: BorderRadius.circular(4),
    borderColor: AppColors.primaryDark,
    color: AppColors.primaryDark,
    selectedBorderColor: AppColors.primaryDark,
    selectedColor: AppColors.onPrimaryDark,
    fillColor: AppColors.primaryDark,
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
              color: states.contains(WidgetState.disabled)
                  ? AppColors.onSurfaceDark
                  : AppColors.primaryDark,
            ),
          );
        },
      ),
      foregroundColor: const WidgetStatePropertyAll(AppColors.white),
      backgroundColor: WidgetStateProperty.resolveWith(
        (states) {
          return states.contains(WidgetState.disabled)
              ? AppColors.onSurfaceDark
              : Colors.transparent;
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
              color: states.contains(WidgetState.disabled)
                  ? AppColors.onSurfaceDark
                  : AppColors.primaryLight,
            ),
          );
        },
      ),
      foregroundColor: const WidgetStatePropertyAll(AppColors.white),
      backgroundColor: WidgetStateProperty.resolveWith(
        (states) {
          return states.contains(WidgetState.disabled)
              ? AppColors.onSurfaceDark
              : Colors.transparent;
        },
      ),
    ),
  ),
  tooltipTheme: TooltipThemeData(
    preferBelow: false,
    decoration: BoxDecoration(
      color: AppColors.primaryDark,
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
          color: AppColors.onPrimaryDark,
          fontWeight: FontWeight.w700,
          fontSize: 14,
          height: 1.2,
        ),
      ),
      shape: WidgetStateProperty.resolveWith(
        (states) {
          return states.contains(WidgetState.disabled)
              ? RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                  side: BorderSide(
                    color: AppColors.blurredDividerColor.withOpacity(.2),
                  ),
                )
              : RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                );
        },
      ),
      foregroundColor: const WidgetStatePropertyAll(AppColors.onPrimaryDark),
      backgroundColor: WidgetStateProperty.resolveWith(
        (states) {
          return states.contains(WidgetState.disabled)
              ? Colors.transparent
              : AppColors.primaryDark;
        },
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      // shadowColor: WidgetStatePropertyAll(AppColors.primary),
      padding: const WidgetStatePropertyAll(
        EdgeInsets.symmetric(
          horizontal: 32,
          vertical: 16,
        ),
      ),
      overlayColor: const WidgetStatePropertyAll(Colors.transparent),
      elevation: const WidgetStatePropertyAll(0),
      textStyle: WidgetStatePropertyAll(
        base.textTheme.bodyLarge!.copyWith(
          color: AppColors.onPrimaryDark,
          fontWeight: FontWeight.w700,
          fontSize: 14,
          height: 1.2,
        ),
      ),
      side: const WidgetStatePropertyAll(
        BorderSide(color: AppColors.lightGray),
      ),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
          side: const BorderSide(
            color: AppColors.lightGray,
          ),
        ),
      ),
      foregroundColor: const WidgetStatePropertyAll(AppColors.white),
      backgroundColor: const WidgetStatePropertyAll(Colors.transparent),
    ),
  ),
  textTheme: base.textTheme.copyWith(
    titleLarge: base.textTheme.titleLarge!.copyWith(
      color: AppColors.onPrimaryDark,
      fontWeight: FontWeight.w600,
      fontSize: 18,
      letterSpacing: 0,
    ),
    displayLarge: base.textTheme.displayLarge!.copyWith(
      color: AppColors.onSecondaryDark,
      fontWeight: FontWeight.w700,
      fontSize: 36,
      letterSpacing: 0,
    ),
    labelMedium: base.textTheme.labelMedium!.copyWith(
      color: AppColors.onSecondaryDark,
      fontWeight: FontWeight.w600,
      fontSize: 26,
      letterSpacing: 0,
    ),
    displayMedium: base.textTheme.displayMedium!.copyWith(
      color: AppColors.onSecondaryDark,
      fontWeight: FontWeight.w600,
      fontSize: 32,
      letterSpacing: 0,
    ),
    displaySmall: base.textTheme.displaySmall!.copyWith(
      color: AppColors.onSecondaryDark,
      fontWeight: FontWeight.w400,
      fontSize: 12,
      letterSpacing: 0,
    ),
    headlineMedium: base.textTheme.headlineMedium!.copyWith(
      color: AppColors.onSecondaryDark,
      fontWeight: FontWeight.w600,
      fontSize: 12,
      letterSpacing: 0,
    ),
    headlineLarge: base.textTheme.headlineLarge!.copyWith(
      color: AppColors.onBackgroundDark,
      fontWeight: FontWeight.w600,
      fontSize: 16,
      letterSpacing: 0,
    ),
    headlineSmall: base.textTheme.headlineSmall!.copyWith(
      color: AppColors.onSecondaryDark,
      fontWeight: FontWeight.w700,
      fontSize: 15,
      letterSpacing: 0,
    ),
    bodyLarge: base.textTheme.bodyLarge!.copyWith(
      color: AppColors.onPrimaryDark,
      fontWeight: FontWeight.w700,
      fontSize: 14,
      letterSpacing: 0,
    ),
    bodyMedium: base.textTheme.bodyMedium!.copyWith(
      color: AppColors.onSecondaryDark,
      fontWeight: FontWeight.w700,
      fontSize: 10,
      letterSpacing: 0,
    ),
    labelSmall: base.textTheme.labelSmall!.copyWith(
      color: AppColors.onPrimaryDark,
      fontWeight: FontWeight.w500,
      fontSize: 14,
      letterSpacing: 0,
    ),
    titleMedium: base.textTheme.titleMedium!.copyWith(
      color: AppColors.onSecondaryDark,
      fontWeight: FontWeight.w600,
      fontSize: 11,
      letterSpacing: 0,
    ),
    labelLarge: base.textTheme.labelLarge!.copyWith(
      color: AppColors.onSecondaryDark,
      fontWeight: FontWeight.w600,
      fontSize: 16,
      letterSpacing: 0,
    ),
    titleSmall: base.textTheme.titleSmall!.copyWith(
      color: AppColors.onSecondaryDark,
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
        return AppColors.primaryDark;
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
        return AppColors.primaryDark;
      }
      return null;
    }),
  ),
  switchTheme: base.switchTheme
      .copyWith(
    trackColor: const WidgetStatePropertyAll(AppColors.primaryDark),
    thumbColor: const WidgetStatePropertyAll(AppColors.dark),
  )
      .copyWith(
    thumbColor: WidgetStateProperty.resolveWith<Color?>((states) {
      if (states.contains(WidgetState.disabled)) {
        return null;
      }
      if (states.contains(WidgetState.selected)) {
        return AppColors.primaryDark;
      }
      return null;
    }),
    trackColor: WidgetStateProperty.resolveWith<Color?>((states) {
      if (states.contains(WidgetState.disabled)) {
        return null;
      }
      if (states.contains(WidgetState.selected)) {
        return AppColors.primaryDark;
      }
      return null;
    }),
  ),
);
