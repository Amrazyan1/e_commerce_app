import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:e_commerce_app/Provider/main_provider.dart';
import 'package:e_commerce_app/components/search_bar_input_field.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/router/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<CategoryItem> categories = [
      CategoryItem(
        imageUrl:
            'assets/images/category_1.png', // Replace with actual image URLs
        groupName: 'Category 1',
      ),
      CategoryItem(
        imageUrl: 'assets/images/category_2.png',
        groupName: 'Category 2',
      ),
      CategoryItem(
        imageUrl: 'assets/images/category_3.png',
        groupName: 'Category 3',
      ),
      CategoryItem(
        imageUrl: 'assets/images/category_4.png',
        groupName: 'Category 4',
      ),
      CategoryItem(
        imageUrl: 'assets/images/category_5.png',
        groupName: 'Category 5',
      ),
      CategoryItem(
        imageUrl: 'assets/images/category_6.png',
        groupName: 'Category 6',
      ),
      CategoryItem(
        imageUrl: 'assets/images/category_6.png',
        groupName: 'Category 7',
      ),
      // Add more CategoryItem instances as needed
    ];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Find Products',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(25),
            child: SearchInputField(),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: GridView.builder(
                physics: BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                  childAspectRatio: 174.5 / 189, // Match item dimensions
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final item = categories[index];
                  return _categoryItem(item: item);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _categoryItem extends StatelessWidget {
  const _categoryItem({
    super.key,
    required this.item,
  });

  final CategoryItem item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<MainProvider>().categoryName = item.groupName;
        AutoRouter.of(context).push(DiscoverDetailsRoute());
      },
      child: Container(
        width: 174.5,
        height: 189,
        decoration: BoxDecoration(
          color: ksecondaryColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Color(0xFFD2B7E5)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              item.imageUrl,
              width: 100,
              height: 100,
            ),
            SizedBox(height: 10),
            Text(
              item.groupName,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryItem {
  final String imageUrl;
  final String groupName;

  CategoryItem({
    required this.imageUrl,
    required this.groupName,
  });
}
