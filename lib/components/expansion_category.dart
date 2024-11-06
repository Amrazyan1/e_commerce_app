import 'package:e_commerce_app/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../constants.dart';

class ExpansionCategory extends StatelessWidget {
  const ExpansionCategory({
    super.key,
    required this.title,
    required this.info,
    required this.subCategory,
  });

  final String title; // svgSrc;
  final String info; // svgSrc;

  final List<CategoryModel> subCategory;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      iconColor: Theme.of(context).textTheme.bodyLarge!.color,
      collapsedIconColor: Theme.of(context).textTheme.bodyMedium!.color,
      // trailing: Text('trailing'),
      title: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween, // Ensures text is at the end
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 14),
          ),
          Text(
            info, // Add your text at the end
            style: const TextStyle(
                fontSize: 14, color: Colors.grey), // Optional style
          ),
        ],
      ),

      textColor: Theme.of(context).textTheme.bodyLarge!.color,
      childrenPadding: const EdgeInsets.only(left: defaultPadding),
      children: List.generate(
        subCategory.length,
        (index) => Column(
          children: [
            ListTile(
              onTap: () {},
              title: Text(
                subCategory[index].title,
                style: const TextStyle(fontSize: 14),
              ),
              trailing: Text(subCategory[index].info),
            ),
            if (index < subCategory.length - 1) const Divider(height: 1),
          ],
        ),
      ),
    );
  }
}
