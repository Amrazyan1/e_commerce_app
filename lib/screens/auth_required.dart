import 'package:auto_route/auto_route.dart';
import 'package:e_commerce_app/router/router.gr.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthorizationRequiredPopup extends StatelessWidget {
  const AuthorizationRequiredPopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'auth_req'.tr(),
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      content: Text(
        'you_need'.tr(),
        style: const TextStyle(fontSize: 16),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false); // User canceled
          },
          child: Text('cancel'.tr()),
        ),
        ElevatedButton(
          onPressed: () {
            AutoRouter.of(context).replaceAll([const AuthorizationRoute()]);
          },
          child: Text('authorize'.tr()),
        ),
      ],
    );
  }
}

// Function to show the popup
Future<bool> showAuthorizationPopup(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  String? authToken = prefs.getString('auth_token');

  if (authToken != null && authToken.isNotEmpty) {
    return true; // User is already authorized
  }
  showDialog<bool>(
    context: context,
    builder: (_) => const AuthorizationRequiredPopup(),
  );
  return false;
  // Show the popup if not authorized
  return await showDialog<bool>(
    context: context,
    builder: (_) => const AuthorizationRequiredPopup(),
  ).then((value) => value ?? false); // Return false if dialog is dismissed
}
