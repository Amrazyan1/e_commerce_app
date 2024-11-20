import 'dart:developer';

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:e_commerce_app/Provider/main_provider.dart';
import 'package:e_commerce_app/blocs/categories/bloc/categories_event.dart';
import 'package:e_commerce_app/components/search_bar_input_field.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/models/category_model_real.dart';
import 'package:e_commerce_app/router/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../blocs/categories/bloc/categories_bloc.dart';
import '../../../blocs/categories/bloc/categories_state.dart';

@RoutePage()
class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final List<List<Category>> _categoryStack =
      []; // Stack to keep track of navigation

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _handleBackNavigation,
      child: Scaffold(
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
                child: BlocBuilder<CategoriesBloc, CategoriesState>(
                  builder: (context, state) {
                    if (state is CategoriesLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is CategoriesLoaded) {
                      return GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 8.0,
                          crossAxisSpacing: 8.0,
                          childAspectRatio: 174.5 / 189,
                        ),
                        itemCount: state.categories.length,
                        itemBuilder: (context, index) {
                          final category = state.categories[index];
                          return _categoryItem(
                            category: category,
                          );
                        },
                      );
                    } else if (state is CategoriesError) {
                      return Center(child: Text('Error: ${state.error}'));
                    }
                    return const Center(child: Text('No Data'));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _handleBackNavigation() async {
    log('${_categoryStack.length}');
    if (_categoryStack.length > 1) {
      _categoryStack.removeLast(); // Remove current category
      final previousCategories = _categoryStack.last;

      context.read<CategoriesBloc>().add(
            FetchSubcategories(
                previousCategories.first), // Go back to previous category
          );

      return false; // Prevent the app from closing
    }
    return true; // Allow the app to close
  }
}

class _categoryItem extends StatelessWidget {
  const _categoryItem({
    super.key,
    required this.category,
  });

  final Category category;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if ((category.subcategories ?? []).isNotEmpty) {
          AutoRouter.of(context).push(const DiscoverRoute());
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (_) => DiscoverScreen(
          //         // categories: category.subcategories, // Pass subcategories
          //         ),
          //   ),
          // );
          context.read<CategoriesBloc>().add(FetchSubcategories(category));
        } else {
          context.read<MainProvider>().categoryName =
              category.name ?? 'Unknown';
          AutoRouter.of(context).push(DiscoverDetailsRoute());

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${category.name} has no subcategories')),
          );
        }
      },
      child: Container(
        width: 174.5,
        height: 189,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: ksecondaryColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFD2B7E5)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildImage(category.image),
            const SizedBox(height: 10),
            Flexible(
              child: Text(
                category.name ?? 'Unknown',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
                maxLines: 3, // Limit the number of lines
                overflow:
                    TextOverflow.ellipsis, // Add ellipsis if text overflows
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(String? imageUrl) {
    if (imageUrl == null || imageUrl.isEmpty) {
      return const Icon(Icons.image_not_supported, size: 60);
    }

    if (imageUrl.endsWith('.svg')) {
      return SvgPicture.network(
        imageUrl,
        width: 60,
        height: 60,
        placeholderBuilder: (context) => const CircularProgressIndicator(),
        // errorBuilder: (context, error, stackTrace) =>
        //     const Icon(Icons.error, size: 60),
      );
    } else {
      return Image.network(
        imageUrl,
        width: 60,
        height: 60,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) =>
            const Icon(Icons.error, size: 60),
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          return const CircularProgressIndicator();
        },
      );
    }
  }
}
