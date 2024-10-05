import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Discover'));
  }
}
