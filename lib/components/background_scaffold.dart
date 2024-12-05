import 'package:e_commerce_app/components/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';

import '../extensions/context_extension.dart';
import 'blur_box.dart';

class BackgroundScaffold extends StatelessWidget {
  const BackgroundScaffold({
    super.key,
    this.title,
    this.backgroundAnimation = true,
    this.resizeToAvoidBottomInset = false,
    this.spaceAnimation = false,
    this.hasAppBar = true,
    this.hasTitle = false,
    this.centerTitle = true,
    this.hasLeading = true,
    this.extendBodyBehindAppBar = true,
    this.child,
    this.leading,
    this.bottomNavigationBar,
    this.toolbarHeight = 60,
    this.titleSpacing,
    this.clipBehavior,
    this.bottom,
    this.hasMorphingAnimation = false,
    this.actions,
    this.showAppBarDivider = true,
    this.addAppBarHeightToBody = false,
    this.backButtonAction,
    this.backButtonIcon,
    this.isBlur = true,
    this.backgroundColor,
    this.backButtonVector,
    this.appBarColor,
    this.appBarDividerColor,
    this.backIconColor,
    this.backIconTitle,
    this.leadingWidth,
  });

  final Widget? title;
  final IconData? backButtonIcon;
  final String? backButtonVector;
  final double? toolbarHeight;
  final double? titleSpacing;
  final bool backgroundAnimation;
  final bool spaceAnimation;
  final bool hasAppBar;
  final bool hasTitle;
  final bool centerTitle;
  final bool hasLeading;
  final bool extendBodyBehindAppBar;
  final bool resizeToAvoidBottomInset;
  final Widget? child;
  final Widget? leading;
  final Widget? bottomNavigationBar;
  final Clip? clipBehavior;
  final PreferredSizeWidget? bottom;
  final bool hasMorphingAnimation;
  final List<Widget>? actions;
  final bool showAppBarDivider;
  final bool addAppBarHeightToBody;
  final VoidCallback? backButtonAction;
  final bool isBlur;
  final Color? backgroundColor;
  final Color? appBarColor;
  final Color? appBarDividerColor;
  final Color? backIconColor;
  final String? backIconTitle;
  final double? leadingWidth;

  @override
  Widget build(BuildContext context) {
    final preferredSize = hasAppBar
        ? PreferredSize(
            preferredSize: Size.fromHeight(
              (toolbarHeight ?? kToolbarHeight) +
                  (bottom?.preferredSize.height ?? 0),
            ),
            child: DecoratedBox(
              position: DecorationPosition.foreground,
              decoration: BoxDecoration(
                border: showAppBarDivider
                    ? Border(
                        bottom: Divider.createBorderSide(
                          context,
                          color: appBarDividerColor ??
                              Theme.of(context)
                                  .bottomAppNavBarColor
                                  .withOpacity(0.4),
                        ),
                      )
                    : null,
              ),
              child: BlurBox(
                isBlur: isBlur,
                child: hasMorphingAnimation
                    ? MorphingAppBar(
                        //clipBehavior: clipBehavior,
                        toolbarHeight: toolbarHeight,
                        leadingWidth: leadingWidth,
                        titleSpacing: titleSpacing,
                        backgroundColor: appBarColor,
                        leading: hasLeading
                            ? leading ??
                                CustomIconButton(
                                  size: 25,
                                  icon: backButtonIcon,
                                  vector: backButtonVector,
                                  action: backButtonAction,
                                  withBorder: false,
                                  iconColor: backIconColor,
                                  title: backIconTitle,
                                )
                            : null,
                        automaticallyImplyLeading: false,
                        centerTitle: centerTitle,
                        titleTextStyle: context.theme.titleLarge.copyWith(
                          fontSize: 20,
                        ),
                        title: title,
                        bottom: bottom,
                        actions: actions,
                      )
                    : AppBar(
                        clipBehavior: clipBehavior,
                        toolbarHeight: toolbarHeight,
                        titleSpacing: titleSpacing,
                        leadingWidth: leadingWidth,
                        backgroundColor: appBarColor ??
                            context.theme.appBarTheme.backgroundColor,
                        leading: hasLeading
                            ? leading ??
                                CustomIconButton(
                                  size: 25,
                                  icon: backButtonIcon,
                                  vector: backButtonVector,
                                  action: backButtonAction,
                                  withBorder: false,
                                  iconColor: backIconColor,
                                  title: backIconTitle,
                                )
                            : null,
                        automaticallyImplyLeading: false,
                        centerTitle: centerTitle,
                        title: title,
                        bottom: bottom,
                        actions: actions,
                      ),
              ),
            ),
          )
        : null;

    final _child = Stack(
      children: [
        child!,
      ],
    );

    return Scaffold(
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      backgroundColor: backgroundColor ?? context.theme.background,
      bottomNavigationBar: bottomNavigationBar,
      appBar: preferredSize,
      body: _child,
    );
  }
}
