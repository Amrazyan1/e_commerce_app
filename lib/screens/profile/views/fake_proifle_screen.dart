import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class FakeProifleScreen extends StatelessWidget {
  const FakeProifleScreen({super.key, required this.pageName});
  final String pageName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text(pageName)));
  }
}
