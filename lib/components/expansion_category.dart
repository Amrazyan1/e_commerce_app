import 'dart:developer';

import 'package:e_commerce_app/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../../../../constants.dart';

class ExpansionCategory extends StatefulWidget {
  const ExpansionCategory(
      {super.key,
      required this.title,
      required this.info,
      required this.subCategory,
      this.onCategorySelected,
      this.ignoreExpansion = false,
      this.isCheckbox = false});
  final bool? ignoreExpansion; // svgSrc;
  final bool isCheckbox; // svgSrc;

  final String title; // svgSrc;
  final String info; // svgSrc;

  final List<CategoryModel> subCategory;
  final ValueChanged<CategoryModel>?
      onCategorySelected; // Callback for selection
  @override
  State<ExpansionCategory> createState() => _ExpansionCategoryState();
}

class _ExpansionCategoryState extends State<ExpansionCategory> {
  String selectedInfo = '';
  bool expanded = false;
  CategoryModel? selectedCategory;
  bool checked = false;
  @override
  void initState() {
    super.initState();
    if (widget.subCategory.isNotEmpty) {
      var selectedCategory =
          widget.subCategory.where((x) => x.isSelected == true).isNotEmpty
              ? widget.subCategory.where((x) => x.isSelected == true).first
              : null; // Handle this default case appropriately

      selectedInfo = selectedCategory!.info;

      if (widget.onCategorySelected != null && selectedCategory != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          widget.onCategorySelected!(selectedCategory!);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.subCategory.isNotEmpty
        ? IgnorePointer(
            ignoring: widget.ignoreExpansion!,
            child: ExpansionTile(
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
                        setState(() {
                          selectedInfo = widget.subCategory[index].info;
                          expanded = false;

                          if (widget.onCategorySelected != null) {
                            widget.onCategorySelected!(
                                widget.subCategory[index]!);
                          }
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
            ? CheckboxListTile(
                title: Text(widget.title + ' ' + widget.info),
                activeColor: ksecondaryColor,
                value: checked,
                onChanged: (isChecked) {
                  setState(() {
                    checked = isChecked!;
                    selectedInfo = widget.info;
                    expanded = false;

                    if (widget.onCategorySelected != null) {
                      widget.onCategorySelected!(CategoryModel(
                          title: 'checkbox',
                          info: '$isChecked',
                          isCheckbox: true));
                    }
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
              )
            // Checkbox(

            //     value: subCategory.isChecked ?? false,
            //     onChanged: (value) {
            //       setState(() {
            //         selectedInfo = widget.info;
            //         expanded = false;

            //         if (widget.onCategorySelected != null) {
            //           widget.onCategorySelected!(
            //               CategoryModel(title: 'checkbox', info: '$value'));
            //         }
            //       });
            //     },
            //   )
            : ListTile(
                title: Text(
                  widget.title,
                  style: const TextStyle(fontSize: 14),
                ),
                subtitle: Text(
                  widget.info,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              );
  }
}
