import 'dart:developer';

import 'package:e_commerce_app/blocs/categorydetails/bloc/copy/bloc/category_detail_copy_bloc.dart';
import 'package:e_commerce_app/components/checkout_modal.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../blocs/categorydetails/bloc/category_detail_bloc.dart';
import '../../../blocs/categorydetails/bloc/category_detail_state.dart';

class FilterScreen extends StatefulWidget {
  FilterScreen({super.key, required this.isFirst});
  bool isFirst = true;
  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  Map<String, Map<String, bool>> filterSelections = {};

  @override
  Widget build(BuildContext context) {
    return widget.isFirst ? _catDetailBloc() : _catDetailCopyBloc();
  }

  Scaffold _catDetailBloc() {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Filters',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: BlocBuilder<CategoryDetailBloc, CategoryDetailState>(
        builder: (context, state) {
          if (state is CategoryDetailLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CategoryDetailLoaded) {
            final filters = state.filters ?? {};
            // Initialize filterSelections
            filters.forEach((key, value) {
              if (!filterSelections.containsKey(key)) {
                filterSelections[key] = {};
                if (value is List) {
                  for (var item in value) {
                    filterSelections[key]![item.toString()] = false;
                  }
                } else if (value is Map) {
                  value.forEach((subKey, subValue) {
                    filterSelections[key]![subKey.toString()] = false;
                  });
                } else {
                  filterSelections[key]![value.toString()] = false;
                }
              }
            });

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        const Text(
                          'Filter by:',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        // Render checkboxes dynamically
                        ...filters.entries.map((entry) =>
                            _buildDynamicCheckboxSection(
                                entry.key, entry.value)),
                      ],
                    ),
                  ),
                  _catDetailCopyBloc(),
                  SizedBox(
                      height: 50,
                      child: ButtonMainWidget(
                        text: 'Apply filter',
                        callback: _applyFilters,
                      )),
                ],
              ),
            );
          } else {
            return const Center(child: Text('Failed to load filters'));
          }
        },
      ),
    );
  }

  Scaffold _catDetailCopyBloc() {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Filters',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: BlocBuilder<CategoryDetailCopyBloc, CategoryDetailCopyState>(
        builder: (context, state) {
          if (state is CategoryDetailCopyLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CategoryDetailCopyLoaded) {
            final filters = state.filters ?? {};
            // Initialize filterSelections
            filters.forEach((key, value) {
              if (!filterSelections.containsKey(key)) {
                filterSelections[key] = {};
                if (value is List) {
                  for (var item in value) {
                    filterSelections[key]![item.toString()] = false;
                  }
                } else if (value is Map) {
                  value.forEach((subKey, subValue) {
                    filterSelections[key]![subKey.toString()] = false;
                  });
                } else {
                  filterSelections[key]![value.toString()] = false;
                }
              }
            });

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        const Text(
                          'Filter by:',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        // Render checkboxes dynamically
                        ...filters.entries.map((entry) =>
                            _buildDynamicCheckboxSection(
                                entry.key, entry.value)),
                      ],
                    ),
                  ),
                  _catDetailCopyBloc(),
                  SizedBox(
                      height: 50,
                      child: ButtonMainWidget(
                        text: 'Apply filter',
                        callback: _applyFilters,
                      )),
                ],
              ),
            );
          } else {
            return const Center(child: Text('Failed to load filters'));
          }
        },
      ),
    );
  }

  Widget _buildDynamicCheckboxSection(String title, dynamic value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(title),
        if (value is List)
          ...value.map((item) {
            // Ensure the filterSelections map is initialized
            filterSelections[title] ??= {};
            filterSelections[title]![item.toString()] ??= false;

            // Render checkboxes for list items
            return CheckboxListTile(
              title: Text(item.toString()),
              activeColor: ksecondaryColor,
              value: filterSelections[title]![item.toString()],
              onChanged: (isChecked) {
                setState(() {
                  filterSelections[title]![item.toString()] = isChecked!;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            );
          }),
        if (value is Map)
          ...value.entries.map((entry) {
            // Ensure the filterSelections map is initialized
            filterSelections[title] ??= {};
            final label = '${entry.key}: ${entry.value}';
            filterSelections[title]![label] ??= false;

            // Render checkboxes for key-value pairs
            return CheckboxListTile(
              title: Text(label),
              activeColor: ksecondaryColor,
              value: filterSelections[title]![label],
              onChanged: (isChecked) {
                setState(() {
                  filterSelections[title]![label] = isChecked!;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            );
          }),
        if (value is String || value is num)
          CheckboxListTile(
            title: Text(value.toString()),
            activeColor: ksecondaryColor,
            value: filterSelections[title]![value.toString()] ??= false,
            onChanged: (isChecked) {
              setState(() {
                filterSelections[title]![value.toString()] = isChecked!;
              });
            },
            controlAffinity: ListTileControlAffinity.leading,
          ),
        Divider(),
      ],
    );
  }

  void _applyFilters() {
    final selectedFilters = filterSelections.map((key, options) {
      return MapEntry(
        key,
        options.entries
            .where((entry) => entry.value) // Only selected items
            .map((entry) => entry.key)
            .toList(),
      );
    });

    log('Selected Filters: $selectedFilters');
    buildFilterQuery(filterSelections);
    // Send `selectedFilters` to the server in your desired format
  }

  String buildFilterQuery(Map<String, Map<String, bool>> filterSelections) {
    final Map<String, dynamic> queryParameters = {};

    filterSelections.forEach((key, values) {
      final selectedValues = values.entries
          .where((entry) => entry.value) // Include only selected values
          .map((entry) => entry.key)
          .toList();

      if (selectedValues.isNotEmpty) {
        queryParameters['filters[$key][]'] = selectedValues;
      }
    });
    print(queryParameters);
    return Uri(queryParameters: queryParameters).query;
  }

  // Section title widget
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      ),
    );
  }
}
