import 'dart:developer';

import 'package:e_commerce_app/Provider/main_provider.dart';
import 'package:e_commerce_app/components/always_notify.dart';
import 'package:e_commerce_app/components/checkout_modal.dart';
import 'package:e_commerce_app/models/category_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../../../../constants.dart';

final GlobalKey _expansionTileKey = GlobalKey();

class ExpansionCategory extends StatefulWidget {
  const ExpansionCategory(
      {super.key,
      required this.title,
      required this.info,
      required this.subCategory,
      this.onCategorySelected,
      this.ignoreExpansion = false,
      this.deselectNotifier = null,
      this.controller,
      this.isCoupon = false,
      this.isCheckbox = false});
  final bool? ignoreExpansion;
  final bool isCheckbox;
  final bool isCoupon;
  final String title;
  final String info;
  final TextEditingController? controller;

  final List<CategoryModel> subCategory;
  final ValueChanged<CategoryModel?>? onCategorySelected;
  final AlwaysNotifyValueNotifier<bool>? deselectNotifier;
  @override
  State<ExpansionCategory> createState() => _ExpansionCategoryState();
}

class _ExpansionCategoryState extends State<ExpansionCategory> {
  String selectedInfo = '';
  int? selectedIndex; // Track the currently selected index
  bool expanded = false;
  CategoryModel? selectedCategory;
  bool checked = false;
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    if (widget.controller != null) {
      _focusNode.addListener(() {
        if (_focusNode.hasFocus) {
          widget.controller?.selection = TextSelection(
            baseOffset: 0,
            extentOffset: widget.controller!.text.length,
          );
        }
      });
    }

    if (widget.subCategory.isNotEmpty) {
      var selectedCategory =
          widget.subCategory.where((x) => x.isSelected == true).isNotEmpty
              ? widget.subCategory.where((x) => x.isSelected == true).first
              : null; // Handle this default case appropriately

      selectedInfo = selectedCategory?.info ?? '';

      if (widget.onCategorySelected != null && selectedCategory != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          widget.onCategorySelected!(selectedCategory!);
        });
      }
    }
    if (widget.isCheckbox) {
      widget.controller!.text = '0';
      log(widget.info);
    }
    if (widget.isCoupon) {
      widget.deselectNotifier?.addListener(_handleDeselect);
    }
  }

  void _handleDeselect() {
    setState(() {
      // if (selectedCategory != null && selectedCategory!.couponId.isNotEmpty)
      {
        selectedIndex = null;
        selectedInfo = '';
      }
    });
  }

  ExpansionTileController _expcontroller = ExpansionTileController();
  @override
  void dispose() {
    // Remove the listener to avoid memory leaks
    widget.deselectNotifier?.removeListener(_handleDeselect);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.subCategory.isNotEmpty
        ? IgnorePointer(
            ignoring: widget.ignoreExpansion!,
            child: ExpansionTile(
              controller: _expcontroller,
              iconColor: Theme.of(context).textTheme.bodyLarge!.color,
              collapsedIconColor: Theme.of(context).textTheme.bodyMedium!.color,
              title: Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceBetween, // Ensures text is at the end
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(fontSize: 14),
                  ),
                  const Gap(50),
                  Flexible(
                    child: Text(
                      overflow: TextOverflow.ellipsis,
                      selectedInfo.isEmpty ? widget.info : selectedInfo,
                      style: const TextStyle(
                          fontSize: 14, color: Colors.grey), // Optional style
                    ),
                  ),
                ],
              ),
              onExpansionChanged: (value) {
                log('onExpansionChanged');

                setState(() {
                  expanded = value;
                });
              },
              textColor: Theme.of(context).textTheme.bodyLarge!.color,
              childrenPadding: const EdgeInsets.only(left: defaultPadding),
              children: List.generate(
                widget.subCategory.length,
                (index) => Column(
                  children: [
                    ListTile(
                      onTap: () {
                        _expcontroller.collapse();
                        setState(() {
                          if (selectedIndex == index) {
                            // Deselect the item if it's already selected
                            selectedIndex = null;
                            selectedInfo = '';
                            if (widget.onCategorySelected != null) {
                              widget.onCategorySelected!(null);
                            }
                          } else {
                            // Select the new item
                            selectedIndex = index;
                            selectedInfo = widget.subCategory[index].info;

                            if (widget.onCategorySelected != null) {
                              widget.onCategorySelected!(
                                  widget.subCategory[index]);
                            }
                          }

                          // selectedInfo = widget.subCategory[index].info;

                          // if (widget.onCategorySelected != null) {
                          //   widget.onCategorySelected!(
                          //       widget.subCategory[index]!);
                          // }
                        });
                      },
                      title: Row(
                        children: [
                          Flexible(
                            child: Text(
                              overflow: TextOverflow.ellipsis,
                              widget.subCategory[index].title,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                      trailing: SizedBox(
                        width: 100,
                        child: Text(
                            overflow: TextOverflow.ellipsis,
                            widget.subCategory[index].info ?? ''),
                      ),
                    ),
                    if (index < widget.subCategory.length - 1)
                      const Divider(height: 1),
                  ],
                ),
              ),
            ),
          )
        : widget.isCheckbox
            ? Row(
                children: [
                  Flexible(
                      flex: 2,
                      child: Text(
                        '${widget.title} ${widget.info} ',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      )),
                  Flexible(
                    flex: 1,
                    child: TextFormField(
                      controller: widget.controller!,
                      focusNode: _focusNode,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                            borderSide: BorderSide(color: Colors.white)),
                        isDense: true,
                        contentPadding: EdgeInsets.only(
                            left: 0, right: 0, top: 10, bottom: 10),
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        num? newValue = num.tryParse(value);
                        num? maxCount = num.tryParse(widget.info);

                        if (newValue != null && maxCount != null) {
                          log('${context.read<MainProvider>().checkoutTotal}');
                          maxCount = maxCount >
                                  context.read<MainProvider>().checkoutTotal
                              ? context.read<MainProvider>().checkoutTotal
                              : maxCount;
                          if (newValue > maxCount) {
                            // Trim the value to maxCount if it exceeds
                            widget.controller!.text = '$maxCount';

                            // Move cursor to the end of the text
                            widget.controller!.selection =
                                TextSelection.fromPosition(
                              TextPosition(
                                  offset: widget.controller!.text.length),
                            );
                          } else {}
                        }
                      },
                    ),
                  ),
                  Flexible(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: SizedBox(
                            height: 45,
                            child: ButtonMainWidget(
                              text: 'use_b'.tr(),
                              callback: () {
                                if (widget.onCategorySelected != null) {
                                  widget.onCategorySelected!(CategoryModel(
                                    title: widget.controller!.text,
                                    info: '',
                                    isCheckbox: true,
                                  ));
                                }
                              },
                            )),
                      ))
                ],
              )
            : Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        widget.title,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        widget.info,
                        style:
                            const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              );
  }
}
