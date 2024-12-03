import 'dart:developer';

import 'package:e_commerce_app/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../../../../constants.dart';

class ExpansionCategory extends StatefulWidget {
  const ExpansionCategory({
    super.key,
    required this.title,
    required this.info,
    required this.subCategory,
    this.onCategorySelected,
  });

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

  @override
  void initState() {
    super.initState();
    // Set default values to the first item if the list is not empty
    if (widget.subCategory.isNotEmpty) {
      selectedCategory = widget.subCategory.first;
      selectedInfo = selectedCategory!.info;

      // Trigger the callback if provided, to inform parent about the default selection
      if (widget.onCategorySelected != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          widget.onCategorySelected!(selectedCategory!);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.subCategory.isNotEmpty
        ? ExpansionTile(
            iconColor: Theme.of(context).textTheme.bodyLarge!.color,
            collapsedIconColor: Theme.of(context).textTheme.bodyMedium!.color,
            title: Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween, // Ensures text is at the end
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
                          widget
                              .onCategorySelected!(widget.subCategory[index]!);
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
          )
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
