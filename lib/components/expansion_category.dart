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
  TextEditingController _controller = TextEditingController();
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _controller.selection = TextSelection(
          baseOffset: 0,
          extentOffset: _controller.text.length,
        );
      }
    });
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
      _controller.text = widget.info;
      log(widget.info);
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
            ? Row(
                children: [
                  Text('${widget.title} ${widget.info} '),
                  Flexible(
                    // width: 40,
                    child: TextFormField(
                      controller: _controller,
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
                          if (newValue > maxCount) {
                            // Trim the value to maxCount if it exceeds
                            _controller.text = '$maxCount';

                            // Move cursor to the end of the text
                            _controller.selection = TextSelection.fromPosition(
                              TextPosition(offset: _controller.text.length),
                            );
                          } else {
                            if (widget.onCategorySelected != null) {
                              widget.onCategorySelected!(CategoryModel(
                                title: '$newValue',
                                info: '',
                                isCheckbox: true,
                              ));
                            }
                          }
                        }
                      },
                    ),
                  ),
                ],
              )
            // CheckboxListTile(
            //     title: Text(widget.title + ' ' + widget.info),
            //     activeColor: ksecondaryColor,
            //     value: checked,
            //     onChanged: (isChecked) {
            //       setState(() {
            //         checked = isChecked!;
            //         selectedInfo = widget.info;
            //         expanded = false;

            //         if (widget.onCategorySelected != null) {
            //           widget.onCategorySelected!(CategoryModel(
            //               title: 'checkbox',
            //               info: '$isChecked',
            //               isCheckbox: true));
            //         }
            //       });
            //     },
            //     controlAffinity: ListTileControlAffinity.leading,
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
