import 'package:e_commerce_app/components/checkout_modal.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  // Sample data for checkboxes
  Map<String, bool> categories = {
    'Eggs': false,
    'Pasta': false,
    'Bread': false,
  };
  Map<String, bool> brands = {
    'BrandName1': false,
    'BrandName2': false,
    'BrandName3': false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Filters',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Text(
                    'Filter by:',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),

                  // Categories Section
                  _buildSectionTitle('Categories'),
                  ...categories.keys
                      .map((item) => _buildCheckBoxItem(item, categories))
                      .toList(),
                  Divider(),

                  // Brands Section
                  _buildSectionTitle('Brand'),
                  ...brands.keys
                      .map((item) => _buildCheckBoxItem(item, brands))
                      .toList(),
                ],
              ),
            ),
            SizedBox(height: 50, child: ButtonMainWidget(text: 'Apply filter')),
          ],
        ),
      ),
    );
  }

  // Section Title
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      ),
    );
  }

  // Checkbox Item
  Widget _buildCheckBoxItem(String title, Map<String, bool> dataMap) {
    return CheckboxListTile(
      title: Text(title),
      activeColor: ksecondaryColor,
      value: dataMap[title],
      onChanged: (value) {
        setState(() {
          dataMap[title] = value!;
        });
      },
      controlAffinity: ListTileControlAffinity.leading,
    );
  }
}
