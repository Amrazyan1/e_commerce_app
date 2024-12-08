import 'dart:convert'; // For JSON decoding
import 'package:auto_route/annotations.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

@RoutePage()
class FakeProifleScreen extends StatelessWidget {
  const FakeProifleScreen({super.key, required this.pageName});
  final String pageName;

  List<Widget> _buildHelpInfo(BuildContext context) {
    // Decode the JSON string from easy_localization
    final String rawJson = tr('help_info'); // Fetch JSON as a string
    final List<dynamic> helpInfo =
        json.decode(rawJson); // Decode the JSON string

    return helpInfo.map<Widget>((item) {
      switch (item['type']) {
        case 'header':
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              item['text'],
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          );
        case 'question':
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Text(
              item['text'],
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
          );
        case 'answer':
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: Text(
              item['text'],
              style: const TextStyle(fontSize: 14),
            ),
          );
        default:
          return const SizedBox.shrink();
      }
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'help'.tr(),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _buildHelpInfo(context),
          ),
        ),
      ),
    );
  }
}
